import * as _ from 'lodash';
import EventEmitter from 'events'
export default class CustomItemHelper extends EventEmitter {
  constructor() {
    super();
    this.defaultGstTax = 5;
    this.discountEntered = 0;
    this.discountType = '%';
    this.name = '';
    this.quantity = 0;
    this.unitPrice = 0;
    this.totalTax = 0;

    this.tax = [];
    this.basePrice = 10;
    this.discount = 0;
    this.taxes = [];
    this.calculatedPrice = 0;
    this.discountValue = 0;
    this.calculatedDiscount = 0;
    this.taxInfo = {};
    this.taxesData = [
      {
        name: 'VAT',
        group: 'VAT',
        type: 'VAT'
      },
      {
        name: 'CESS',
        group: 'GST',
        type: 'CESS'
      },
      {
        name: 'CGST',
        group: 'GST',
        type: 'intrastate'
      },
      {
        name: 'SGST',
        group: 'GST',
        type: 'intrastate'
      },
      {
        name: 'IGST',
        group: 'GST',
        type: 'interstate'
      }
    ]
  }

  mapTaxes(taxes) {
    this.taxesData = this.taxesData.map(tx => {
      const data = taxes.find(x => x.name === tx.name)
      return {
        ...tx,
        data
      }
    })
  }

  getData() {
    return _.pick(this, [
      'discountEntered',
      'discountType',
      'name',
      'quantity',
      'unitPrice',
      'tax',
      'basePrice',
      'discount',
      'calculatedPrice',
      'calculatedDiscount',
      'taxes'
    ])
  }

  static calculateTotals(items: CustomItemHelper[]) {
    const totals = items.map(x => ({ ...x, taxes: Array.isArray(x.taxes) ? x.taxes : [] }))
      .reduce(
        (acc, c) => {
          return {
            subtotal: acc.subtotal + c.calculatedPrice,
            taxes: [...acc.taxes, ...c.taxes],
            total: acc.total + c.calculatedPrice,
          };
        },
        {
          subtotal: 0,
          taxes: [],
          total: 0,
        }
      );
    totals.taxesGroup = totals.taxes.reduce((acc, c) => {
      if (!acc[c.name]) {
        acc[c.name] = {
          group: c.name,
          value: c.value,
        };
      } else {
        acc[c.name].value = acc[c.name].value + c.value;
      }
      return acc;
    }, {});
    totals.total = totals.total + Object.values(totals.taxesGroup).reduce(
      (acc, c) => {
        return acc + c.value;
      },
      0
    );
    return totals
  }
  update() {
    this.calculatedPrice = (this.quantity * this.unitPrice);
    if (this.discountType === '%') {
      const discount = this.formatDecimal(
        (this.calculatedPrice * this.discountEntered) / 100
      );
      this.discountValue = this.calculatedDiscount = discount;
      this.calculatedPrice = (this.calculatedPrice - discount) //+ this.totalTax;
    } else {
      this.discountValue = this.calculatedDiscount = this.discountEntered;
      this.calculatedPrice = this.formatDecimal(
        (this.calculatedPrice - this.discountEntered) //+ this.totalTax
      );
    }

    this.updateTaxes();
    this.emit('change')
  }

  formatDecimal(value) {
    return +value.toFixed(2);
  }


  setTaxInfo() {
    let group;
    let type;
    const gst = !!this.taxes.find(x => x.group === 'GST');
    const vat = !!this.taxes.find(x => x.group === 'VAT');
    if (gst) {
      group = 'GST'
      const intrastate = !!this.taxes.find(x => x.type === 'intrastate');
      type = intrastate ? 'intrastate' : 'interstate'
    } else if (vat) {
      group = 'VAT'
      type = 'VAT'
    } else {
      group = '';
    }
    this.taxInfo = {
      group,
      type
    }

  }
  addGstTax(type, value) {
    this.setGstType(type);
    this.setTaxGroup('GST')
    // this.taxInfo = {
    //   group: 'GST',
    //   type,
    // };
    // this.gstType = type;
    const valueForTax = this.calculatedPrice * (value / 100)
    let taxesToAdd = this.taxesData.filter(x => x.group === 'GST' && x.type === type);
    let taxesFiltered = this.taxes.filter(x => x.group === 'GST' && x.type === 'CESS');

    if (type === 'intrastate') {
      // taxesFiltered = this.taxes.filter(x => x.group === 'GST' && x.type !== 'interstate')
      taxesToAdd = taxesToAdd.map(x => ({ ...x, value: valueForTax / 2, enteredValue: value }))
    } else if (type === 'interstate') {
      // taxesFiltered = this.taxes.filter(x => x.group === 'GST' && x.type !== 'intrastate')
      taxesToAdd = taxesToAdd.map(x => ({ ...x, value: valueForTax, enteredValue: value }))
    } else if (type === 'CESS') {
      // taxesFiltered = this.taxes.filter(x => x.group === 'GST' && x.type !== 'CESS')
      taxesToAdd = taxesToAdd.map(x => ({ ...x, value: valueForTax, enteredValue: value }))
    }

    // taxesFiltered = taxesFiltered.filter((f) => {
    //   return taxesToAdd.find(x => x.name === f.name && x.group === f.group && x.type === f.type)
    // })
    this.taxes = [...taxesFiltered, ...taxesToAdd];
    this.totalTax = this.taxes.reduce((acc, c) => acc + c.value, 0);
    this.update()
  }
  addCessTax(value) {
    let taxesFiltered = this.taxes.filter(x => x.type !== 'CESS');
    const valueForTax = this.calculatedPrice * (value / 100)
    let taxesToAdd = this.taxesData.filter(x => x.type === 'CESS').map(x => ({ ...x, value: valueForTax, enteredValue: value }));
    this.taxes = [...taxesFiltered, ...taxesToAdd];
    this.update()
  }
  addVatTax(type, value) {
    this.taxInfo = {
      group: 'VAT',
      type
    };
    const valueForTax = this.calculatedPrice * (value / 100)
    let taxesToAdd = this.taxesData.filter(x => x.group === 'VAT' && x.type === 'VAT').map(x => ({ ...x, value: valueForTax, enteredValue: value }));
    // let taxesFiltered = this.taxes.filter(x => x.group === 'VAT');
    // alert(JSON.stringify(this.taxesData))
    this.taxes = taxesToAdd;
    this.update()
  }

  totalTaxes() {
    return this.totalTax = this.taxes.reduce((acc, c) => acc + c.value, 0);
  }

  changeName(name) {
    this.name = name;
    this.update();
  }

  changeQuantity(quantity) {
    this.quantity = quantity;
    this.update();
  }

  changePrice(price) {
    this.unitPrice = +price;
    this.update();
  }

  changeDiscount(discount) {
    this.discountEntered = +discount;
    this.update();
  }

  changeDiscountType(discount) {
    this.discountType = discount;
    this.update();
  }

  toggleGst() {
    const group = this.taxInfo.group;
    let value = '';
    if (group !== 'GST') {
      value = 'GST';
      this.addGstTax('intrastate', this.defaultGstTax)
    } else {
      this.setTaxGroup(value);
      this.taxes = []
      // this.setGstType('intrastate')
    }

  }
  toggleVat() {
    const group = this.taxInfo.group;
    let value = '';
    if (group !== 'VAT') {
      value = 'VAT';
      this.addVatTax('VAT', 0)
    } else {
      this.taxes = []
    }
    this.setTaxGroup(value);

  }

  setTaxGroup(group) {
    this.taxInfo.group = group;
    this.emit('change');
  }
  setGstType(type) {
    this.taxInfo.type = type;
    this.emit('change');
  }
  getVatValue() {
    const value = this.taxes.find(x => x.group === 'VAT')
    if (value) {
      return value.enteredValue
    }
    return null;
  }
  getTaxValue(name) {
    const value = this.taxes.find(x => x.group === this.taxInfo.group && x.name === name)
    if (value) {
      return value.enteredValue
    }
    return null;
  }
  isGstType(type) {
    return this.taxInfo.type === type;
  }
  updateTaxes() {
    this.taxes = this.taxes.map(tax => {

      if (tax.group === 'GST') {
        if (tax.type === 'intrastate') {
          const valueForTax = this.calculatedPrice * (tax.enteredValue / 100)
          return { ...tax, value: valueForTax / 2 }
        } else if (tax.type === 'interstate') {
          const valueForTax = this.calculatedPrice * (tax.enteredValue / 100)
          return { ...tax, value: valueForTax }
        } else if (tax.type === 'CESS') {
          const valueForTax = this.calculatedPrice * (tax.enteredValue / 100)
          return { ...tax, value: valueForTax }
        }
      } else if (tax.group === 'VAT') {
        const valueForTax = this.calculatedPrice * (tax.enteredValue / 100)
        return { ...tax, value: valueForTax }
      }
    })

    this.totalTaxes();
  }

  removeTax(type) {
    this.taxes = this.taxes.filter(x => x.type !== type)
    this.update()
  }

}