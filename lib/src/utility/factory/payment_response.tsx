import moment from 'moment';
import { PaymentDetailsEpType, PaymentDetailsItemType } from '../interfaces/payment_interfaces';
import CardModule from '../custom_modules/card_module';
import realm from '../services/realm_service'
import { epaisaRequest } from '../services/epaisa_service'
import { PermissionsAndroid } from 'react-native';
interface PaymentResponseType {
  success: any;
  initiate: any;
  process: any;
  finalize: any;
  tenderingChange?: any;
}
export default class PaymentResponse implements PaymentResponseType {
  success: any;
  initiate: any;
  process: any;
  finalize: any;
  tenderingChange?: any;
  constructor(response?: any) {
    if (response) {
      this.success = response.success;
      this.initiate = response.initiate;
      this.process = response.process;
      this.finalize = response.finalize;
    }
  }
  setInitiate(initiate) {
    this.initiate = initiate;
  }
  setProcess(process) {
    this.process = process;
  }
  setFinalize(finalize) {
    this.finalize = finalize;
  }
  setLocalPayment(data) {
    this.localPayment = data;
  }
  setChange(amount) {
    this.tenderingChange = amount;
  }
  // getCashDetails() {
  //   const date = this.localPayment ? moment(new Date()) : moment(new Date(this.initiate.response.created_at));
  //   let details = {
  //     paymentId: '',
  //     transactionId: '',
  //     date: date.format('DD MMM YYYY'),
  //     time: date.format('h:mm A'),
  //   }
  //   if (this.localPayment) {
  //     details = {
  //       ...details,
  //       paymentId: this.localPayment.id,
  //       transactionId: this.localPayment.id,
  //     }
  //   } else {
  //     details = {
  //       ...details,
  //       paymentId: this.process.response.paymentId,
  //       transactionId: this.process.response.transactionId,
  //     }
  //   }

  //   return details;
  // }

  canRefund() {
    if (this.process.response.offline) {
      return false;
    }
    const type = this.process.response.transactionTypeId;
    switch (type) {
      case 2:
      case 3:
      case 14:
      case 21:
      // wallet payments
      case 5:
      case 8:
      case 25:
      // case 17:
      // case 9:
      // card
      case 22:
      case 24:
      case 36:
        return true;
      default:
        return false;
    }
  }

  getPaymentId(): string {
    return this.localPayment ? this.localPayment.id : this.initiate.response.paymentId;
  }

  getTransactionId(): string {
    if (!this.process) {
      return null
    }
    return this.process.response.transactionId;
  }

  getDateTime(): { date: any, time: any } {
    let epoch = this.localPayment ? +new Date() / 1000 : this.process.response.created_at;
    const date = moment.unix(epoch);

    return {
      date: date.format('DD MMM YYYY'),
      time: date.format('h:mm A')
    }
  }

  getPaymentDetails(): PaymentDetailsEpType {
    const { title, icon } = this.getPaymentTypeData();

    let itemsData = this.getDateTime()

    if (this.process.response.offline) {
      itemsData = {
        paymentId: '', // this.localPayment.id,
        transactionId: '', // this.localPayment.id,
        ...itemsData
      }
    } else {
      itemsData = {
        paymentId: this.process.response.paymentId,
        transactionId: this.process.response.transactionId,
        ...itemsData
      }
    }
    const items: PaymentDetailsItemType[] = [];
    for (const key in itemsData) {
      const obj = {
        name: '',
        value: ''
      };
      switch (key) {
        case 'date':
          obj.name = 'Date';
          break;
        case 'time':
          obj.name = 'Time';
          break;
        case 'paymentId':
          obj.name = 'Payment ID';
          break;
        case 'transactionId':
          obj.name = 'Transaction ID';
          break;
      }
      let value = itemsData[key];
      // if (this.localPayment && (key === 'paymentId' || key === 'transactionId')) {
      //   value = '';
      // }
      obj.value = value;
      items.push(obj);
    }
    if (this.initiate) {
      if (this.initiate.paymentDetails) {
        const details = this.initiate.paymentDetails;
        const customFields = details.customFields
          ? JSON.parse(details.customFields)
          : [];
        for (const field of customFields) {
          if (field.fieldValue) {
            items.push({
              name: field.fieldName,
              value: field.fieldValue,
            });
          }

        }
      }
    }
    return {
      icon,
      title,
      items,
    };
  }

  getCustomerId() {
    if (!this.initiate) {
      return null;
    }
    return this.initiate.paymentCustomerId
  }
  getPaymentTypeData() {
    if (!this.process) {
      return null
    }
    const type = this.process.response.transactionTypeId;
    switch (type) {
      case 2:
        return {
          type,
          title: 'Cash Payment',
          icon: 'CashPayments'
        }
      case 14:
        return {
          type,
          title: 'Card Payment',
          icon: 'CardPayments'
        }
      case 5:
      case 6:
      case 7:
      case 8:
      case 9:
      case 15:
      case 16:
      case 17:
      case 18:
      case 19:
      case 25:
      case 26:
        return {
          type,
          title: 'Wallet Payment',
          icon: 'DigitalWalletPayments'
        }
      case 21:
        return {
          type,
          title: 'Cheque Payment',
          icon: 'Cheque'
        }
      case 20:
      case 27:
        return {
          type,
          title: 'UPI Payment',
          icon: 'UpiPayments'
        }
      case 22:
      case 24:
      case 36:
        return {
          type,
          title: 'Card Payment',
          icon: 'CardPayments'
        }
      default:
        break;
    }
  }

  static async cardRefund(transactionTypeId, transactionAmount, transactionDetails: {
    invoiceNumber: any,
    last4Digits: any,
    stanID: any,
    deviceId: any
  }, paymentId, callback) {

    let data;
    const card_reader = realm.objectForPrimaryKey('CardReader', transactionDetails.deviceId);

    const granted = await PermissionsAndroid.request(
      PermissionsAndroid.PERMISSIONS.READ_PHONE_STATE
    );

    if (granted !== PermissionsAndroid.RESULTS.GRANTED) {
      throw new Error('Permission required');
    }

    switch (transactionTypeId) {
      //MRL
      case 22:
        data = {
          processorId: 1,
          userName: card_reader.username,
          tid: card_reader.tid,
          mid: card_reader.mid,
          invoiceNumber: transactionDetails.invoiceNumber,
          serialNumber: card_reader.deviceSerialNumber,
        }
        break;
      // Mosambee
      case 24:
        data = {
          processorId: 4,
          userName: card_reader.username,
          password: card_reader.password,
          invoiceNumber: transactionDetails.invoiceNumber,
        }
        break;
      // mSwipe
      case 36:
        data = {
          processorId: 10,
          username: card_reader.username,
          password: card_reader.password,
          amount: transactionAmount,
          last4Digits: transactionDetails.last4Digits,
          invoiceNumber: transactionDetails.invoiceNumber,
          stanID: transactionDetails.stanID,
          serialNumber: card_reader.deviceSerialNumber
        }
        break;
      default:
        break;
    }
    // alert(JSON.stringify(data))
    // return;
    return CardModule.refundTransaction(
      data,
      res => {
        epaisaRequest({
          paymentId,
          requireVerifiedSetting: false
        },
          '/payment/void',
          'POST')
        callback(res)
      }
    );
  }
}
