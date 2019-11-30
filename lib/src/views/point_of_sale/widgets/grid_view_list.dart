import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/item_product.dart';
import 'package:epaisa_pos/src/views/promotions/widgets/item_category_tab.dart';
import 'package:flutter/material.dart';

class GridViewList extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final List<Map<String, dynamic>> topItems;
  final int itemCount;
  int selected;
  final int indexState;
  final int selectedView;
  final int gridLength;
  final bool noLetters;
  final double height;
  final double verticalMargin;
  final double totalWidth;
  final Function onTapFirst;
  final Function onTapSecond;
  final Function itemBuilder;
  final Function onTapTab;
  GridViewList({
    Key key,
    this.items,
    this.topItems,
    this.itemCount,
    this.selected = 0,
    this.indexState = 0,
    this.selectedView = 0,
    this.onTapFirst,
    this.onTapSecond,
    this.verticalMargin = 5,
    this.gridLength = 3,
    this.height = 100,
    this.totalWidth,
    this.noLetters = false,
    this.onTapTab,
    @required this.itemBuilder,
  }) : super(key: key);

  _GridViewListState createState() => _GridViewListState();
}

class _GridViewListState extends State<GridViewList> {
  var _ctl = new ScrollController();
  var _ctlh = new ScrollController();
  GlobalKey _keyList = GlobalKey();
  var counts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils.of(context).wp;
    final Function hp = ScreenUtils.of(context).hp;
    final bool tablet = ScreenUtils.of(context).isTablet;
    var abc = [
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
      "Z",
      "#"
    ];

    void scrollToRow(int index) {
      final RenderBox renderBoxRed = _keyList.currentContext.findRenderObject();

      final sizeRed = renderBoxRed.size;
      var totalHeight =
          ((1 + widget.items.length) / widget.gridLength).toInt() *
                  (widget.height + widget.verticalMargin) -
              sizeRed.height;
      var pivot = -1;
      for (var i = 0; i < widget.items.length; i++) {
        String w = widget.items[i]["searchKey"][0].toString().toLowerCase();
        bool isSame = w == abc[index].toLowerCase();
        print("$w - ${abc[index]}");
        if (isSame) {
          pivot = (i / widget.gridLength).toInt();
          break;
        }
      }
      if (pivot != -1) {
        var position =
            (pivot.toDouble()) * (widget.height + widget.verticalMargin);
        if (position > totalHeight) {
          _ctl.jumpTo(totalHeight);
        } else {
          _ctl.jumpTo(position);
        }
      }
    }

    List<Widget> _buildAbc() {
      List<Widget> content = List<Widget>();
      for (var i = 0; i < abc.length; i++) {
        var x = abc[i];
        content.add(GestureDetector(
            onTap: () {
              scrollToRow(i);
            },
            child: Text(
              x,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: tablet ? wp(1.3) : hp(1.6),
                  fontWeight: FontWeight.w600),
            )));
      }
      return content;
    }

    return Expanded(
        child: Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(
              left: wp(1),
              right: widget.noLetters ? wp(1) : tablet ? wp(3) : wp(6)),
          child: Column(
            children: <Widget>[
              if (widget.indexState == 1)
                Container(
                    height: tablet ? hp(11) : hp(11),
                    margin: EdgeInsets.only(bottom: widget.verticalMargin),
                    child: ListView.builder(
                        controller: _ctlh,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.topItems != null
                            ? widget.topItems.length
                            : 0,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: index == 0 ? wp(.5) : 0,
                                right: tablet ? wp(0.5) : wp(1.5)),
                            child: ItemCategoryTab(
                                text: widget.topItems != null
                                    ? widget.topItems[index]["text"]
                                    : null,
                                onTap: () {
                                  var temp = widget.selected;
                                  setState(() {
                                    widget.selected = index;
                                  });
                                  try {
                                    if (temp <
                                        widget.items.length -
                                            (tablet ? 7 : 4)) {
                                      _ctlh.jumpTo(wp(tablet ? 8.5 : 22) *
                                          widget.selected);
                                    } else if (index <
                                        widget.items.length -
                                            (tablet ? 7 : 4)) {
                                      _ctlh.jumpTo(wp(tablet ? 8.5 : 22) *
                                          widget.selected);
                                    }
                                  } catch (e) {}
                                  if (widget.onTapTab != null)
                                    widget.onTapTab(index);
                                },
                                selected: index == widget.selected,
                                color: baseColors[index % 10],
                                scale: tablet ? wp(1.2) : hp(1.8),
                                tablet: tablet),
                          );
                        })),
              Expanded(
                  key: _keyList,
                  child: ScrollConfiguration(
                    behavior: RemoveOverScrollGlow(),
                    child: widget.selectedView == 1
                        ? ListView.builder(
                            padding: EdgeInsets.only(right: 3),
                            itemCount: counts.length,
                            itemBuilder: (context, index) {
                              return ItemProduct(
                                onTap: () {
                                  setState(() {
                                    counts[index] = 1;
                                  });
                                },
                                counter: counts[index],
                                onAdd: () {
                                  setState(() {
                                    counts[index] = counts[index] + 1;
                                  });
                                },
                                onSub: () {
                                  if (counts[index] <= -1) return;

                                  setState(() {
                                    counts[index] = counts[index] - 1;
                                  });
                                },
                                name: "PARLE MARIE GOLD",
                                stock: 44,
                                price: 120.00,
                              );
                            },
                          )
                        : SingleChildScrollView(
                            controller: _ctl,
                            child: Column(
                                children: List.generate(
                              (((widget.gridLength - 1) + widget.items.length) /
                                      widget.gridLength)
                                  .toInt(),
                              (index) {
                                List<Widget> rowList = new List<Widget>();
                                int cant = (1 +
                                        (widget.items.length /
                                            widget.gridLength))
                                    .toInt();
                                bool last = cant - 1 == index;
                                bool noFill = ((last
                                            ? widget.items.length
                                            : (index * widget.gridLength) +
                                                widget.gridLength) -
                                        index * widget.gridLength) <
                                    widget.gridLength;
                                for (var i = index * widget.gridLength;
                                    i <
                                        (last
                                            ? widget.items.length
                                            : (index * widget.gridLength) +
                                                widget.gridLength);
                                    i++) {
                                  rowList.add(
                                    Container(
                                      width: (widget.totalWidth != null
                                              ? widget.totalWidth
                                              : (tablet ? wp(59) : wp(90.5))) /
                                          widget.gridLength,
                                      margin: EdgeInsets.only(
                                          right: noFill
                                              ? wp(1.5) /
                                                  (widget.gridLength - 1)
                                              : 0),
                                      child: widget.itemBuilder(
                                        item: widget.items[i],
                                        onTap: () => widget.onTapFirst(i),
                                        index: i,
                                      ),
                                    ),
                                  );
                                }
                                return Container(
                                  padding: EdgeInsets.only(right: wp(0.5)),
                                  margin: EdgeInsets.only(
                                      bottom: widget.verticalMargin),
                                  height: widget.height,
                                  child: Row(
                                    mainAxisAlignment: last
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.spaceBetween,
                                    children: rowList,
                                  ),
                                );
                              },
                            )),
                          ),
                  ))
            ],
          ),
        ),
        widget.noLetters
            ? Container()
            : Container(
                width: tablet ? wp(4) : wp(6),
                //padding: EdgeInsets.symmetric(vertical: tablet ? hp(1.5) : 0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _buildAbc(),
                ))
      ],
    ));
  }
}
