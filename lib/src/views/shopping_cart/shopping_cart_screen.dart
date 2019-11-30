import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/button_blurred_dialog.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_common.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatefulWidget {
  ShoppingCartScreen({
    this.transactionsFooter = false,
    @required this.content,
  });
  final bool transactionsFooter;
  final Widget content;

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  GlobalKey _keyButton = new GlobalKey();
  var transactionDetailsPartial;
  @override
  void initState() {
    transactionDetailsPartial = 'info';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    void _showCartDialogs(title, content) {
      // flutter defined function
      Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return DialogCommon(
            title: title,
            width: tablet ? hp(50) : wp(75),
            child: Container(
              padding: EdgeInsets.only(
                bottom: hp(tablet ? 4 : 2),
                left: hp(4),
                right: hp(4),
                top: hp(3),
              ),
              child: content,
            ),
          );
        },
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 150),
      ));
    }

    void _showCouponsDialog() {
      _showCartDialogs(
        eptxt('coupon_code'),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: hp(2)),
              child: TextfieldClassic(
                // paddingLeft: hp(6),
                fontSize: tablet ? hp(3.6) : hp(2.5),
                // labelText: 'Discount',
                paddingBottomInput: hp(1),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: hp(2),
              ),
              child: tablet
                  ? EpaisaButton.big(
                      onPress: () {},
                      title: multilang.get('apply').toUpperCase(),
                    )
                  : EpaisaButton.medium(
                      onPress: () {},
                      title: multilang.get('apply').toUpperCase(),
                    ),
            )
          ],
        ),
      );
    }

    void _showDiscountsDialog() {
      // flutter defined function

      _showCartDialogs(
        eptxt('discount'),
        DiscountDialog(),
      );
    }

    void _showDeliveryDialog() {
      _showCartDialogs(
        eptxt('delivery_charge'),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: hp(2)),
              child: Stack(
                children: [
                  Positioned(
                    top: hp(1.6),
                    left: hp(2),
                    child: Text(
                      '₹',
                      style: TextStyle(
                        fontSize: tablet ? hp(3.6) : hp(2.5),
                        fontWeight: FontWeight.bold,
                        color: AppColors.PrimaryBlue,
                      ),
                    ),
                  ),
                  TextfieldClassic(
                    paddingLeft: hp(6),
                    fontSize: tablet ? hp(3.6) : hp(2.5),
                    // labelText: 'Discount',
                    paddingBottomInput: hp(1),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: hp(2)),
              child: tablet
                  ? EpaisaButton.big(
                      onPress: () {},
                      title: eptxt('add').toUpperCase(),
                    )
                  : EpaisaButton.medium(
                      onPress: () {},
                      title: eptxt('add').toUpperCase(),
                    ),
            )
          ],
        ),
      );
    }

    Widget _customerBox() {
      return Expanded(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: hp(3)),
                decoration: BoxDecoration(
                  color: AppColors.TextGray,
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(hp(1.5)),
                  boxShadow: [
                    new BoxShadow(
                        color: AppColors.Black.withOpacity(0.6),
                        offset: new Offset(2, 2),
                        blurRadius: 7.0),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: tablet ? wp(0.7) : wp(2), vertical: hp(1)),
                alignment: Alignment.centerLeft,
                width: tablet ? wp(15.3) : wp(40),
                //color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: tablet ? wp(14) : wp(33),
                      child: FittedBox(
                        child: Text(
                          "Abhishek Maurya",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.PrimaryWhite,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: hp(0.3),
                    ),
                    Container(
                      width: tablet ? wp(8) : wp(18),
                      child: FittedBox(
                        child: Text(
                          "174 265 44",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.PrimaryWhite,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      );
    }

    void _showButtons() {
      // flutter defined function
      final RenderBox renderBoxRed =
          _keyButton.currentContext.findRenderObject();
      final positionRed = renderBoxRed.localToGlobal(Offset.zero);
      final sizeRed = renderBoxRed.size;

      Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return ButtonBlurredDialog(
            x: positionRed.dx,
            y: positionRed.dy,
            showDelivery: _showDeliveryDialog,
            showDiscount: _showDiscountsDialog,
            showCoupon: _showCouponsDialog,
          );
        },
      ));
    }

    Widget _pointsBox() {
      return Expanded(
        child: Container(
          padding: EdgeInsets.only(right: tablet ? wp(1.5) : wp(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: hp(3),
              ),
              Text("400 ${eptxt('points')}",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.PrimaryWhite,
                    fontSize: hp(2.8),
                  )),
              SizedBox(
                height: tablet ? hp(2) : hp(1),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        print("isPressed");
                      },
                      child: Container(
                        height: hp(5.0),
                        width: hp(5.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/shopping/clear.png")),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: tablet ? wp(1) : wp(2),
                    ),
                    GestureDetector(
                        onTap: () {
                          _showButtons();
                        },
                        child: Container(
                          key: _keyButton,
                          height: hp(5.0),
                          width: hp(5.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/shopping/dots.png")),
                            shape: BoxShape.circle,
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: tablet ? hp(2) : hp(1),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.TextGray,
      body: Stack(
        children: <Widget>[
          Column(children: [
            Expanded(
                child: Container(
              color: AppColors.TextGray,
            )),
            Expanded(
              child: Container(color: AppColors.PrimaryWhite),
            )
          ]),
          SafeArea(
            //bottom: false,
            child: Container(
              color: AppColors.PrimaryWhite,
              child: Column(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.TextGray,
                    boxShadow: [
                      new BoxShadow(
                          color: AppColors.Black.withOpacity(0.6),
                          offset: new Offset(0, 3),
                          blurRadius: 3.0),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[_customerBox(), _pointsBox()],
                  ),
                ),
                Container(child: widget.content),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class DiscountDialog extends StatefulWidget {
  const DiscountDialog({
    Key key,
  }) : super(key: key);

  @override
  _DiscountDialogState createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  final options = [
    {"name": '%', "value": '%'},
    {"name": '₹', "value": '₹'}
  ];
  bool allBlue = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: hp(2)),
          child: Row(
            children: [
              Container(
                width: tablet ? hp(12.5) : wp(17),
                child: TextfieldDropdown(
                  items: options,
                  paddingBottomInput: hp(1),
                  paddingLeft: tablet ? hp(3) : wp(5),
                  fontSize: tablet ? hp(3.6) : hp(2.5),
                  iconBottom: -hp(0.2),
                  showBlueDropdownColor: true,
                  onFocusChange: (val) {
                    setState(() {
                      allBlue = val;
                    });
                  },
                  scaleDropdown: 2,
                  alwaysBlue: true,
                  itemBuilder: ({option, index, height, selected}) {
                    return Container(
                      alignment: Alignment.center,
                      color: selected
                          ? Colors.black.withOpacity(0.05)
                          : Colors.white,
                      height: height,
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: hp(2.6),
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? AppColors.PrimaryBlue
                              : AppColors.BackPrimaryGray,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 70,
                child: TextfieldClassic(
                  keyType: TextInputType.number,
                  onFocusChange: (val) {
                    setState(() {
                      allBlue = val;
                    });
                  },
                  alwaysBlue: true,
                  alwaysFocus: true,
                  leftBorder: true,
                  paddingLeft: hp(2),
                  paddingBottomInput: hp(1),
                  fontSize: tablet ? hp(3.6) : hp(2.5),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: hp(1),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: hp(2)),
          child: tablet
              ? EpaisaButton.big(
                  onPress: () {},
                  title: eptxt('add').toUpperCase(),
                )
              : EpaisaButton.medium(
                  onPress: () {},
                  title: eptxt('add').toUpperCase(),
                ),
        )
      ],
    );
  }
}
