import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';

class ItemProductRow extends StatelessWidget {
  final double scale;
  final int counter;
  final Function onAdd;
  final Function onSub;
  final Function onTap;
  final String name;
  final int stock;
  final double price;
  ItemProductRow({
    this.scale = 0,
    this.counter,
    this.onAdd,
    this.onSub,
    this.onTap,
    this.name,
    this.stock,
    this.price,
  });
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils.of(context).wp;
    final Function hp = ScreenUtils.of(context).hp;
    final bool tablet = ScreenUtils.of(context).isTablet;
    return GestureDetector(
      onTap: () {
        if (onTap != null && counter <= 0) {
          onTap();
        }
      },
      child: Container(
          margin: EdgeInsets.only(top: hp(1), left: wp(1)),
          padding: EdgeInsets.symmetric(vertical: hp(2)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(scale * 0.3),
            color: AppColors.PrimaryWhite,
            boxShadow: [
              new BoxShadow(
                color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.8),
                offset: new Offset(0.6, 1.0),
                blurRadius: 1.0,
              )
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: tablet ? hp(2) : wp(3)),
                width: tablet ? hp(12) : wp(20),
                child: Image.asset(
                  'assets/manufacturerscreen/cocacola.png',
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        name,
                        style: TextStyle(
                            color: AppColors.DarkGray,
                            fontWeight: FontWeight.w600,
                            fontSize: tablet ? hp(2.4) : wp(3.2),
                            letterSpacing: 0.2),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: hp(0.5)),
                      child: Text(
                        "${multilang.get('in_stock')}: $stock",
                        style: TextStyle(
                          color: AppColors.DisabledText,
                          fontWeight: FontWeight.w700,
                          fontSize: tablet ? hp(2) : wp(3),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (counter <= 0)
                Container(
                    padding: EdgeInsets.only(right: hp(1)),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "₹ ${price.toStringAsFixed(2)}", //list[index],
                            style: TextStyle(
                              color: AppColors.DarkGray,
                              fontWeight: FontWeight.w700,
                              fontSize: tablet ? hp(2.8) : wp(4.5),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    )),
              if (counter > 0)
                Container(
                  margin: EdgeInsets.only(right: hp(1)),
                  child: Row(
                    children: <Widget>[
                      CircleButton(hp: hp, icon: 'SUB', onTap: onSub),
                      Container(
                        width: tablet ? hp(7) : wp(11),
                        alignment: Alignment.center,
                        child: Text(
                          counter.toString(),
                          style: TextStyle(
                            color: Color(0xFF417505),
                            fontWeight: FontWeight.bold,
                            fontSize: tablet ? hp(3) : hp(2.6),
                          ),
                        ),
                      ),
                      CircleButton(hp: hp, icon: 'ADD', onTap: onAdd)
                    ],
                  ),
                )
            ],
          )),
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key key,
    @required this.hp,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  final Function hp;
  final String icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils.of(context).wp;
    final Function hp = ScreenUtils.of(context).hp;
    final bool tablet = ScreenUtils.of(context).isTablet;
    final double size = tablet ? hp(4.5) : wp(7);
    final iconScale = 0.7;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.black, width: tablet ? 2 : 1.5),
                shape: BoxShape.circle,
              ),
            ),
            Positioned(
              top: size * ((1 - iconScale) / 2),
              left: size * ((1 - iconScale) / 2),
              child: Container(
                child: Icon(
                  icon == 'ADD' ? Icons.add : Icons.remove,
                  size: size * iconScale,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
