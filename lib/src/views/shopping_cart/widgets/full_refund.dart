import 'package:epaisa_pos/src/models/OrderItem.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/payments/widgets/transaction_details.dart';
import 'package:epaisa_pos/src/views/transactions/views/partial_refund_dialog.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:flutter/material.dart';

class FullRefund extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    Widget refundView() {
      return Container(
        padding: EdgeInsets.fromLTRB(wp(1), 0, wp(1), 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: buildBorderBottom(),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: hp(1.2),
                          ),
                          child: Text(
                            'Reason for Refund',
                            style: TextStyle(
                              color: AppColors.BackPrimaryGray,
                              fontSize: hp(2),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: hp(1)),
                    child: Column(
                      children: <Widget>[
                        SmallCheckWithLabel(
                          hp: hp,
                          tablet: tablet,
                          wp: wp,
                          label: 'Returned Goods',
                        ),
                        SmallCheckWithLabel(
                          hp: hp,
                          tablet: tablet,
                          wp: wp,
                          label: 'Accidental Charge',
                        ),
                        SmallCheckWithLabel(
                          hp: hp,
                          tablet: tablet,
                          wp: wp,
                          label: 'Cancelled Order',
                        ),
                        SmallCheckWithLabel(
                          hp: hp,
                          tablet: tablet,
                          wp: wp,
                          label: 'Other',
                        ),
                        Container(
                          padding: EdgeInsets.only(left: hp(4)),
                          child: OutlineInput(
                            hp: hp,
                            wp: wp,
                            tablet: true,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // margin: EdgeInsets.all(hp(2)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: hp(1)),
                      child: EpaisaButton.withBorder(
                        title: 'CREDIT NOTE',
                        textStyle: TextStyle(fontWeight: FontWeight.w700,color:AppColors.PrimaryBlue),

                        onPress: () {
                          // Navigator.of(context)
                          //     .pushReplacement(PageRouteBuilder(
                          //   opaque: false,
                          //   pageBuilder: (BuildContext context, _, __) {
                          //     return CreditNoteDialog();
                          //   },
                          // ));
                        },
                        borderColor: AppColors.PrimaryBlue,
                        borderRadius: BorderRadius.circular(
                          hp(1.5),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // padding: EdgeInsets.only(left: hp(1)),
                      child: EpaisaButton.withBorder(
                        textStyle: TextStyle(fontWeight: FontWeight.w700,color:AppColors.PrimaryBlue),
                        title: 'CASH',
                        onPress: () {},
                        borderColor: AppColors.PrimaryBlue,
                        borderRadius: BorderRadius.circular(
                          hp(1.5),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget productdetails() {
      final List<OrderItem> products = [
        OrderItem(
          description: 'Heinz Ketchup',
          price: '145.00',
          quantity: '1',
        ),
        OrderItem(
          description: 'Custom Product 2',
          price: '145.00',
          quantity: '1',
          discount: Discount(calculated: '14.50', type: '%', value: '10'),
        ),
        OrderItem(
          description: 'Custom Product 3',
          price: '145.00',
          quantity: '3',
        ),
      ];

      return Container(
        alignment: Alignment.center,
        // margin: EdgeInsets.only(top: hp(0.2)),
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: hp(1)),
        height: wp(26),
        decoration: buildBorderBottom(),
        child: ScrollConfiguration(
          behavior: RemoveOverScrollGlow(),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: hp(0.5), horizontal: hp(1)),
                    decoration: buildBorderBottom(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 20,
                          child: Container(
                            // color: Colors.yellow,
                            alignment: Alignment.center,
                            // padding: EdgeInsets.only(left: hp(2)),
                            // color: Colors.red,
                            child: Text(
                              'Qty',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: hp(1.9),
                                color: AppColors.BackPrimaryGray,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 45,
                          child: Container(
                            // color: Colors.blue,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: hp(1.9),
                                  color: AppColors.BackPrimaryGray),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 35,
                          child: Container(
                            // color: Colors.red,
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Price',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: hp(1.9),
                                color: AppColors.BackPrimaryGray,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...products.map((i) {
                    var quantity = int.parse(i.quantity);
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: hp(1)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 80,
                            child: OrderTableItem(
                              hp: hp,
                              description: i.description,
                              price: i.price,
                              quantity: i.quantity,
                              discount: i.discount,
                              customOrder: {
                                "first": {"column": 'quantity', "flex": 20},
                                "second": {"column": 'description', "flex": 45},
                                "third": {"column": 'price', "flex": 35},
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList()
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: Column(
        children: <Widget>[
          productdetails(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: hp(1)),
              child: refundView(),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBorderBottom() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color(0xFFEBEBEB),
          width: 0.8,
        ),
      ),
    );
  }
}
