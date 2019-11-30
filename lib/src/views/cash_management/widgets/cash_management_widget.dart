import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';

class CashManagementWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    double fontSize = tablet ? hp(2.3) : wp(4);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.65 : width * 0.85;
    var layoutHeight = tablet ? height : height * 0.8;

    Widget buildEnableCashWidget() {
      return Container(
          padding: EdgeInsets.only(
              top: tablet ? hp(2) : wp(3),
              left: tablet ? hp(4) : wp(3),
              right: tablet ? hp(4) : wp(3)),
          child: CardItem(
            fontSize: tablet ? hp(2.5) : wp(3.6),
            horizontalMobileCard: 3,
            verticalMobileCard: 1.2,
            spaceBeforeTextMobile: tablet ? 1 : 2,
            horizontalTabletCard: 2,
            verticalTabletCard: 1.2,
            borderRadiusValue: wp(0.08),
            borderMobileRadiusValue: 0.7,
            title: "Enable Cash Tracking",
            showForwardArrow: false,
            otherWidget: ButtonToggle(
              confirmDialog: true,
              size: tablet ? hp(1.6) : wp(3),
            ),
          ));
    }

    Widget buildCashRegisterWidget() {
      return TextfieldDropdown(
        items: [
          {"name": "Cash Register Main", "value": 0},
          {"name": "Cash Register Main", "value": 1},
        ],
        paddingBottomInput: hp(1),
        fontSize: fontSize,
        alwaysBlue: !tablet,
        showBlueDropdownColor: !tablet,
        labelText: "Select Cash Register",
      );
    }

    Widget buildEstimatedCashWidget() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Estimated Cash in Drawer",
            overflow: TextOverflow.clip,
            style: TextStyle(
              color: AppColors.PrimaryBlue,
              fontSize: tablet ? hp(3) : wp(4.3),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("₹ 423.50",
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: AppColors.SuccessText,
                fontSize: tablet ? hp(3.4) : wp(4.3),
                fontWeight: FontWeight.bold,
              ))
        ],
      );
    }

    Widget buildPayInOutWidget() {
      return TextfieldClassic(
        paddingBottomInput: hp(1),
        fontSize: fontSize,
        labelText: "Pay In/Pay Out",
        alwaysFocus: true,
        hintText: "Enter Amount",
        showClearButton: false,
        alwaysBlue: !tablet,
      );
    }

    Widget buildPayInWidget() {
      return Expanded(
        child: ButtonGradient(
          paddingVertical: tablet ? hp(2.1) : hp(1.8),
          borderRadius: hp(2),
          fontSize: tablet ? hp(1.9) : hp(1.7),
          title: "PAY IN",
        ),
      );
      /*return ButtonGradiant(
        layoutHeight * (tablet ? hp(0.003) : wp(0.025)),
        layoutwidth * (tablet ? hp(0.06) : wp(1.90)),
        'PAY IN',
        borderRadius: hp(2),
        textStyle: TextStyle(
            fontSize: tablet ? layoutHeight * 0.02 : layoutHeight * 0.025,
            color: AppColors.PrimaryWhite,
            fontWeight: FontWeight.w600),
        onPressed: () {},
      );*/
    }

    Widget buildPayOutWidget() {
      return Expanded(
        child: ButtonGradient(
          paddingVertical: tablet ? hp(2.1) : hp(1.8),
          borderRadius: hp(2),
          fontSize: tablet ? hp(1.9) : hp(1.7),
          title: "PAY OUT",
        ),
      );
    }

    Widget buildCloseDrawerWidget() {
      return tablet
          ? Expanded(
              child: ButtonGradient(
                paddingVertical: tablet ? hp(2.1) : hp(1.8),
                borderRadius: hp(2),
                fontSize: tablet ? hp(1.9) : hp(1.7),
                title: "CLOSE DRAWER",
              ),
            )
          : ButtonGradient(
              paddingVertical: tablet ? hp(2.1) : hp(1.8),
              borderRadius: hp(2),
              fontSize: tablet ? hp(1.9) : hp(1.7),
              title: "CLOSE DRAWER",
            );
    }

    Widget buildButtons() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildPayInWidget(),
          SizedBox(
            width: wp(1),
          ),
          buildCloseDrawerWidget(),
          SizedBox(
            width: wp(1),
          ),
          buildPayOutWidget()
        ],
      );
    }

    Widget buttonForMobile() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildPayInWidget(),
              SizedBox(
                width: wp(6),
              ),
              buildPayOutWidget()
            ],
          ),
          SizedBox(
            height: tablet ? hp(1) : wp(4),
          ),
          buildCloseDrawerWidget(),
        ],
      );
    }

    Widget buildTableColumn(
        {String title, Alignment align = Alignment.center}) {
      return Container(
        alignment: align,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: tablet ? hp(1.6) : wp(2.3),
            color: AppColors.PrimaryWhite,
          ),
        ),
      );
    }

    Widget buildTableRows(
        {String title,
        Color textColor,
        Alignment align = Alignment.center,
        TextAlign textalign = TextAlign.center}) {
      return Container(
        alignment: align,
        child: Text(
          title,
          textAlign: textalign,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: tablet ? hp(1.5) : wp(2.3),
            color: textColor ?? AppColors.BackPrimaryGray,
          ),
        ),
      );
    }

    Widget buildTableDataRows(
        {String date = '',
        String name = '',
        String payIn = '',
        String payOut = '',
        String reason = ''}) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: tablet ? hp(1.5) : wp(2),
                horizontal: tablet ? hp(3.3) : wp(2)),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: tablet ? 2 : 5,
                  child: buildTableRows(
                      title: date,
                      align: Alignment.centerLeft,
                      textalign: TextAlign.left),
                ),
                if (tablet)
                  Expanded(
                    flex: 3,
                    child: buildTableRows(title: "Nicholas Brunner"),
                  ),
                Expanded(
                  flex: tablet ? 3 : 7,
                  child: buildTableRows(
                      title: name,
                      align: tablet ? Alignment.center : Alignment.centerLeft),
                ),
                Expanded(
                  flex: tablet ? 2 : 3,
                  child: buildTableRows(
                      title: payIn, textColor: AppColors.SuccessText),
                ),
                Expanded(
                  flex: tablet ? 2 : 3,
                  child: buildTableRows(
                      title: payOut, textColor: AppColors.ErrorText),
                ),
                Expanded(
                  flex: tablet ? 2 : 3,
                  child: buildTableRows(
                      title: reason,
                      align: Alignment.centerRight,
                      textalign: TextAlign.right),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.Gray, width: 1.0),
              ),
            ),
          )
          //Divider(color: AppColors.BackPrimaryGray),
        ],
      );
    }

    Widget buildTables() {
      return Table(
        children: [
          TableRow(children: [
            Container(
              color: AppColors.BorderGray,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: tablet ? hp(1) : wp(2),
                      horizontal: tablet ? hp(3.3) : wp(2)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: tablet ? 2 : 5,
                          child: buildTableColumn(
                              title: tablet ? "TIME" : "DATE & TIME",
                              align: Alignment.centerLeft)),
                      if (tablet)
                        Expanded(
                          flex: 3,
                          child: buildTableColumn(title: "AUTHORIZER"),
                        ),
                      Expanded(
                        flex: tablet ? 3 : 7,
                        child: buildTableColumn(
                            title: "EMPLOYEE",
                            align: tablet
                                ? Alignment.center
                                : Alignment.centerLeft),
                      ),
                      Expanded(
                        flex: tablet ? 2 : 3,
                        child: buildTableColumn(title: "PAY IN"),
                      ),
                      Expanded(
                        flex: tablet ? 2 : 3,
                        child: buildTableColumn(title: "PAY OUT"),
                      ),
                      Expanded(
                        flex: tablet ? 2 : 3,
                        child: buildTableColumn(
                            title: "REASON", align: Alignment.centerRight),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
          TableRow(children: [
            Container(
              color: AppColors.PrimaryWhite,
              child: Column(
                children: <Widget>[
                  //SizedBox(height: wp(2),),
                  buildTableDataRows(
                      date: tablet ? "7:30 PM" : "31 May, 7:30 PM",
                      name: "Aaron Curry",
                      payIn: "₹ 120.00",
                      reason: "Other"),
                  buildTableDataRows(
                      date: tablet ? "7:30 PM" : "31 May, 6:45 PM",
                      name: "Daymond James",
                      payOut: "- ₹ 250.00",
                      reason: "Delivery"),
                ],
              ),
            ),
          ]),
        ],
      );
    }

    Widget buildCashManagement() {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: tablet ? hp(1) : wp(4),
            ),
            buildEnableCashWidget(),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  tablet ? hp(4) : wp(5),
                  tablet ? hp(2) : wp(5),
                  tablet ? hp(4) : wp(5),
                  tablet ? hp(2.4) : wp(3)),
              child: Column(
                children: <Widget>[
                  buildCashRegisterWidget(),
                  SizedBox(
                    height: tablet ? hp(1.6) : wp(3),
                  ),
                  buildEstimatedCashWidget(),
                  SizedBox(
                    height: tablet ? hp(1.6) : wp(3),
                  ),
                  buildPayInOutWidget(),
                  SizedBox(
                    height: tablet ? hp(1.6) : wp(3),
                  ),
                  tablet ? buildButtons() : buttonForMobile(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: hp(0.5),
                  left: tablet ? hp(4) : wp(0),
                  right: tablet ? hp(4) : wp(0)),
              child: buildTables(),
            ),
          ],
        )),
      );
    }

    return buildCashManagement();
  }
}
