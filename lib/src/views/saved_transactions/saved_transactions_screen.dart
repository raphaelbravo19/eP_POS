import 'package:epaisa_pos/src/models/OrderItem.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/cash_register/cash_register.dart';
import 'package:epaisa_pos/src/views/payments/widgets/transaction_details.dart';
import 'package:epaisa_pos/src/views/screen_with_cart/screen_with_cart.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_common.dart';
import 'package:epaisa_pos/src/widgets/icons/cart_number.dart';
import 'package:epaisa_pos/src/widgets/icons/stack_number.dart';
import 'package:flutter/material.dart';

class SavedTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function hp = ScreenUtils.of(context).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    var tablet = isTablet(MediaQuery.of(context));
    return tablet
        ? ScreenWithCart(
            body: _buildContent(context, hp, wp, tablet),
          )
        : _buildContent(context, hp, wp, tablet);
  }

  EpaisaScaffold _buildContent(
      BuildContext context, Function hp, Function wp, bool tablet) {
    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        openDrawer: () {
          Scaffold.of(context).openDrawer();
        },
        menu: true,
        title: eptxt('point_of_sale').toUpperCase(),
        trailing: <Widget>[
          Container(
            child: StackNumber(
              number: 5,
              size: tablet ? wp(2.5) : hp(3.5),
            ),
          ),
          if (!tablet)
            GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Container(
                  margin: EdgeInsets.only(left: wp(3), right: wp(.5)),
                  child: CartNumber(
                    number: 3,
                    size: tablet ? hp(3) : wp(7),
                  )),
            )
        ],
      ),
      body: Column(
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          Expanded(
            child: ScrollConfiguration(
              behavior: RemoveOverScrollGlow(),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(hp(2)),
                child: Column(
                  children: <Widget>[
                    Dismissible(
                      key: GlobalKey(),
                      child: SavedTransactionItem(
                          wp: wp, hp: hp, isTablet: tablet),
                    ),
                    Dismissible(
                      key: GlobalKey(),
                      child: SavedTransactionItem(
                          wp: wp, hp: hp, isTablet: tablet),
                    ),
                    Dismissible(
                      key: GlobalKey(),
                      child: SavedTransactionItem(
                          wp: wp, hp: hp, isTablet: tablet),
                    ),
                    Dismissible(
                      key: GlobalKey(),
                      child: SavedTransactionItem(
                          wp: wp, hp: hp, isTablet: tablet),
                    ),
                    Dismissible(
                      key: GlobalKey(),
                      child: SavedTransactionItem(
                          wp: wp, hp: hp, isTablet: tablet),
                    ),
                    Dismissible(
                      key: GlobalKey(),
                      child: SavedTransactionItem(
                          wp: wp, hp: hp, isTablet: tablet),
                    ),
                    Dismissible(
                      key: GlobalKey(),
                      child: SavedTransactionItem(
                          wp: wp, hp: hp, isTablet: tablet),
                    ),
                    Dismissible(
                      key: GlobalKey(),
                      child: SavedTransactionItem(
                          wp: wp, hp: hp, isTablet: tablet),
                    ),
                    Dismissible(
                      key: GlobalKey(),
                      child: SavedTransactionItem(
                          wp: wp, hp: hp, isTablet: tablet),
                    ),
                    Dismissible(
                      key: GlobalKey(),
                      child: SavedTransactionItem(
                          wp: wp, hp: hp, isTablet: tablet),
                    ),
                    Dismissible(
                      key: GlobalKey(),
                      child: SavedTransactionItem(
                          wp: wp, hp: hp, isTablet: tablet),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: hp(6.5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFF5d6770),
              boxShadow: [
                new BoxShadow(
                  color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.6),
                  offset: new Offset(0, 3),
                  blurRadius: 3,
                )
              ],
            ),
            child: Text(
              eptxt('saved_transactions').toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: tablet ? hp(2.5) : wp(3.8),
                letterSpacing: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SavedTransactionItem extends StatelessWidget {
  const SavedTransactionItem({
    Key key,
    @required this.wp,
    @required this.hp,
    this.isTablet = false,
  }) : super(key: key);

  final Function wp;
  final Function hp;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isTablet) {
          openDetailsDialog(context);
        }
      },
      child: EpaisaCard(
        margin: EdgeInsets.only(bottom: hp(1.2)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: hp(2), vertical: hp(3)),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: isTablet ? 15 : 15,
                child: Container(
                  // margin: EdgeInsets.all(hp(4)),
                  width: hp(2.5),
                  // child: EpaisaCart(
                  //   hp: hp,
                  //   size: hp(2.5),
                  // ),
                  child: CartNumber(
                    number: 4,
                    color: AppColors.PrimaryBlue,
                    size: isTablet ? hp(4.3) : hp(4),
                  ),
                ),
              ),
              Expanded(
                flex: isTablet ? 85 : 60,
                child: Container(
                  margin: EdgeInsets.only(left: hp(1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: hp(1)),
                        child: Text(
                          'Abhishek Maurya',
                          style: TextStyle(
                            fontSize: hp(2.2),
                            color: AppColors.BackPrimaryGray,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '12 MAY 2018 10:21 AM',
                          style: TextStyle(
                            fontSize: hp(1.7),
                            color: AppColors.LightGray,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 25,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '₹ 2121.89',
                    style: TextStyle(
                      fontSize: isTablet ? hp(2.5) : wp(3.9),
                      color: AppColors.BackPrimaryGray,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openDetailsDialog(BuildContext context) {
    Navigator.of(context).push(
      new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          final List<OrderItem> orderItems = [
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
          return DialogCommon(
            width: MediaQuery.of(context).size.width * 0.96,
            title: 'Customer Cart',
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: hp(2), vertical: hp(1)),
              child: Column(
                children: <Widget>[
                  TransactionDetails(
                    items: orderItems,
                    expandHeight: getExpandHeight(
                      hp,
                      orderItems,
                      '12.50',
                      Discount(
                        calculated: '12.50',
                        value: '10',
                        type: '%',
                      ),
                    ),
                    height: hp(20),
                    showMoreEnabled: false,
                    isExpanded: true,
                    subTotal: '548.50',
                    discount: Discount(
                      calculated: '12.50',
                      value: '10',
                      type: '%',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: hp(2)),
                    child: EpaisaButton.medium(
                      borderRadius: BorderRadius.circular(hp(2)),
                      title: 'ADD MORE ITEMS',
                      onPress: () {},
                    ),
                  ),
                  Text(
                    'OR',
                    style: TextStyle(
                      fontSize: hp(3),
                      fontWeight: FontWeight.bold,
                      color: AppColors.BackPrimaryGray,
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.symmetric(vertical: hp(2)),
                    child: Buttons(
                      buttonSize: hp(8.5),
                      fontSize: hp(2),
                      gap: hp(2),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

double getExpandHeight(
  Function hp,
  List<OrderItem> orderItems,
  String subTotal,
  Discount discount,
) {
  var header = hp(3.6) + 0.6;
  var subTotalHeight = (subTotal != null) ? hp(3.4) : 0;
  var discountHeight = (discount != null) ? hp(3.3) : 0;

  final double totalItems = orderItems.map((i) {
    return i.discount != null ? (hp(3.6) + hp(2.2)) : hp(3.6);
  }).reduce((value, element) => value + element);

  return header + totalItems + subTotalHeight + discountHeight;
}
