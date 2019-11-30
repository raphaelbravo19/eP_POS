import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_common.dart';
import 'package:flutter/material.dart';

class ItemProductViewType {
  static const ItemProductViewGrid = 'GRID';
  static const ItemProductViewList = 'LIST';
}

class ItemProduct extends StatelessWidget {
  final int counter;
  final Function onAdd;
  final Function onSub;
  final Function onTap;
  final String name;
  final int stock;
  final double price;
  final String view;
  ItemProduct({
    @required this.counter,
    @required this.onAdd,
    @required this.onSub,
    @required this.onTap,
    @required this.name,
    @required this.stock,
    @required this.price,
    this.view = ItemProductViewType.ItemProductViewList,
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
      child: view == ItemProductViewType.ItemProductViewList
          ? ItemProductListItem(
              hp: hp,
              wp: wp,
              tablet: tablet,
              name: name,
              stock: stock,
              counter: counter,
              price: price,
              onSub: onSub,
              onAdd: onAdd,
            )
          : ItemProductGridItem(
              hp: hp,
              wp: wp,
              tablet: tablet,
              name: name,
              stock: stock,
              counter: counter,
              price: price,
              onSub: onSub,
              onAdd: onAdd,
            ),
    );
  }
}

class ItemProductListItem extends StatelessWidget {
  const ItemProductListItem({
    Key key,
    @required this.hp,
    @required this.wp,
    @required this.tablet,
    @required this.name,
    @required this.stock,
    @required this.counter,
    @required this.price,
    @required this.onSub,
    @required this.onAdd,
  }) : super(key: key);

  final Function hp;
  final Function wp;
  final bool tablet;
  final String name;
  final int stock;
  final int counter;
  final double price;
  final Function onSub;
  final Function onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: hp(1), left: wp(1)),
        padding: EdgeInsets.symmetric(vertical: hp(2)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(tablet ? hp(1) : wp(1.2)),
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
              padding: EdgeInsets.symmetric(horizontal: tablet ? hp(2) : wp(3)),
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
                          fontWeight:
                              tablet ? FontWeight.w500 : FontWeight.w600,
                          fontSize: tablet ? hp(2) : wp(2.8),
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
                            fontSize: tablet ? hp(2.4) : wp(4.5),
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
        ));
  }
}

class ItemProductGridItem extends StatelessWidget {
  const ItemProductGridItem({
    Key key,
    @required this.hp,
    @required this.wp,
    @required this.tablet,
    @required this.name,
    @required this.stock,
    @required this.counter,
    @required this.price,
    @required this.onSub,
    @required this.onAdd,
  }) : super(key: key);

  final Function hp;
  final Function wp;
  final bool tablet;
  final String name;
  final int stock;
  final int counter;
  final double price;
  final Function onSub;
  final Function onAdd;

  @override
  Widget build(BuildContext context) {
    DialogCommon dialog = DialogCommon(
      context: context,
    );
    print(counter);
    return Container(
      margin: EdgeInsets.only(top: hp(1), left: wp(1)),
      // padding: EdgeInsets.symmetric(vertical: hp(2)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(tablet ? hp(1) : wp(1.2)),
        color: AppColors.PrimaryWhite,
        boxShadow: [
          new BoxShadow(
            color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.8),
            offset: new Offset(0.6, 1.0),
            blurRadius: 1.0,
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 60,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: tablet ? hp(2) : wp(3)),
                    child: Image.asset(
                      'assets/manufacturerscreen/cocacola.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                if (counter > 0)
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            tablet ? hp(1) : wp(1.2),
                          ),
                          topRight: Radius.circular(
                            tablet ? hp(1) : wp(1.2),
                          ),
                        )),
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleButton(
                              hp: hp,
                              icon: 'SUB',
                              onTap: onSub,
                              color: Colors.white),
                          Container(
                            width: tablet ? hp(7) : wp(11),
                            alignment: Alignment.center,
                            child: Text(
                              counter.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: tablet ? hp(3) : hp(2.6),
                              ),
                            ),
                          ),
                          CircleButton(
                              hp: hp,
                              icon: 'ADD',
                              onTap: onAdd,
                              color: Colors.white)
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 40,
            child: GestureDetector(
              onTap: () {
                 
                  /* dialog.productItem(
                      image: Image.asset(
                        'assets/manufacturerscreen/cocacola.png',
                        fit: BoxFit.contain,
                      ),
                      title: "Cadbury Bourn Vita & Lays American combo",
                      promo: ["Cadbury Bourn Vita", "Lays American"]);
                 */
              },
              child: Container(
                padding: EdgeInsets.all(tablet ? hp(1) : wp(1)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      // alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              name,
                              style: TextStyle(
                                color: AppColors.DarkGray,
                                fontWeight: FontWeight.w600,
                                fontSize: tablet ? hp(1.7) : wp(2.8),
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        child: Text(
                          "₹ ${price.toStringAsFixed(2)}", //list[index],
                          style: TextStyle(
                            color: AppColors.DarkGray,
                            fontWeight: FontWeight.w700,
                            fontSize: tablet ? hp(1.8) : wp(2.8),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      width: tablet ? hp(3.5) : hp(2.8),
                      height: tablet ? hp(2.8) : hp(2.8),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(hp(0.5)),
                          border: Border.all(
                            color: AppColors.BackPrimaryGray,
                            width: 0.5,
                          ),
                        ),
                        child: FittedBox(
                          child: Text(
                            stock.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: tablet ? hp(1.6) : wp(2.8),
                              color: AppColors.BackPrimaryGray,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // if (counter > 0)
          //   Container(
          //     margin: EdgeInsets.only(right: hp(1)),
          //     child: Row(
          //       children: <Widget>[
          //         CircleButton(hp: hp, icon: 'SUB', onTap: onSub),
          //         Container(
          //           width: tablet ? hp(7) : wp(11),
          //           alignment: Alignment.center,
          //           child: Text(
          //             counter.toString(),
          //             style: TextStyle(
          //               color: Color(0xFF417505),
          //               fontWeight: FontWeight.bold,
          //               fontSize: tablet ? hp(3) : hp(2.6),
          //             ),
          //           ),
          //         ),
          //         CircleButton(hp: hp, icon: 'ADD', onTap: onAdd)
          //       ],
          //     ),
          //   )
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key key,
    @required this.hp,
    @required this.icon,
    @required this.onTap,
    this.color,
  }) : super(key: key);

  final Function hp;
  final String icon;
  final Function onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils.of(context).wp;
    final Function hp = ScreenUtils.of(context).hp;
    final bool tablet = ScreenUtils.of(context).isTablet;
    final double size = tablet ? hp(4) : wp(6.0);
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
                border: Border.all(
                  color: color != null ? color : Colors.black,
                  width: tablet ? 2.5 : 1.5,
                ),
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
                  color: color != null ? color : Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
