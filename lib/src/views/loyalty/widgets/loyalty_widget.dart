import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';

class LoyaltyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final bool tablet = isTablet(MediaQuery.of(context));

    Widget buildTitleText({String titleText}) {
      return Text(
        titleText,
        style: TextStyle(
            color: AppColors.PrimaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: tablet ? hp(2.5) : wp(4.5)),
      );
    }

    Widget buildColumnStructure({
      List<Widget> children,
    }) {
      return Padding(
        padding: EdgeInsets.only(
            left: tablet ? hp(5) : wp(5),
            right: tablet ? hp(5) : wp(5),
            bottom: tablet ? hp(4) : wp(5),
            top: tablet ? hp(2) : wp(5)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: children),
      );
    }

    Widget buildDivider() {
      return Container(
        height: 0.4,
        padding: EdgeInsets.all(tablet ? hp(0.1) : wp(0.1)),
        color: Colors.grey,
      );
    }

    Widget smsSettingRowStructure(
        {String settingTitle, String settingDesc, Widget child}) {
      return Padding(
        padding: EdgeInsets.only(
            left: tablet ? hp(5) : wp(5),
            right: tablet ? hp(0) : wp(5),
            bottom: tablet ? hp(2.5) : wp(5),
            top: tablet ? hp(1) : wp(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      settingTitle,
                      style: TextStyle(
                        fontSize: tablet ? hp(2.5) : wp(4),
                        fontWeight: FontWeight.w600,
                        color: AppColors.DarkGray,
                      ),
                    ),
                    SizedBox(
                      height: tablet ? hp(1) : wp(2),
                    ),
                    Text(
                      settingDesc,
                      style: TextStyle(
                        fontSize: tablet ? hp(1.5) : wp(2.2),
                        fontWeight: FontWeight.w600,
                        color: AppColors.DarkGray,
                      ),
                    ),
                  ],
                )),
            Expanded(
                flex: 2,
                child: Container(
                    margin: EdgeInsets.only(left: hp(1), bottom: hp(1)),
                    child: Image.asset(
                      "assets/createaccount/disagree.png",
                      height: tablet ? hp(5.8) : hp(5.8),
                    ))),
          ],
        ),
      );
    }

    Widget buildEqualSign() {
      return Padding(
        padding: EdgeInsets.only(
          left: tablet ? hp(2) : wp(1),
          right: tablet ? hp(2) : wp(1),
          top: tablet ? hp(1) : wp(3),
        ),
        child: Text(
          "=",
          style: TextStyle(
              color: AppColors.PrimaryBlue,
              fontWeight: tablet ? FontWeight.w500 : FontWeight.bold,
              fontSize: wp(tablet ? hp(0.2) : wp(1.3))),
        ),
      );
    }

    Widget buildPurchasePoint() {
      return buildColumnStructure(children: [
        buildTitleText(titleText: "Purchase Points"),
        SizedBox(
          height: tablet ? hp(0.01) : wp(3),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                flex: tablet ? 3 : 3,
                child: Text(
                  "Price to Points Conversion",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : wp(4),
                      fontWeight: FontWeight.w600,
                      color: AppColors.DarkGray),
                )),
            SizedBox(
              width: tablet ? hp(8) : wp(9),
            ),
            Expanded(
              flex: tablet ? 1 : 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Amount(₹)",
                    style: TextStyle(
                        fontSize: (tablet ? hp(2.35) : wp(4)) * 0.8,
                        fontWeight: FontWeight.w600,
                        color: AppColors.DisabledText),
                  ),
                  SizedBox(height: (tablet ? hp(1.5) : wp(4)) * 0.1),
                  TextfieldClassic(
                    alwaysFocus: true,
                    alwaysBlue: true,
                    paddingBottomInput: tablet ? hp(1.8) : wp(0.8),
                    center: true,
                    fontSize: tablet ? hp(2.5) : wp(4),
                    showClearButton: false,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: tablet ? hp(2) : wp(1),
            ),
            buildEqualSign(),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            Flexible(
              flex: tablet ? 1 : 2,
              child: TextfieldClassic(
                labelText: "Point",
                paddingBottomInput: hp(tablet ? 1 : 0.8),
                center: true,
                fontSize: tablet ? hp(2.35) : wp(4),
                alwaysFocus: true,
                alwaysBlue: true,
                showClearButton: false,
              ),
            )
          ],
        )
      ]);
    }

    Widget buildRedeemPoint() {
      return buildColumnStructure(children: [
        buildTitleText(titleText: "Redeem Points"),
        SizedBox(
          height: tablet ? hp(0.01) : wp(3),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                flex: tablet ? 3 : 3,
                child: Text(
                  "Point to Price Conversion",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : wp(4),
                      fontWeight: FontWeight.w600,
                      color: AppColors.DarkGray),
                )),
            SizedBox(
              width: tablet ? hp(8) : wp(9),
            ),
            Flexible(
              flex: tablet ? 1 : 2,
              child: TextfieldClassic(
                labelText: "Point",
                alwaysFocus: true,
                alwaysBlue: true,
                paddingBottomInput: hp(tablet ? 1 : 0.8),
                center: true,
                fontSize: tablet ? hp(2.35) : wp(4),
                showClearButton: false,
              ),
            ),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            buildEqualSign(),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            Flexible(
              flex: tablet ? 1 : 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Amount(₹)",
                    style: TextStyle(
                        fontSize: (tablet ? hp(2.35) : wp(4)) * 0.8,
                        fontWeight: FontWeight.w600,
                        color: AppColors.DisabledText),
                  ),
                  SizedBox(height: (tablet ? hp(1.5) : wp(4)) * 0.1),
                  TextfieldClassic(
                    alwaysFocus: true,
                    alwaysBlue: true,
                    paddingBottomInput: hp(tablet ? 1 : 0.8),
                    center: true,
                    fontSize: tablet ? hp(2.5) : wp(4),
                    showClearButton: false,
                  ),
                ],
              ),
            )
          ],
        )
      ]);
    }

    Widget buildPointExpiry() {
      return buildColumnStructure(children: [
        buildTitleText(titleText: "Points expiry"),
        SizedBox(
          height: tablet ? hp(0.01) : wp(3),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                flex: tablet ? 4 : 5,
                child: Text(
                  "Points expiry Days",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : wp(4),
                      fontWeight: FontWeight.w600,
                      color: AppColors.DarkGray),
                )),
            SizedBox(
              width: tablet ? hp(8) : wp(9),
            ),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            buildEqualSign(),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            Flexible(
              flex: tablet ? 1 : 2,
              child: TextfieldClassic(
                labelText: "Days",
                alwaysFocus: true,
                alwaysBlue: true,
                paddingBottomInput: tablet ? hp(1) : wp(2),
                center: true,
                fontSize: tablet ? hp(2.35) : wp(4),
                showClearButton: false,
              ),
            )
          ],
        )
      ]);
    }

    Widget buildNotifyCustomer() {
      return buildColumnStructure(children: [
        buildTitleText(titleText: "Notify Customer"),
        SizedBox(
          height: tablet ? hp(0.01) : wp(3),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                flex: tablet ? 4 : 5,
                child: Text(
                  "Days to Notify Customer",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : wp(4),
                      fontWeight: FontWeight.w600,
                      color: AppColors.DarkGray),
                )),
            SizedBox(
              width: tablet ? hp(8) : wp(9),
            ),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            buildEqualSign(),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            Flexible(
              flex: tablet ? 1 : 2,
              child: TextfieldClassic(
                labelText: "Days",
                alwaysFocus: true,
                alwaysBlue: true,
                paddingBottomInput: tablet ? hp(1) : wp(2),
                center: true,
                fontSize: tablet ? hp(2.35) : wp(4),
                showClearButton: false,
              ),
            )
          ],
        )
      ]);
    }

    Widget buildAdvanceSetting() {
      return buildColumnStructure(children: [
        buildTitleText(titleText: "Advance Settings"),
        SizedBox(
          height: tablet ? hp(0.01) : wp(3),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                flex: tablet ? 4 : 5,
                child: Text(
                  "Birthday Points",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : wp(4),
                      fontWeight: FontWeight.w600,
                      color: AppColors.DarkGray),
                )),
            SizedBox(
              width: tablet ? hp(8) : wp(9),
            ),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            buildEqualSign(),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            Flexible(
              flex: tablet ? 1 : 2,
              child: TextfieldClassic(
                labelText: "Points",
                alwaysFocus: true,
                alwaysBlue: true,
                paddingBottomInput: tablet ? hp(1) : wp(2),
                center: true,
                fontSize: tablet ? hp(2.35) : wp(4),
                showClearButton: false,
              ),
            )
          ],
        )
      ]);
    }

    Widget buildAnniversaryPoints() {
      return buildColumnStructure(children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                flex: tablet ? 4 : 5,
                child: Text(
                  "Anniversary Points",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : wp(4),
                      fontWeight: FontWeight.w600,
                      color: AppColors.DarkGray),
                )),
            SizedBox(
              width: tablet ? hp(8) : wp(9),
            ),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            buildEqualSign(),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            Flexible(
              flex: tablet ? 1 : 2,
              child: TextfieldClassic(
                labelText: "Points",
                alwaysFocus: true,
                alwaysBlue: true,
                paddingBottomInput: tablet ? hp(1) : wp(2),
                center: true,
                fontSize: tablet ? hp(2.35) : wp(4),
                showClearButton: false,
              ),
            )
          ],
        )
      ]);
    }

    Widget buildMaxPoint() {
      return buildColumnStructure(children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                flex: tablet ? 4 : 5,
                child: Text(
                  "Max Points Redeemed Per Order",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : wp(4),
                      fontWeight: FontWeight.w600,
                      color: AppColors.DarkGray),
                )),
            SizedBox(
              width: tablet ? hp(8) : wp(9),
            ),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            buildEqualSign(),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            Flexible(
              flex: tablet ? 1 : 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Points",
                    style: TextStyle(
                        fontSize: (tablet ? hp(2.35) : wp(4)) * 0.8,
                        fontWeight: FontWeight.w600,
                        color: AppColors.DisabledText),
                  ),
                  SizedBox(height: (tablet ? hp(1.5) : wp(4)) * 0.1),
                  TextfieldClassic(
                    alwaysFocus: true,
                    alwaysBlue: true,
                    paddingBottomInput: hp(tablet ? 1 : 0.8),
                    center: true,
                    fontSize: tablet ? hp(2.35) : wp(4),
                    showClearButton: false,
                  ),
                ],
              ),
            )
          ],
        )
      ]);
    }

    Widget buildMinOrderEarn() {
      return buildColumnStructure(children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                flex: tablet ? 4 : 5,
                child: Text(
                  "Minimum Order Amount to Earn Points",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : wp(4),
                      fontWeight: FontWeight.w600,
                      color: AppColors.DarkGray),
                )),
            SizedBox(
              width: tablet ? hp(8) : wp(9),
            ),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            buildEqualSign(),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            Flexible(
              flex: tablet ? 1 : 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Amount(₹)",
                    style: TextStyle(
                        fontSize: (tablet ? hp(2.35) : wp(4)) * 0.8,
                        fontWeight: FontWeight.w600,
                        color: AppColors.DisabledText),
                  ),
                  SizedBox(height: (tablet ? hp(1.5) : wp(4)) * 0.1),
                  TextfieldClassic(
                    alwaysFocus: true,
                    alwaysBlue: true,
                    paddingBottomInput: tablet ? hp(1) : hp(0.8),
                    center: true,
                    fontSize: tablet ? hp(2.5) : wp(4),
                    showClearButton: false,
                  ),
                ],
              ),
            )
          ],
        )
      ]);
    }

    Widget buildMinOrderRedeem() {
      return buildColumnStructure(children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                flex: tablet ? 4 : 5,
                child: Text(
                  "Minimum Order Amount to Redeem Points",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : wp(4),
                      fontWeight: FontWeight.w600,
                      color: AppColors.DarkGray),
                )),
            SizedBox(
              width: tablet ? hp(8) : wp(9),
            ),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            buildEqualSign(),
            SizedBox(
              width: tablet ? hp(1) : wp(1),
            ),
            Flexible(
              flex: tablet ? 1 : 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Amount(₹)",
                    style: TextStyle(
                        fontSize: (tablet ? hp(2.35) : wp(4)) * 0.8,
                        fontWeight: FontWeight.w600,
                        color: AppColors.DisabledText),
                  ),
                  SizedBox(height: (tablet ? hp(1.5) : wp(4)) * 0.1),
                  TextfieldClassic(
                    alwaysFocus: true,
                    alwaysBlue: true,
                    paddingBottomInput: hp(tablet ? 1 : 0.8),
                    center: true,
                    fontSize: tablet ? hp(2.5) : wp(4),
                    showClearButton: false,
                  ),
                ],
              ),
            )
          ],
        )
      ]);
    }

    Widget buildLoyalty() {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildPurchasePoint(),
            buildDivider(),
            buildRedeemPoint(),
            buildDivider(),
            buildPointExpiry(),
            buildDivider(),
            buildNotifyCustomer(),
            buildDivider(),
            buildAdvanceSetting(),
            buildDivider(),
            buildAnniversaryPoints(),
            buildDivider(),
            buildMaxPoint(),
            buildDivider(),
            buildMinOrderEarn(),
            buildDivider(),
            buildMinOrderRedeem(),
            buildDivider(),
            Padding(
              padding: EdgeInsets.only(
                  left: tablet ? hp(5) : wp(5),
                  right: tablet ? hp(0) : wp(5),
                  bottom: tablet ? hp(0) : wp(1),
                  top: tablet ? hp(1) : wp(2)),
              child: buildTitleText(titleText: "SMS Settings"),
            ),
            smsSettingRowStructure(
              settingTitle: "Send Points Earned SMS",
              settingDesc:
                  "Enabling this setting will send a message informing about the loyalty points earned and the points available to the customer.",
            ),
            buildDivider(),
            smsSettingRowStructure(
              settingTitle: "Send Points Redeemed SMS",
              settingDesc:
                  "Enabling this setting will send a message informing about the loyalty points redeemed and the points available to the customer.",
            ),
            buildDivider(),
            smsSettingRowStructure(
              settingTitle: "Send OTP to Redeem Points",
              settingDesc:
                  "Enabling this setting will send an OTP to redeem the points of the customer.",
            ),
            buildDivider(),
            smsSettingRowStructure(
              settingTitle: "Send SMS on Registration",
              settingDesc:
                  "Enabling this setting will automatically send a custom welcome message to the customer.",
            ),
            buildDivider(),
            smsSettingRowStructure(
              settingTitle: "Send SMS on Birthday",
              settingDesc:
                  "Enabling this setting will automatically send a custom message to the customer on his/her birthday.",
            ),
            buildDivider(),
            smsSettingRowStructure(
              settingTitle: "Send SMS on Anniversary",
              settingDesc:
                  "Enabling this setting will automatically send a custom message to the customer on his/her anniversary.",
            ),
            buildDivider(),
            SizedBox(
              height: tablet ? hp(1) : wp(6),
            ),
          ],
        ),
      );
    }

    return buildLoyalty();
  }
}
