import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/add_customer_hold_dialog.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/custom_fields_dialog.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/row_product.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_color.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:flutter/material.dart';

class CartOrderSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    void _showDialog() {
      // flutter defined function
      Navigator.of(context).pushReplacement(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return AddCustomerHoldDialog();
        },
      ));
    }

    void _showCustomFields() {
      // flutter defined function
      Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return CustomFieldsDialog();
        },
      ));
    }

    Widget _tabletProducts() {
      List<Map<String, dynamic>> products = [
        {
          "id": "1.",
          "description": "Heinz Ketchup",
          "Qty": "999",
          "Price": "145,148.50"
        },
        {
          "id": "2.",
          "description": "Custom Product 2",
          "Qty": "1",
          "Price": "125.00"
        },
        {
          "id": "3.",
          "description": "Custom Product 3",
          "Qty": "3",
          "Price": "275.50"
        },
      ];
      List<Widget> list = new List<Widget>();
      for (var i = 0; i < products.length; i++) {
        list.add(RowProduct(product: products[i]));
      }
      Widget headerTable = Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColors.TextGray.withOpacity(0.3),
            ),
          ),
        ),
        padding: EdgeInsets.fromLTRB(wp(0.2), hp(0.7), wp(1.6), hp(0.7)),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: tablet ? wp(2.5) : wp(6.2),
            ),
            Expanded(
              flex: 12,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  eptxt('description'),
                  style: TextStyle(
                      fontSize: hp(2),
                      fontWeight: FontWeight.w700,
                      color: AppColors.BackPrimaryGray),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  eptxt('qty'),
                  style: TextStyle(
                      fontSize: hp(2),
                      fontWeight: FontWeight.w700,
                      color: AppColors.BackPrimaryGray),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  eptxt('price'),
                  style: TextStyle(
                      fontSize: hp(2),
                      fontWeight: FontWeight.w700,
                      color: AppColors.BackPrimaryGray),
                ),
              ),
            )
          ],
        ),
      );

      return Expanded(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/splashscreen/background.png",
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              headerTable,
              products.length > 0
                  ? Expanded(
                      child:
                          SingleChildScrollView(child: Column(children: list)))
                  : Expanded(
                      child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                              height: hp(22),
                            ),
                            SizedBox(
                              height: hp(2),
                            ),
                            Text(
                              eptxt('your_cart_is_empty'),
                              style: TextStyle(
                                  fontSize: hp(2.7),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.IconGray),
                            )
                          ],
                        ),
                      ),
                    )),
            ],
          ),
        ),
      );
    }

    Widget _fotterContainer() {
      return Container(
        padding: EdgeInsets.fromLTRB(
            tablet ? wp(1) : wp(3), 0, tablet ? wp(1) : wp(3), 0),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 1, color: AppColors.TextGray.withOpacity(0.3)))),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: hp(1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  eptxt('sub_total'),
                  style: TextStyle(
                      fontSize: hp(2.5),
                      fontWeight: FontWeight.w700,
                      color: AppColors.DarkGray),
                ),
                Text("₹ 0.00",
                    style: TextStyle(
                        fontSize: hp(2.5),
                        fontWeight: FontWeight.w700,
                        color: AppColors.PrimaryBlue))
              ],
            ),
            SizedBox(
              height: hp(0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(eptxt('total_amount'),
                    style: TextStyle(
                        fontSize: hp(3),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray)),
                Text("₹ 0.00",
                    style: TextStyle(
                        fontSize: hp(3),
                        fontWeight: FontWeight.w700,
                        color: AppColors.PrimaryBlue))
              ],
            ),
            SizedBox(
              height: hp(0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: ButtonColor(
                    callback: () {
                      searchCustomer(context, () => _showDialog());
                    },
                    paddingVertical: hp(1.5),
                    borderRadius: hp(1),
                    primary: AppColors.Gray,
                    secondary: AppColors.Gray,
                    textColor: AppColors.DarkGray,
                    fontWeight: FontWeight.w700,
                    fontSize: hp(2.5),
                    title: eptxt('hold').toUpperCase(),
                  ),
                ),
                SizedBox(
                  width: tablet ? wp(1) : wp(3),
                ),
                Expanded(
                  flex: 5,
                  child: ButtonColor(
                    callback: () {
                      _showCustomFields();
                    },
                    paddingVertical: hp(1.5),
                    borderRadius: hp(1),
                    primary: AppColors.Gray,
                    secondary: AppColors.Gray,
                    textColor: AppColors.DarkGray,
                    fontWeight: FontWeight.w700,
                    fontSize: hp(2.5),
                    title: "${eptxt('pay').toUpperCase()} ₹ 0.00",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: hp(1.6),
            ),
          ],
        ),
      );
    }

    return Expanded(
      child: Column(
        children: <Widget>[
          _tabletProducts(),
          _fotterContainer(),
        ],
      ),
    );
  }
}
