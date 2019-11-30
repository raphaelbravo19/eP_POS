import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/item_category.dart';
import 'package:flutter/material.dart';

class GridList extends StatefulWidget {
  List<Map<String, dynamic>> children;
  int gridLength;
  double height;
  double totalWidth;
  double marginH;
  Function onTapGeneral;
  GridList(
      {this.children,
      this.gridLength,
      this.height,
      this.totalWidth,
      this.marginH,
      this.onTapGeneral});
  @override
  _GridListState createState() => _GridListState();
}

class _GridListState extends State<GridList> {
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    return Expanded(
        child: ScrollConfiguration(
            behavior: RemoveOverScrollGlow(),
            child: ListView.builder(
              itemCount:
                  ((1 + widget.children.length) / widget.gridLength).toInt(),
              itemBuilder: (context, index) {
                List<Widget> rowList = new List<Widget>();
                int cant =
                    (1 + (widget.children.length / widget.gridLength)).toInt();
                bool last = cant - 1 == index;
                bool noFill = ((last
                            ? widget.children.length
                            : (index * widget.gridLength) + widget.gridLength) -
                        index * widget.gridLength) <
                    3;
                for (var i = index * widget.gridLength;
                    i <
                        (last
                            ? widget.children.length
                            : (index * widget.gridLength) + widget.gridLength);
                    i++) {
                  rowList.add(
                    Container(
                        width: (widget.totalWidth - widget.marginH) /
                            widget.gridLength,
                        margin: EdgeInsets.only(
                            right:
                                noFill ? wp(2.5) / (widget.gridLength - 1) : 0),
                        child: ItemCategory(
                          onTap: () => widget.onTapGeneral(i),
                          text: widget.children[i]["text"],
                          color: widget.children[i]["color"],
                          scale: tablet ? wp(1.3) : hp(1.9),
                          tablet: tablet,
                        )),
                  );
                }
                return Container(
                  margin: EdgeInsets.only(bottom: hp(0.5)),
                  height: widget.height,
                  child: Row(
                    mainAxisAlignment: last
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.spaceBetween,
                    children: rowList,
                  ),
                );
              },
            )));
  }
}
