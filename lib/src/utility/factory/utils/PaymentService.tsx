import { epaisaRequest } from '../../services/epaisa_service';
import { AsyncStorage, NetInfo } from 'react-native';
import * as event_names from '../api/constants_events';
import * as _ from 'lodash';
import { EventEmitter } from 'events';
import realm from '../../services/realm_service';
import {
  PaymentType,
  Finalize,
  VoidResponse,
} from '../../interfaces/payment_interfaces';
import { createRow, getCreateRow } from '../../services/realm_service';
import uuidv1 from 'uuid/v1';
import { handleError } from './handlerError';
export default class PaymentService extends EventEmitter {
  handlerError;
  async cashPaymentRequest(requests: PaymentType[], offline = false) {
    if (offline) {
      let localPayment = {};
      let number_generator = {
        paymentId: 1000,
        transactionId: 1000,
      };
      let id_gen = await AsyncStorage.getItem('number_generator');

      if (id_gen) {
        const { paymentId, transactionId } = JSON.parse(id_gen);
        number_generator = {
          paymentId: paymentId + 1,
          transactionId: transactionId + 1,
        };
      }
      await AsyncStorage.setItem(
        'number_generator',
        JSON.stringify(number_generator)
      );

      requests.forEach(request => {
        const order = {
          id: `${number_generator.transactionId}`,
          deliveryCharges: request.order.deliveryCharges,
          generalDiscount: request.order.generalDiscount,
          totalDiscount: request.order.totalDiscount,
          customItems: request.order.customItems.map(item => ({
            ...item,
            id: uuidv1(),
          })),
          generalDiscountType: request.order.generalDiscountType,
          roundOffAmount: request.order.roundOffAmount,
          salesreturnstatus: request.order.salesreturnstatus,
          serviceCharges: request.order.serviceCharges,
          totalTax: request.order.totalTax,
          subTotal: request.order.subTotal,
          calculatedDiscount: request.order.calculatedDiscount,
          totalPrice: request.order.totalPrice,
          customer: request.order.customer || null,
        };
        const data = {
          id: `${number_generator.paymentId}`,
          order: order,
          paymentCurrencyId: request.paymentCurrencyId,
          paymentAmount: request.paymentAmount,
          paymentTipAmount: request.paymentTipAmount,
          paymentSubTotal: request.paymentSubTotal,
          paymentTotalDiscount: request.paymentTotalDiscount,
          paymentCustomerId: `${_.get(
            request,
            'order.customer.customerId',
            ''
          )}`,
          created_at: request.created_at,
          location: request.location,
        };
        //alert(JSON.stringify(request.order.customer))
        createRow('Payment', data, true);
        let userData = realm.objectForPrimaryKey('User', 0);
        try {
          let itemToTrans = {
            Transactions: [
              {
                applicationId: 1,
                created_at: request.created_at + 1,
                merchantCompanyName: userData.merchant.merchantCompanyName,
                merchantId: userData.merchantId,
                name: '',
                paymentId: number_generator.paymentId,
                transactionAmount: request.paymentAmount.toString(),
                transactionDetails: [0],
                transactionId: number_generator.transactionId,
                transactionStatus: 'Approved',
                transactionStatusId: 2,
                transactionType: 'Cash',
                transactionTypeId: 2,
                userId: userData.userId,
              },
            ],
            Customer:
              request.order.customer != null
                ? request.order.customer.key.toString()
                : '',
            split: '-1',
            PaymentId: number_generator.paymentId,
            paymentStatusId: 0,
          };
          let listTaxValue = [];
          order.customItems.map(prod => {
            let taxList = prod.tax.map(taxItem => {
              return {
                name: taxItem.name,
                value: taxItem.value,
                calculatedTaxValue: taxItem.calculatedTaxValue,
              };
            });
            listTaxValue = [...listTaxValue, ...taxList];
          });
          let itemToPay = {
            created_at: request.created_at + 1,
            deliveryCharges: order.deliveryCharges,
            merchantId: userData.merchantId,
            order: {
              calculatedDiscount: order.calculatedDiscount,
              customItems: order.customItems,
              deliveryCharges: order.deliveryCharges,
              generalDiscount: order.generalDiscount,
              generalDiscountType: order.generalDiscountType,
              merchantId: userData.merchantId,
              orderId: order.id,
              status: 1,
              subTotal: order.subTotal,
              totalDiscount: order.totalDiscount,
              totalPrice: order.totalPrice,
              totalTax: order.totalTax,
              calculatedTax: listTaxValue,
            },
            orderId: order.id,
            paymentAmount: request.paymentAmount,
            paymentId: parseInt(number_generator.paymentId),
            paymentStatusId: 4,
            paymentSubTotal: order.subTotal,
            paymentTipAmount: 0,
            paymentTotalDiscount: 0,
            serviceCharges: 0,
            status: 1,
            updated_at: request.created_at + 1,
            user: '',
            userId: userData.userId,
          };
          getCreateRow('TransactionGrouped', itemToTrans, true);
          getCreateRow('PaymentGrouped', itemToPay, true);
        } catch (error) {
          alert(error);
        }

        localPayment = data;
      });
      return {
        success: true,
        offline: true,
        localPayment,
      };
    } else {
      try {
        const res = await epaisaRequest(
          requests,
          '/payment/offlinetransactions',
          'POST'
        );
        if (res.success === 0) {
          throw new Error(res.message);
        }
        return {
          success: true,
          response: res.response,
        };
      } catch (error) {
        this.emit('payment_error');

        return error;
      }
    }
  }

  async paymentInit(request: PaymentType) {
    this.emit('request');
    try {
      const res = await epaisaRequest(request, '/payment/initiate', 'POST');

      // const res = {
      //   "success": 1,
      //   "response": {
      //     "merchantId": 4850,
      //     "userId": 4910,
      //     "paymentCurrencyId": 25,
      //     "paymentAmount": 10,
      //     "paymentTipAmount": 0,
      //     "paymentSubTotal": 10,
      //     "paymentTotalDiscount": 0,
      //     "paymentCustomerId": "",
      //     "paymentStatusId": 1,
      //     "status": 1,
      //     "applicationId": 1,
      //     "created_at": 1551273441,
      //     "updated_at": 1551273441,
      //     "createdUserId": 4910,
      //     "updatedUserId": 4910,
      //     "checksum": "OXCH5kjeB7CcTrhgdcmXCxukMgO7HM007xi9MLZ1_oOBSKHtGRNr0LrQjhybdi79yZrb_kGntMKCZZi0NXM_fyOlcsgO6fGFQcSp7XaHoVc,",
      //     "paymentId": 22902
      //   },
      //   "paymentDetails": {
      //     "sourceId": "18",
      //     "Location": "0.0,0.0",
      //     "serviceCharges": 0,
      //     "deliveryCharges": 0,
      //     "orderId": "5c768de10921196bc72a1365"
      //   }
      // }
      console.log({ paymentInit: JSON.stringify(res) });
      if (res.success === 0) {
        if (res.message === 'Previous payment is waiting') {
          this.emit(event_names.DONE);
          return { ...res, success: 1, previous_payment: true };
        }
        throw new Error(res.message);
      }
      this.emit(event_names.DONE);
      return res;
    } catch (error) {
      this.emit(event_names.DONE);
      this.emit('payment_error');

      return error;
    }
  }

  async paymentProcess(
    request: PaymentType,
    processData: any,
    transactionTypeId: number
  ) {
    this.emit('request');
    transactionTypeId = transactionTypeId || 21;
    const {
      paymentId,
      paymentCurrencyId,
    } = request.paymentResponse.initiate.response;
    const paymentAmount = request.paymentAmount;

    const extra = `####${paymentId}####${transactionTypeId}####${paymentCurrencyId}####${paymentAmount.toFixed(
      2
    )}####${processData.wallet ? `${processData.mobile}####` : ''}`;
    const parameters = processData.wallet ? null : processData;
    try {
      const res = await epaisaRequest(
        parameters,
        '/payment/process',
        'POST',
        extra
      );
      // const res = {
      //   "success": 1,
      //   "response": {
      //     "merchantId": 4850,
      //     "userId": 4910,
      //     "paymentId": 22902,
      //     "transactionTypeId": 17,
      //     "transactionStatusId": 4,
      //     "transactionCurrencyId": 25,
      //     "transactionAmount": "10.00",
      //     "status": 0,
      //     "applicationId": 1,
      //     "created_at": 1551273487,
      //     "updated_at": 1551273487,
      //     "createdUserId": 4910,
      //     "checksum": "zWpOh18c8Bpr-CP_o3--AL2KYmbgwM0DamuLngqhHoIZlFhu4exmgn4MbVG5DLR0IKWVhFG5SWcgyBbmn2AaDH80juNxQlH_",
      //     "transactionId": 21000,
      //     "updatedUserId": 4910
      //   }
      // }
      console.log({ paymentProcess: JSON.stringify(res) });

      if (res.success === 0) {
        if (res.message === 'Previous payment is waiting') {
          this.emit(event_names.DONE);
          return { ...res, success: 1, previous_payment: true };
        }
        throw new Error(res.message);
      }
      if (
        res.response.transactionTypeId === 21 ||
        res.response.transactionTypeId === 2
      ) {
        // this.emit(event_names.PAYMENT_SUCCESFULL);
      }
      this.emit(event_names.DONE);
      return {
        success: true,
        response: res.response,
      };
    } catch (error) {
      this.emit('payment_error');
      console.log({ PAYMENT_PROCCESS_ERROR: error });
      this.emit(event_names.DONE);
      return error;
    }
  }

  async paymentUpdate(
    request: PaymentType,
    parameters: any,
    transactionTypeId: number
  ) {
    this.emit('request');
    const { paymentId } = request.paymentResponse.initiate.response;
    const { transactionId } = request.paymentResponse.process.response;
    const extra = `####${paymentId}####${transactionTypeId}####${transactionId}`;
    try {
      const res = await epaisaRequest(
        parameters,
        '/payment/update',
        'POST',
        extra
      );

      this.emit(event_names.DONE);
      return {
        success: true,
        response: res.response,
      };
    } catch (error) {
      this.emit('payment_error');
      console.log({ PAYMENT_PROCCESS_ERROR: error });
      this.emit(event_names.DONE);
      return error;
    }
  }

  async paymentFinalize(paymentId: number): Promise<Finalize> {
    try {
      this.emit('request');
      const res = await epaisaRequest(paymentId, '/payment/finalize', 'POST');
      console.log({ paymentFinalize: JSON.stringify(res) });

      if (res.success === 0) {
        throw new Error(res.message);
      }
      this.emit('done');
      return {
        success: true,
        response: res.response,
      };
    } catch (error) {
      this.emit('done');
      return error;
    }
  }
  async paymentVoidResendOtp(payment: {}): Promise<VoidResponse> {
    try {
      this.emit('request');
      const paymentId = payment.paymentId
        ? payment.paymentId
        : payment.paymentResponse.getPaymentId();
      const requireVerifiedSetting = 2;
      const parameters = { paymentId, requireVerifiedSetting };
      const res = await epaisaRequest(parameters, '/payment/void', 'POST');
      if (res.message === 'There is no OTP for this payment.') {
        return Promise.resolve(res);
      }
      if (res.success === 0) {
        throw new Error(res.message);
      }
      if (res.success === 1) {
        payment.emit('refund_otp_resend');
        throw new Error('Otp code have been resend!');
      }
      this.emit('done');
    } catch (error) {
      this.emit('done');
      return Promise.reject(handleError(error.message));
    }
  }
  async paymentVoid(
    payment: {},
    callback: Function,
    otpValue: any = null
  ): Promise<VoidResponse> {
    try {
      this.emit('request');
      const paymentId = payment.paymentId
        ? payment.paymentId
        : payment.paymentResponse.getPaymentId();
      const requireVerifiedSetting = +payment.configs.sendOtpOnRefund;
      const parameters = { paymentId, requireVerifiedSetting };
      if (otpValue) {
        parameters.otpValue = otpValue;
      }
      const res = await epaisaRequest(parameters, '/payment/void', 'POST');
      this.emit('done');
      // alert(JSON.stringify(res))
      if (res.message === 'There is no OTP for this payment.') {
        return Promise.resolve(res);
      }
      if (res.success === 0) {
        //if(res.message===)
        if (res.message != 'This user cannot verify by OTP.') {
          //alert(1)
          throw new Error(res.message);
        }
      }
      if (otpValue && res.success === 1) {
        payment.emit('show_refund_otp', false);
        throw new Error('Payment refund completed!');
      }
      if (!payment.configs.sendOtpOnRefund) {
        throw new Error('Payment refund completed!');
      } else {
        payment.emit('show_refund_otp', true);
        return Promise.resolve(res);
      }
    } catch (error) {
      this.emit('done');
      return Promise.reject(handleError(error.message, callback));
    }
  }
  static async sendPaymentReceipts(parameters) {
    try {
      if (!(await NetInfo.isConnected.fetch())) {
        throw new Error(
          'You need to be connected to internet to send receipts!'
        );
      }

      const receiptRequest = await epaisaRequest(
        parameters,
        '/receipt',
        'POST'
      );
      if (receiptRequest.success === 0) {
        throw new Error(receiptRequest.message);
      }
      const response = receiptRequest.response;
      const errors = [];
      const success = [];
      for (const key in response) {
        const param = parameters[key === 'sendSms' ? 'mobile' : 'email'];
        if (!response[key].success) {
          if (param) {
            errors.push(key);
          }
        } else {
          if (param) {
            success.push(key);
          }
        }
      }
      if (errors.length > 0) {
        let emailFail = false;
        let smsFail = false;
        errors.forEach(x => {
          if (x === 'sendSms') {
            smsFail = true;
          }
          if (x === 'sendEmail') {
            emailFail = true;
          }
        });
        const errorStr = `Sending receipt to ${emailFail ? 'email' : ''}${
          emailFail && smsFail ? ' and ' : ''
        }${smsFail ? 'sms' : ''} failed`;
        throw new Error(errorStr);
      }
      if (success.length > 0) {
        let emailSuccess = false;
        let smsSuccess = false;
        success.forEach(x => {
          if (x === 'sendSms') {
            smsSuccess = true;
          }
          if (x === 'sendEmail') {
            emailSuccess = true;
          }
        });
        const successStr = `to ${emailSuccess ? parameters.email : ''} ${
          emailSuccess && smsSuccess ? ' and ' : ''
        } ${smsSuccess ? parameters.mobile : ''} `;
        return Promise.resolve({
          success: true,
          message: successStr,
          clearEmail: emailSuccess,
          clearMobile: smsSuccess,
        });
      }
    } catch (error) {
      return Promise.reject(handleError(error.message));
    }
  }
  async sendReceipts(parameters) {
    this.emit('request');
    try {
      if (!(await NetInfo.isConnected.fetch())) {
        throw new Error(
          'You need to be connected to internet to send receipts!'
        );
      }

      const receiptRequest = await epaisaRequest(
        parameters,
        '/receipt',
        'POST'
      );
      if (receiptRequest.success === 0) {
        throw new Error(receiptRequest.message);
      }
      const response = receiptRequest.response;
      const errors = [];
      const success = [];
      for (const key in response) {
        const param = parameters[key === 'sendSms' ? 'mobile' : 'email'];
        if (!response[key].success) {
          if (param) {
            errors.push(key);
          }
        } else {
          if (param) {
            success.push(key);
          }
        }
      }
      if (errors.length > 0) {
        let emailFail = false;
        let smsFail = false;
        errors.forEach(x => {
          if (x === 'sendSms') {
            smsFail = true;
          }
          if (x === 'sendEmail') {
            emailFail = true;
          }
        });
        const errorStr = `Sending receipt to ${emailFail ? 'email' : ''}${
          emailFail && smsFail ? ' and ' : ''
        }${smsFail ? 'sms' : ''} failed`;
        throw new Error(errorStr);
      }
      if (success.length > 0) {
        let emailSuccess = false;
        let smsSuccess = false;
        success.forEach(x => {
          if (x === 'sendSms') {
            smsSuccess = true;
          }
          if (x === 'sendEmail') {
            emailSuccess = true;
          }
        });
        const successStr = `to ${emailSuccess ? parameters.email : ''} ${
          emailSuccess && smsSuccess ? ' and ' : ''
        } ${smsSuccess ? parameters.mobile : ''} `;
        this.emit('done');
        return Promise.resolve({
          success: true,
          message: successStr,
          clearEmail: emailSuccess,
          clearMobile: smsSuccess,
        });
      }
    } catch (error) {
      this.emit('done');

      return Promise.reject(handleError(error.message));
    }
  }

  async authenticateWalletPayment(request: PaymentType, otp: number) {
    try {
      console.log({ request });
      this.emit('request');
      const {
        transactionTypeId,
        transactionId,
      } = request.paymentResponse.process.response;
      const extra = `####${
        request.paymentResponse.initiate.response.paymentId
      }####${transactionTypeId}####${transactionId}####${otp}`;
      const res = await epaisaRequest(
        '',
        '/payment/authenticate',
        'POST',
        extra
      );
      // const res = {
      //   "success": 1,
      //   "response": {
      //     "transactionId": 21003,
      //     "paymentId": 22906,
      //     "merchantId": 4850,
      //     "userId": 4910,
      //     "transactionTypeId": 17,
      //     "transactionStatusId": 2,
      //     "transactionCurrencyId": 25,
      //     "transactionAmount": "10.00",
      //     "checksum": "zWpOh18c8BoQP2B33jDRML3B7HP5gI76vvhf5wqQ6-zGHRKrwcp-n3YqA7dODdNREujbfTCueqkhDAea1NPUTqa6kVgJJTcV",
      //     "created_at": 1551274063,
      //     "updated_at": 1551274091,
      //     "createdUserId": 4910,
      //     "updatedUserId": 4910,
      //     "status": 0,
      //     "applicationId": 1
      //   }
      // }
      console.log({ authenticatePayment: JSON.stringify(res) });

      this.emit('done');
      if (res.success === 0) {
        throw new Error(res.message);
      }
      return Promise.resolve(res);
    } catch (error) {
      this.emit('done');
      return Promise.reject(handleError(error.message));
    }
  }

  async cancel(paymentId: number, cleanOrder: boolean = true) {
    try {
      this.emit('request');
      if (cleanOrder) {
        this.emit('cancelled');
      }

      const res = await epaisaRequest(paymentId, '/payment/cancel', 'POST');
      if (res.success === 0) {
        if (res.errorCode !== '2.2.11') {
          throw new Error(res.message);
        }
      }
      this.emit('done');
      return Promise.resolve(res);
    } catch (error) {
      this.emit('done');
      return Promise.reject(handleError(error.message));
    }
  }

  async cancelTransaction(transactionId) {
    this.emit('request');
    try {
      const cancel = await epaisaRequest(
        {
          transactionId,
        },
        '/payment/cancel/transaction',
        'POST'
      );

      if (!cancel.success) {
        throw new Error(cancel.message);
      }
      this.emit('done');
      return cancel;
    } catch (error) {
      this.emit('done');

      return error;
    }
  }

  async getPaymentById(paymentId: number) {
    this.emit('request');
    //
    this.emit('done');
  }

  formatDecimal(value: number) {
    return +value.toFixed(2);
  }
}
