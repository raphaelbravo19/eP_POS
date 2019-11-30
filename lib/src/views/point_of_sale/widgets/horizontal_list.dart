import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/item_category_tab.dart';
import 'package:flutter/material.dart';

class HorizontalLists extends StatefulWidget {
  const HorizontalLists({
    Key key,
    @required this.lw,
    @required this.selected,
  }) : super(key: key);

  final List<Map<String, dynamic>> lw;
  final int selected;
  @override
  _HorizontalListsState createState() => _HorizontalListsState();
}

class _HorizontalListsState extends State<HorizontalLists> {
  int selected = -1;
  ScrollController _ctlh = new ScrollController();
  double dist = 0;
  @override
  void initState() {
    //MediaQuery.of(context).size;
    selected = widget.selected;
    Future.delayed(Duration(milliseconds: 50), () {
      try {
        _ctlh.jumpTo(dist);
      } catch (e) {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    dist = wp(22) * selected;
    var tablet = isTablet(MediaQuery.of(context));
    return Container(
        height: tablet ? hp(13.5) : hp(11),
        margin: EdgeInsets.only(bottom: hp(0.5)),
        child: ListView.builder(
            controller: _ctlh,
            scrollDirection: Axis.horizontal,
            itemCount: widget.lw.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                    left: index == 0 ? wp(0.5) : 0,
                    right: tablet ? hp(0.5) : wp(1.5)),
                child: ItemCategoryTab(
                    onTap: () {
                      var temp = selected;
                      setState(() {
                        selected = index;
                      });
                      try {
                        if (temp < widget.lw.length - 4) {
                          _ctlh.jumpTo(wp(22) * selected);
                        } else if (index < widget.lw.length - 4) {
                          _ctlh.jumpTo(wp(22) * selected);
                        }
                      } catch (e) {}
                    },
                    selected: index == selected,
                    color: baseColors[index % 10],
                    scale: tablet ? wp(1.3) : hp(1.8),
                    tablet: tablet),
              );
            }));
  }
}
