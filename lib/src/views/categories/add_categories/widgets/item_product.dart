import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatefulWidget {
  final double scale;
  final bool tablet;
  final bool edit;
  ItemProduct({this.scale = 0, this.tablet = false, this.edit = false});

  @override
  _ItemProductState createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  var quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.scale * 0.3),
        color: AppColors.PrimaryWhite,
        boxShadow: [
          new BoxShadow(
              color: AppColors.DarkGray.withOpacity(widget.tablet ? 0.6 : 0.8),
              offset: new Offset(0.6, 1.0),
              blurRadius: 1.0)
        ],
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: widget.scale),
                  child: Container(
                    child: Image.asset(
                      'assets/manufacturerscreen/cocacola.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                widget.edit
                    ? Container(
                        color: AppColors.Black.withOpacity(0.6),
                        padding: EdgeInsets.symmetric(
                            horizontal: widget.scale * 0.2),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/general_icons/minus.png",
                              height: widget.scale * 3.2,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: widget.scale * 2),
                                child: FittedBox(
                                  child: Text(
                                    quantity.toString(),
                                    style: TextStyle(
                                        color: AppColors.PrimaryWhite,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            Image.asset(
                              "assets/general_icons/plus.png",
                              height: widget.scale * 3.2,
                            )
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
                padding: EdgeInsets.all(widget.scale * 0.4),
                alignment: Alignment.topLeft,
                child: Text("PARLE MARIE GOLD",
                    style: TextStyle(
                        fontSize: widget.scale * 0.9,
                        fontWeight:
                            widget.tablet ? FontWeight.w600 : FontWeight.w700,
                        color: AppColors.DisabledText))),
          ),
        ],
      ),
    );
  }
}
