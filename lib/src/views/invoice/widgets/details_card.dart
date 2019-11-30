import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/payment_button_names.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/widgets/buttons/payment_method_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DetailsCard extends StatelessWidget {
  final bool isTablet;
  final bool footer;
  final Color headerBackgroundColor;
  final Color headerTextColor;
  const DetailsCard({
    Key key,
    this.isTablet = false,
    this.footer = true,
    this.headerBackgroundColor = Colors.white,
    this.headerTextColor = AppColors.BackPrimaryGray,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    return Container(
      margin: EdgeInsets.only(bottom: hp(1.2)),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.30,
        child: Container(
          color: Colors.white,
          child: EpaisaCard(
            borderRadius: BorderRadius.circular(hp(0.35)),
            margin: EdgeInsets.all(0),
            header: Container(
              color: headerBackgroundColor,
              padding: EdgeInsets.all(4),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        child: PaymentMethodButton(
                          paymentName: PaymentButtonNames.Loyalty,
                          size: isTablet ? hp(5.8) : hp(5),
                          onPress: () {},
                          fontSize: null,
                        ),
                      ),
                      Text(
                        'Loyalty',
                        style: TextStyle(
                          fontSize: isTablet ? hp(2.4) : wp(4.8),
                          fontWeight: FontWeight.w600,
                          color: headerTextColor,
                        ),
                      ),
                    ],
                  ),
                  if (!footer)
                    Container(
                      margin: EdgeInsets.only(right: hp(1)),
                      child: Text(
                        '₹ 500.00',
                        style: TextStyle(
                          fontSize: isTablet ? hp(2.5) : wp(4.8),
                          fontWeight: FontWeight.w700,
                          color: headerTextColor,
                        ),
                      ),
                    )
                ],
              ),
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: hp(2), vertical: hp(1)),
              child: Container(
                child: Column(
                  children: <Widget>[
                    DetailItem(
                      name: 'Invoice No.',
                      value: '45612',
                      width: 300,
                      isTablet: isTablet,
                      bold: footer,
                    ),
                    DetailItem(
                      name: 'Payment ID',
                      value: '789787',
                      width: 300,
                      isTablet: isTablet,
                      bold: footer,
                    ),
                    DetailItem(
                      name: eptxt('transaction_id'),
                      value: '845457',
                      width: 300,
                      isTablet: isTablet,
                      bold: footer,
                    ),
                    DetailItem(
                      name: 'Card No.',
                      value: 'XXXX XXXX XXXXX 8653',
                      width: 300,
                      isTablet: isTablet,
                      bold: footer,
                    ),
                    DetailItem(
                      name: eptxt('date'),
                      value: '12 August 2018',
                      width: 300,
                      isTablet: isTablet,
                      bold: footer,
                    ),
                    DetailItem(
                      name: eptxt('time'),
                      value: '12:35 PM',
                      width: 300,
                      isTablet: isTablet,
                      bold: footer,
                    )
                  ],
                ),
              ),
            ),
            footer: footer
                ? Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: hp(2), vertical: hp(1.4)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          eptxt('amount_paid'),
                          style: TextStyle(
                              fontSize: isTablet ? 24 : wp(4.6),
                              fontWeight: FontWeight.w700,
                              color: AppColors.BackPrimaryGray),
                        ),
                        Text(
                          '₹ 70.00',
                          style: TextStyle(
                            fontSize: isTablet ? 24 : wp(4.6),
                            fontWeight: FontWeight.w700,
                            color: AppColors.PrimaryBlue,
                          ),
                        )
                      ],
                    ),
                  )
                : null,
          ),
        ),
        secondaryActions: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(74, 74, 74, 1),
            ),
            // color: Colors.brown,
            // height: 300,
            child: Center(
              child: Text(
                eptxt('refund'),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: isTablet ? 24 : 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String name;
  final String value;
  final double width;
  final bool isTablet;
  final bool bold;
  final bool endField;
  const DetailItem({
    Key key,
    this.name,
    this.value,
    this.width,
    this.isTablet,
    this.bold,
    this.endField = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    final double fontSize = isTablet ? hp(1.83) : wp(3.2);
    return Container(
      margin: EdgeInsets.only(bottom: hp(endField ? 0 : 0.8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: !bold ? FontWeight.w600 : FontWeight.w700,
                  fontSize: fontSize,
                  color: AppColors.DarkGray,
                ),
              ),
            ),
            flex: 40,
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: hp(4),
            // decoration: BoxDecoration(color: Colors.red),
            child: Text(
              ':',
              style: TextStyle(
                fontWeight: !bold ? FontWeight.w500 : FontWeight.w600,
                fontSize: fontSize,
                color: AppColors.BackPrimaryGray,
              ),
            ),
          ),
          Expanded(
            flex: 60,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: !bold ? FontWeight.w600 : FontWeight.w600,
                  fontSize: fontSize * 0.95,
                  color: AppColors.BackPrimaryGray.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
