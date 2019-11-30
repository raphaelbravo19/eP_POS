import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';

class ItemManu extends StatelessWidget {
  final double scale;
  final bool tablet;
  ItemManu({this.scale = 0, this.tablet = false});
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    return Container(
      margin: EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(scale * 0.3),
        color: AppColors.PrimaryWhite,
        boxShadow: [
          new BoxShadow(
              color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.8),
              offset: new Offset(0.6, 1.0),
              blurRadius: 1.0)
        ],
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: scale),
              child: Container(
                child: Image.asset(
                  'assets/manufacturerscreen/cocacola.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
              child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(
                      scale * 0.4, scale * 0.4, scale * 2, scale * 0.4),
                  alignment: Alignment.topLeft,
                  child: Text("LOTTE INTERNATIONAL",
                      style: TextStyle(
                          fontSize: scale * 0.9,
                          fontWeight:
                              tablet ? FontWeight.w600 : FontWeight.w700,
                          color: AppColors.DisabledText))),
              Positioned(
                right: scale * 0.3,
                bottom: scale * 0.3,
                child: Container(
                  alignment: Alignment.center,
                  height: scale * 1.8,
                  width: scale * 1.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(scale * 0.3),
                      border:
                          Border.all(color: AppColors.LightGray, width: 0.9)),
                  child: Text(
                    '12',
                    style: TextStyle(
                        fontSize: tablet ? scale * 0.9 : scale * 0.85,
                        fontWeight: tablet ? FontWeight.w600 : FontWeight.w700,
                        color: AppColors.DisabledText),
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
