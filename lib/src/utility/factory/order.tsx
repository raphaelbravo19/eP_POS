import CustomItem from './custom_item';
import { CustomItemType, OrderType } from '../interfaces/payment_interfaces'
export default class Order implements OrderType {
  deliveryCharges: number;
  generalDiscount: number;
  totalDiscount: number;
  products: any[];
  customItems: CustomItemType[];
  generalDiscountType: string;
  roundOffAmount: number;
  salesreturnstatus: number;
  serviceCharges: number;
  totalTax: number;
  subTotal: number;
  subSubTotal: number;
  calculatedDiscount: number;
  totalPrice: number;
  constructor({
    products,
    deliveryCharges,
    generalDiscount,
    generalDiscountType,
  }, configs) {
    this.deliveryCharges = +deliveryCharges || 0;
    this.generalDiscount = +generalDiscount || 0;
    this.totalDiscount = 0;
    this.products = [];
    this.customItems = [];
    this.generalDiscountType = generalDiscountType || '%';
    this.roundOffAmount = 0;
    this.salesreturnstatus = 0;
    this.serviceCharges = 0;
    this.totalTax = 0;

    this.subTotal = 0;
    this.subSubTotal = 0;
    this.calculatedDiscount = 0;
    this.totalPrice = 0;
    this.addCustomItems(products);
    this.configs = configs || {};
  }

  update(): void {
    // this.updateConfigs();
    this.subTotal = 0;
    this.totalDiscount = 0;
    this.totalTax = 0;

    for (const item of this.customItems) {
      this.totalDiscount = this.totalDiscount + item.calculatedDiscount;
      this.subTotal = this.subTotal + item.calculatedPrice;
      // this.totalTax = this.totalTax + item.tax.reduce((acc, c) => acc + c.calculatedTaxValue, 0)
    }
    this.totalPrice = this.subTotal + this.deliveryCharges;
    if (this.generalDiscountType === '%') {
      this.totalDiscount = (this.subTotal * this.generalDiscount) / 100;
    } else {
      this.totalDiscount = this.generalDiscount;
    }
    this.totalPrice = this.formatDecimal(this.totalPrice - this.totalDiscount);
    this.totalTax = this.customItems.reduce((acc, c) => acc + c.totalTax, 0)
    if (this.configs) {
      if (this.configs.roundOff) {
        this.totalPrice = Math.round(this.totalPrice + this.totalTax);
      }
    }
  }

  addCustomItems(products: any[]): void {
    if (!products) {
      return;
    }
    if (!products.length) {
      return;
    }

    for (const product of products) {

      const percentDiscount = product.discount !== '' ? product.discount : 0;
      const discountTemp = product.type == '%' ? (product.unitPrice * product.quant) * percentDiscount / 100 : percentDiscount;

      const createTaxCalc = (item, discountTemp) => {
        return tax => {
          if (!tax) return 0;
          return ((item.unitPrice * item.quant - discountTemp) * tax) / 100;
        };
      };
      const taxCalc = createTaxCalc(product, discountTemp);

      const taxes = {
        sgstTotal: 0,
        cgstTotal: 0,
        igstTotal: 0,
        cessTotal: 0,
        vatTotal: 0,
      };

      taxes.sgstTotal += taxCalc(product.sgst);
      taxes.cgstTotal += taxCalc(product.cgst);
      taxes.igstTotal += taxCalc(product.igst);
      taxes.cessTotal += taxCalc(product.cess);
      taxes.vatTotal += taxCalc(product.vat);
      const item: CustomItemType = {
        discountEntered: +product.discount,
        discountType: product.type || product.discountType,
        name: product.name,
        quantity: +product.quant || product.quantity,
        unitPrice: +product.unitPrice,
        tax: [],
        basePrice: 0,
        calculatedPrice: 0,
        discount: 0,
        calculatedDiscount: 0,
        totalTax: Object.values(taxes).reduce((c, a) => a + c, 0)
      };
      this.customItems.push(new CustomItem(item));
    }
    this.update();
  }

  pushCustomItem(customItem: CustomItemType) {
    this.addCustomItems([customItem])
    // this.customItems.push(customItem)
  }

  formatDecimal(value: number) {
    return +value.toFixed(2);
  }

  setConfigs(configs) {
    this.configs = configs;
    // this.update();
  }
}
