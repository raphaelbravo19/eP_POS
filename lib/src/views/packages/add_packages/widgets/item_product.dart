import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ItemProduct extends StatefulWidget {
  final double scale;
  final bool tablet;
  final String text;
  final int quantity;
  final Function more;
  final Function less;
  ItemProduct(
      {this.scale = 0,
      this.tablet = false,
      this.text = "Product",
      this.quantity,
      this.more,
      this.less});

  @override
  _ItemProductState createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  BehaviorSubject<int> quantity;
  @override
  void initState() {
    quantity = new BehaviorSubject<int>.seeded(widget.quantity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.scale * 0.4),
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: widget.scale * 0.2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(widget.scale * 0.4),
                        topRight: Radius.circular(widget.scale * 0.4)),
                    color: AppColors.Black.withOpacity(0.6),
                  ),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if (quantity.value > 0) {
                            quantity.sink.add(quantity.value - 1);
                            widget.less(quantity.value);
                          }
                        },
                        child: Image.asset(
                          "assets/general_icons/minus.png",
                          height: widget.scale * 3.2,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: widget.scale * 2),
                          child: FittedBox(
                            child: StreamBuilder<int>(
                                stream: quantity,
                                builder: (context, snapshot) {
                                  return Text(
                                    snapshot.data.toString(),
                                    style: TextStyle(
                                        color: AppColors.PrimaryWhite,
                                        fontWeight: FontWeight.w600),
                                  );
                                }),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            quantity.sink.add(quantity.value + 1);
                            widget.less(quantity.value);
                          },
                          child: Image.asset(
                            "assets/general_icons/plus.png",
                            height: widget.scale * 3.2,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
                padding: EdgeInsets.all(widget.scale * 0.4),
                alignment: Alignment.topLeft,
                child: Text(widget.text,
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
