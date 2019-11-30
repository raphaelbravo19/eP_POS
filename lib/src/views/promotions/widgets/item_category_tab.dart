import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';

class ItemCategoryTab extends StatefulWidget {
  final double scale;
  final bool tablet;
  final Color color;
  final Function onTap;
  final String text;
  final bool selected;
  ItemCategoryTab(
      {this.scale = 0,
      this.tablet = false,
      this.color,
      this.onTap,
      this.text = "Fruits & Vegetables",
      this.selected});

  @override
  _ItemCategoryTabState createState() => _ItemCategoryTabState();
}

class _ItemCategoryTabState extends State<ItemCategoryTab> {
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    var tablet = isTablet(MediaQuery.of(context));

    return GestureDetector(
      onTap: widget.onTap != null ? widget.onTap : () {},
      child: Container(
          width: tablet ? wp(8) : wp(20.6),
          alignment: Alignment.center,
          //margin: EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            border: Border.all(
                color: widget.color != null ? widget.color : baseColors[0],
                width: 1.5),
            borderRadius: BorderRadius.circular(widget.scale * 0.3),
            color: widget.selected ? widget.color : AppColors.PrimaryWhite,
            boxShadow: [
              new BoxShadow(
                  color:
                      AppColors.DarkGray.withOpacity(widget.tablet ? 0.6 : 0.8),
                  offset: new Offset(0.6, 1.0),
                  blurRadius: 1.0)
            ],
          ),
          child: Text(widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize:
                      widget.tablet ? widget.scale * 0.9 : widget.scale * 0.9,
                  fontWeight: widget.tablet ? FontWeight.w800 : FontWeight.w700,
                  color: widget.selected
                      ? AppColors.PrimaryWhite
                      : AppColors.DisabledText))),
    );
  }
}
