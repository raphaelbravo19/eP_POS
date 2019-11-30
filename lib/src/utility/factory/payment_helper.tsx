import Order from './order';
import PaymentService from './utils/PaymentService';
import * as event_names from './api/constants_events';
import PaymentResponse from './payment_response';
import {
  OrderType,
  PaymentResponseType,
} from '../interfaces/payment_interfaces';
import * as _ from 'lodash';
import { handleError } from './utils/handlerError';
import { AsyncStorage } from 'react-native';
interface PaymentConfigs {
  roundOff?: boolean;
}
export default class PaymentHelper extends PaymentService {
  order: OrderType;
  paymentCurrencyId: number;
  paymentAmount: number;
  paymentTipAmount: number;
  paymentSubTotal: number;
  paymentTotalDiscount: number;
  paymentCustomerId: string;
  created_at: number;
  location: string;
  customFieldArray: any[];
  paymentResponse: PaymentResponseType;
  configs: PaymentConfigs;
  paymentId: number;
  transactionId: number;
  transactions: any[];
  tenderingChange: any;
  split: any;
  method: any;
  customFielsAdded: boolean;
  constructor() {
    super();
    this.configs = {};
    // if (order.paymentId) {
    //   this.paymentId = order.paymentId;
    // }
    // if (order.transactionId) {
    //   this.transactionId = order.transactionId;
    // }
    // if (order instanceof Order) {
    //   this.order = order
    //   this.order.setConfigs(configs);
    // } else {
    //   this.order = new Order(order, configs);
    //   this.order.update();
    // }

    this.paymentCurrencyId = 25;
    this.paymentTipAmount = 0;

    this.paymentCustomerId = '';
    this.created_at = +new Date() / 1000;
    this.location = '0.0,0.0';
    this.customFieldArray = [];
    this.paymentResponse = new PaymentResponse();
    this.transactions = [];
  }

  addCustomFields(fields) {
    this.customFieldArray = fields.getCustomFields();
    this.customFielsAdded = true;
    this.emit(event_names.CUSTOM_FIELDS_ADDED);
  }

  setSplit(value) {
    this.split = value;
  }

  setPaymentCustomerId(value) {
    //alert(value)
    this.paymentCustomerId = value + '';
  }

  setMethod(value) {
    this.method = value;
  }

  setOrder(order) {
    this.order = order;
    this.update();
  }
  update() {
    this.paymentAmount = parseFloat(this.order.totalPrice.toFixed(2));
    this.paymentSubTotal = parseFloat(this.order.subTotal.toFixed(2));
    this.paymentTotalDiscount = this.order.totalDiscount;
  }

  getRequest() {
    const payment_data = _.pick(this, [
      'paymentCurrencyId',
      'paymentAmount',
      'paymentTipAmount',
      'paymentSubTotal',
      'paymentTotalDiscount',
      'paymentCustomerId',
      'created_at',
      'location',
      'customFieldArray',
      'paymentResponse',
    ]);
    const order = this.order.getRequest();

    return {
      ...payment_data,
      order,
    };
  }

  async payWithCash(next, offline = false): Promise<any> {
    // offline = true;
    try {
      this.emit(event_names.REQUEST);

      const pay_request = await this.cashPaymentRequest(
        [this.getRequest()],
        offline
      );
      if (!offline) {
        if (!pay_request.success) {
          throw new Error(pay_request.message);
        }
        const { success, ...steps } = pay_request.response[0];
        let error = 'An error has ocurred, try again!';
        if (!success) {
          for (const key in steps) {
            if (!steps[key].success) {
              error = steps[key].message;
              break;
            }
          }
          throw new Error(error);
        }

        this.paymentResponse = new PaymentResponse(pay_request.response[0]);
        this.paymentResponse.setChange(this.tenderingChange);
        this.setChange(0);
        this.transactions.push(this.paymentResponse);
        console.log({ transactions_frao: this.transactions });
        this.emit(event_names.DONE);
        this.emit('TransactionSuccessful');
        if (this.getAmountToPay() <= 0) {
          this.emit(event_names.PAYMENT_SUCCESFULL);
        }
      } else {
        this.paymentResponse.setChange(this.tenderingChange);
        this.paymentResponse.setLocalPayment(pay_request.localPayment);
        const transaction = new PaymentResponse();
        const userId = +(await AsyncStorage.getItem('@CURRENT_USER_ID'));
        const process = {
          success: 1,
          tenderingChange: this.tenderingChange,
          response: {
            applicationId: 0,
            checksum: '',
            created_at: +new Date(),
            createdUserId: 0,
            merchantId: 0,
            paymentId: +pay_request.localPayment.id,
            transactionTypeId: 2,
            transactionStatusId: 2,
            transactionCurrencyId: 25,
            transactionAmount: pay_request.localPayment.paymentAmount,
            status: 1,
            transactionId: +pay_request.localPayment.id,
            updated_at: +new Date(),
            userId,
            offline: true,
          },
        };
        transaction.setProcess(process);
        this.transactions.push(transaction);
        // setTimeout(() => {
        this.emit(event_names.DONE);
        this.emit(event_names.PAYMENT_SUCCESFULL);
        // }, 0)
      }

      return Promise.resolve({ ...next, offline });
    } catch (error) {
      //alert(error)
      this.emit(event_names.DONE);
      console.log({ PAYMENT_ERROR: error });
      return Promise.reject(handleError(error.message));
    }
  }

  async payStep(step, extra) {
    switch (step) {
      case 'initiate':
        try {
          if (!this.paymentResponse.initiate) {
            const pay_request = await this.paymentInit(this);
            if (!pay_request.success) {
              throw new Error(pay_request.message);
            }

            // ON PENDING WALLET PAYMENT
            if (pay_request.previous_payment) {
              return Promise.resolve(pay_request);
            }

            this.paymentResponse = new PaymentResponse({
              success: pay_request.success,
              initiate: pay_request,
            });
          }
          return Promise.resolve(extra.next);
        } catch (error) {
          // alert(JSON.stringify(error))
          return Promise.reject(handleError(error.message));
        }
      case 'process':
        try {
          const data = extra.data;

          const pay_request = await this.paymentProcess(
            this,
            data,
            extra.transactionTypeId
          );
          if (!pay_request.success) {
            throw new Error(pay_request.message);
          }
          if (pay_request.previous_payment) {
            return Promise.resolve(pay_request);
          }
          this.paymentResponse.setProcess(pay_request);
          if (!extra.card || !extra.upi) {
            const transaction = new PaymentResponse();
            transaction.setChange(this.tenderingChange);
            this.setChange(0);
            transaction.setProcess(pay_request);
            this.transactions.push(transaction);
          }

          if (!extra.skipSuccess) {
            this.emit(event_names.PAYMENT_SUCCESFULL);
          }
          if (extra.card || extra.upiqr || extra.upi) {
            return Promise.resolve(pay_request);
          }
          if (data.wallet) {
            return Promise.resolve(pay_request);
          } else {
            return Promise.resolve(extra.next);
          }
        } catch (error) {
          return Promise.reject(handleError(error.message));
        }
      case 'finalize':
        try {
          const pay_request = await this.paymentFinalize(
            this.paymentResponse.getPaymentId()
          );
          if (!pay_request.success) {
            throw new Error(pay_request.message);
          }
          return Promise.resolve({});
        } catch (error) {
          return Promise.reject(handleError(error.message));
        }
      case 'update':
        try {
          const data = extra.data;

          const pay_request = await this.paymentUpdate(
            this,
            data,
            extra.transactionTypeId
          );
          this.paymentResponse.setProcess(pay_request);
          if (!pay_request.success) {
            throw new Error(pay_request.message);
          }

          return Promise.resolve(pay_request);
        } catch (error) {
          return Promise.reject(handleError(error.message));
        }

      default:
        break;
    }
  }

  getPaymentId() {
    if (this.paymentId) {
      return this.paymentId;
    }
    return null;
  }

  getAmountToPay() {
    return +(this.order.totalPrice - this.getAmountPaid()).toFixed(2);
  }

  isSplit() {
    return this.transactions.length > 1;
  }

  setChange(amount) {
    this.tenderingChange = amount;
  }

  getAmountPaid() {
    if (this.transactions.length === 0) {
      return 0;
    }
    return +this.transactions
      .filter(x => x.process.response.transactionStatusId === 2)
      .reduce((acc, current) => {
        return acc + +current.process.response.transactionAmount;
      }, 0)
      .toFixed(2);
  }
}
