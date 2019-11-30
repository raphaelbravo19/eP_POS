import 'dart:convert';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class RowIndustry extends StatefulWidget {
  RowIndustry(
      {Key key,
      @required this.industry,
      this.children,
      this.select,
      this.closeModal,
      this.closePrevious,
      this.indexSelected,
      this.index})
      : super(key: key);

  final Map<String, dynamic> industry;
  final Map<String, dynamic> children;
  final Function select;
  final Function closeModal;
  final Function closePrevious;
  final BehaviorSubject<String> indexSelected;
  final int index;
  @override
  RowIndustryState createState() => RowIndustryState();
}

class RowIndustryState extends State<RowIndustry> {
  bool open = false;
  GlobalKey rowSize = new GlobalKey();
  double height = 0;

  @override
  void initState() {
    if (height == 0)
      Future.delayed(Duration(milliseconds: 100), () {
        print("hola");
        RenderBox renderBoxRed = rowSize.currentContext.findRenderObject();
        var sizeRed = renderBoxRed.size;
        height = sizeRed.height;
      });

    super.initState();
  }

  void closeInfo(val) {
    setState(() {
      open = val;
    });
  }

  Widget build(BuildContext context) {
    var tablet = isTablet(MediaQuery.of(context));
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (open) {
                setState(() {
                  open = false;
                });
              } else {
                setState(() {
                  open = true;
                });
              }
              widget.closePrevious(widget.index);
            },
            child: Container(
              key: rowSize,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.BorderGray, width: 1.0),
                ),
              ),
              padding: EdgeInsets.only(
                  left: hp(2.2), right: hp(2.5), bottom: hp(1), top: hp(1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        widget.industry["name"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.DarkGray,
                          fontSize: (tablet ? wp(1.5) : hp(1.9)),
                          fontWeight:
                              tablet ? FontWeight.w700 : FontWeight.w700,
                        ),
                      ),
                    ),
                  )),
                  Container(
                    padding: EdgeInsets.only(left: hp(1)),
                    child: !open
                        ? Image.asset(
                            "assets/general_icons/arrowright.png",
                            height: tablet ? hp(2.6) : wp(3.8),
                          )
                        : Image.asset(
                            "assets/payments/arrowdw.png",
                            height: tablet ? hp(1.5) : wp(2.2),
                            color: Color(0x8A000000),
                          ),
                  ),
                ],
              ),
            ),
          ),
          open
              ? IndustryType(
                  select: widget.select,
                  list: widget.industry["children"],
                  closeinfo: () {
                    widget.closeModal();
                  },
                  indexSelected: widget.indexSelected,
                  height: height,
                )
              : Container(),
        ],
      ),
    );
  }
}

class IndustryType extends StatefulWidget {
  IndustryType(
      {Key key,
      this.closeinfo,
      this.list,
      this.select,
      this.height = 0,
      this.indexSelected})
      : super(key: key);
  final Function closeinfo;
  final List<Map> list;
  final Function select;
  final double height;
  final BehaviorSubject<String> indexSelected;
  @override
  _IndustryTypeState createState() => _IndustryTypeState();
}

class _IndustryTypeState extends State<IndustryType> {
  bool gstValue = false;
  bool vatValue = false;
  GlobalKey<ButtonToggleState> gstController =
      new GlobalKey<ButtonToggleState>();
  GlobalKey<ButtonToggleState> vatController =
      new GlobalKey<ButtonToggleState>();
  @override
  Widget build(BuildContext context) {
    var tablet = isTablet(MediaQuery.of(context));

    return Container(
      color: AppColors.Gray,
      height: widget.list.length < 4
          ? widget.height * widget.list.length
          : widget.height * 4,
      child: ScrollConfiguration(
        behavior: RemoveOverScrollGlow(),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              widget.list.length,
              (index) {
                return Container(
                  height: widget.height,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(color: AppColors.BorderGray, width: 1.0),
                    ),
                  ),
                  padding: EdgeInsets.only(
                      left: wp(1), right: wp(0), bottom: hp(1), top: hp(1)),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            widget.select(widget.list[index]);
                            widget.closeinfo();
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              left: tablet ? wp(1.7) : wp(5.9),
                              right: tablet ? wp(1.4) : wp(4.8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: FittedBox(
                                    child: Text(
                                      widget.list[index]["name"],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.DarkGray,
                                        fontSize: (tablet ? wp(1.5) : hp(1.9)),
                                        fontWeight: tablet
                                            ? FontWeight.w700
                                            : FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                StreamBuilder<String>(
                                    stream: widget.indexSelected,
                                    builder: (context, snapshot) {
                                      var str = "";
                                      if (snapshot.data != null) {
                                        str = json.decode(snapshot.data)["id"];
                                        if (str == widget.list[index]["id"]) {
                                          return Container(
                                            child: Image.asset(
                                              'assets/createaccount/Tick.png',
                                              height:
                                                  tablet ? hp(3.3) : wp(3.4),
                                              color: AppColors.PrimaryBlue,
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      } else {
                                        return Container();
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class RowType extends StatefulWidget {
  RowType(
      {Key key,
      @required this.industry,
      this.children,
      this.select,
      this.closeModal,
      this.closePrevious,
      this.indexSelected,
      this.index})
      : super(key: key);

  final Map<String, dynamic> industry;
  final Map<String, dynamic> children;
  final Function select;
  final Function closeModal;
  final Function closePrevious;
  final BehaviorSubject<String> indexSelected;
  final int index;
  @override
  RowTypeState createState() => RowTypeState();
}

class RowTypeState extends State<RowType> {
  bool open = false;
  GlobalKey rowSize = new GlobalKey();
  double height = 0;

  @override
  void initState() {
    if (height == 0)
      Future.delayed(Duration(milliseconds: 100), () {
        print("hola");
        RenderBox renderBoxRed = rowSize.currentContext.findRenderObject();
        var sizeRed = renderBoxRed.size;
        height = sizeRed.height;
      });

    super.initState();
  }

  void closeInfo(val) {
    setState(() {
      open = val;
    });
  }

  Widget build(BuildContext context) {
    var tablet = isTablet(MediaQuery.of(context));
    return Container(
      color: AppColors.Gray,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("SELETED ${widget.industry}");
              widget.select(widget.industry);
              widget.closeModal();
            },
            child: Container(
              key: rowSize,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.BorderGray, width: 1.0),
                ),
              ),
              padding: EdgeInsets.only(
                  left: hp(2.2), right: hp(2.5), bottom: hp(1), top: hp(1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        widget.industry["name"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.DarkGray,
                          fontSize: (tablet ? wp(1.5) : hp(1.9)),
                          fontWeight:
                              tablet ? FontWeight.w700 : FontWeight.w700,
                        ),
                      ),
                    ),
                  )),
                  StreamBuilder(
                      stream: widget.indexSelected,
                      builder: (context, snapshot) {
                        return Container(
                            padding: EdgeInsets.only(left: hp(1)),
                            child: snapshot.data != null
                                ? widget.industry["id"] !=
                                        json.decode(snapshot.data)["id"]
                                    ? Container()
                                    : Container(
                                        child: Image.asset(
                                          'assets/createaccount/Tick.png',
                                          height: tablet ? hp(3.3) : wp(3.4),
                                          color: AppColors.PrimaryBlue,
                                        ),
                                      )
                                : Container());
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
