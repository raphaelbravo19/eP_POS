import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/views/shopping_cart/shopping_cart_screen.dart';
import 'package:epaisa_pos/src/views/transactions/transactions_screen.dart';
import 'package:flutter/material.dart';

class ScreenWithSide extends StatelessWidget {
  final Widget body;
  final Widget side;
  final double sidePercent;
  final Widget subWidget;
  final bool showSubWidget;
  ScreenWithSide(
      {this.body,
      this.side,
      this.sidePercent = 38,
      this.subWidget,
      this.showSubWidget = false});
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Container(
          child: Row(
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Container(
                width: wp(sidePercent),
              ),
              showSubWidget
                  ? Expanded(
                      flex: showSubWidget ? 30 : 0,
                      child: Container(
                          width: wp(30),
                          decoration: BoxDecoration(
                            color: AppColors.DarkWhite,
                            boxShadow: [
                              new BoxShadow(
                                  color: AppColors.DarkGray.withOpacity(0.4),
                                  offset: new Offset(5, 0),
                                  blurRadius: 2.0),
                            ],
                          ),
                          child: subWidget),
                    )
                  : SizedBox(),
              Expanded(
                flex: showSubWidget ? 40 : 70,
                child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.PrimaryWhite,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/loginscreen/white_background.png'),
                      ),
                    ),
                    child:body),
              ),
            ],
          ),
        ),
        Container(
            width: wp(sidePercent),
            decoration: BoxDecoration(
              color: tablet ?  AppColors.PrimaryWhite : AppColors.DarkWhite,
              boxShadow: [
                new BoxShadow(
                    color: AppColors.DarkGray.withOpacity(0.4),
                    offset: new Offset(5, 0),
                    blurRadius: 2.0),
              ],
            ),
            child: side),
      ],
    );
  }
}
