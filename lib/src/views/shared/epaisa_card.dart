import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class EpaisaCard extends StatelessWidget {
  final Widget child;
  final Widget header;
  final Widget footer;
  final Color color;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final bool border;
  const EpaisaCard({
    Key key,
    this.child,
    this.header,
    this.footer,
    this.margin,
    this.color,
    this.borderRadius,
    this.border = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tablet = isTablet(MediaQuery.of(context));

    return Container(
      alignment: Alignment.center,
      margin:
          margin != null ? margin : EdgeInsets.only(bottom: tablet ? 0 : 16),
      decoration: BoxDecoration(
        color: color != null ? color : Colors.white,
        borderRadius:
            borderRadius != null ? borderRadius : BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: border ? Colors.black26 : Colors.black45,
            offset: Offset.fromDirection(45),
            blurRadius: 1,
            spreadRadius: 0.5,
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          if (header != null)
            Container(
              decoration: BoxDecoration(
                // color: Colors.green,
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(235, 235, 235, 1),
                    width: 1.0,
                  ),
                ),
              ),
              child: header,
            ),
          Container(
            child: child,
          ),
          if (footer != null)
            Container(
              decoration: BoxDecoration(
                // color: Colors.green,
                border: Border(
                  top: BorderSide(
                    color: Color.fromRGBO(235, 235, 235, 1),
                    width: 1.0,
                  ),
                ),
              ),
              child: footer,
            ),
        ],
      ),
    );
  }
}
