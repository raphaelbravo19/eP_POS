import { CustomItemType } from "../interfaces/payment_interfaces";

export default class CustomItem implements CustomItemType {
  discountEntered: number;
  discountType: string;
  name: string;
  quantity: number;
  unitPrice: number;
  tax: any[];
  basePrice: number;
  discount: number;
  calculatedPrice: number;
  discountValue: number;
  calculatedDiscount: number;
  totalTax: number;
  constructor(item: CustomItemType) {
    this.discountEntered = item.discountEntered;
    this.discountType = item.discountType;
    this.name = item.name;
    this.quantity = item.quantity;
    this.unitPrice = item.unitPrice;

    this.tax = [];
    this.basePrice = 10;
    this.discount = 0;
    this.totalTax = item.totalTax;

    this.calculatedPrice = 0;
    this.discountValue = 0;
    this.calculatedDiscount = 0;
    this.update();
  }

  update() {
    this.calculatedPrice = (this.quantity * this.unitPrice);
    if (this.discountType === '%') {
      const discount = this.formatDecimal(
        (this.calculatedPrice * this.discountEntered) / 100
      );
      this.discountValue = this.calculatedDiscount = discount;
      this.calculatedPrice = (this.calculatedPrice - discount) + this.totalTax;
    } else {
      this.discountValue = this.calculatedDiscount = this.discountEntered;
      this.calculatedPrice = this.formatDecimal(
        (this.calculatedPrice - this.discountEntered) + this.totalTax
      );
    }
  }

  edit(properties: {}) {
    for (const key in properties) {
      if (this.hasOwnProperty(key)) {
        this[key] = properties[key];
      }
    }
  }

  changeQuantity(quantity: number) {
    this.quantity = quantity;
    this.update();
  }

  formatDecimal(value: number) {
    return +value.toFixed(2);
  }
}
