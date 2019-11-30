import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:async';

class EpaisaAppBar extends StatefulWidget {
  const EpaisaAppBar(
      {this.title,
      this.leading,
      this.trailing,
      this.menu = false,
      this.bold = false,
      this.openDrawer,
      this.back = false,
      this.thick = false,
      this.backasClose = false,
      this.searchIcon = false,
      this.onChangeSearch,
      this.onTapClose,
      this.searchTitle});

  final bool menu;
  final bool back;
  final bool thick;
  final bool backasClose;
  //final bool tablet;
  final searchTitle;
  final bool bold;
  final String title;
  final Widget leading;
  final Function onTapClose;
  final Function openDrawer;
  final List<Widget> trailing;
  final bool searchIcon;
  final Function onChangeSearch;
  @override
  _EpaisaAppBarState createState() => _EpaisaAppBarState();
}

class _EpaisaAppBarState extends State<EpaisaAppBar> {
  double _statusBarHeight = 0.5;
  BuildContext get context => context;
  bool searchMode = false;
  bool isTyping = false;
  var isIOS = Platform.isIOS;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    double statusBarHeight;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      statusBarHeight = await FlutterStatusbarManager.getHeight;
    } on PlatformException {
      statusBarHeight = 0.0;
    }
    if (!mounted) return;

    setState(() {
      _statusBarHeight = statusBarHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final bool tablet = isTablet(MediaQuery.of(context));

    List renderTrailing() {
      if (widget.trailing == null) {
        return [];
      }
      return widget.trailing.map((i) {
        return Container(
          // color: Colors.green,
          // width: hp(6),
          child: i,
        );
      }).toList();
    }

    return Container(
      decoration: BoxDecoration(
        //border: Border(bottom: BorderSide(color: AppColors.PrimaryBlue)),
        color: AppColors.PrimaryBlue,
        boxShadow: [
          new BoxShadow(
              color: AppColors.Black.withOpacity(0.6),
              offset: new Offset(-2, 2),
              blurRadius: 3),
          new BoxShadow(
              color: AppColors.Black.withOpacity(0.6),
              offset: new Offset(2, 2),
              blurRadius: 3)
        ],
      ),
      padding: EdgeInsets.only(top: isIOS ? hp(0) : hp(tablet ? 1 : 3)),
      alignment: Alignment.center,
      height: isIOS ? hp(9.8) : hp(tablet? 11 : 11.5),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: hp(0.5)),
            child: Center(
              child: Text(
                widget.title,
                style: TextStyle(
                    fontWeight: tablet ? FontWeight.w700 : FontWeight.w600,
                    fontSize: tablet
                        ? hp(2.3)
                        : widget.title.length > 10 ? wp(4.2) : wp(4.5),
                    color: AppColors.PrimaryWhite,
                    letterSpacing: tablet ? wp(0.25) : wp(0.4)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            left: tablet ? wp(1.6) : wp(2.5),
            child: GestureDetector(
                onTap: () {
                  if (widget.menu) {
                    widget.openDrawer();
                  } else if (widget.back) {
                    if (widget.onTapClose != null) {
                      widget.onTapClose();
                    } else {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Container(
                  height: hp(9.4),
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                    horizontal: tablet ? wp(0.4) : wp(1),
                  ),
                  alignment: Alignment.center,
                  child: widget.menu
                      ? Container(
                          margin: EdgeInsets.only(top: hp(0.5)),
                          width: hp(3),
                          height: hp(3),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/header/sidelist.png',
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      : widget.back
                          ? Container(
                              // color: Colors.green,

                              width: hp(2.4),

                              height: widget.backasClose ? hp(4.4) : hp(2.4),
                              child: widget.backasClose
                                  ? widget.thick
                                      ? Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: tablet ? hp(4.2) : wp(7),
                                        )
                                      : Image.asset(
                                          "assets/general_icons/xbutton.png",
                                          height: hp(2.4),
                                          width: hp(2.4),
                                          color: AppColors.DarkWhite,
                                        )
                                  : Image.asset(
                                      "assets/header/leftarrow.png",
                                      height: hp(2.4),
                                      width: hp(2.4),
                                    ),
                            )
                          : SizedBox(
                              width: 0,
                            ),
                )),
          ),
          Positioned(
            right: tablet ? wp(2.9) : wp(3.5),
            child: Container(
                padding: EdgeInsets.only(top: hp(0.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ...renderTrailing().toList(),
                    if (widget.searchIcon)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            searchMode = true;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: tablet ? hp(0.5) : wp(3),
                              right: tablet ? 0 : wp(.5)),
                          child: Image.asset(
                            "assets/general_icons/search.png",
                            color: Colors.white,
                            height: tablet ? hp(2.8) : hp(2.2),
                          ),
                        ),
                      ),
                  ],
                )),
          ),

          /*Positioned(
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    height: hp(9),
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        if (widget.searchIcon)
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  searchMode = true;
                                });
                              },
                              child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: wp(2)),
                                  child: Image.asset(
                                    "assets/general_icons/search.png",
                                    color: Colors.white,
                                    height: hp(2.2),
                                    width: hp(5),
                                  ))),
                        ...renderTrailing(widget.searchIcon).toList()
                      ],
                    ),
                  ),
                ),*/
          searchMode
              ? Container(
                  color: AppColors.PrimaryBlue,
                  width: wp(100),
                  padding: EdgeInsets.symmetric(
                      horizontal: tablet ? hp(2) : wp(3.5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.symmetric(
                            vertical: hp(1.2),
                            horizontal: tablet ? hp(2) : wp(3),
                          ),
                          margin: EdgeInsets.only(top: hp(0.8)),
                          child: Row(
                            children: <Widget>[
                              isTyping
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          right: tablet ? wp(1) : wp(3)),
                                      child: Image.asset(
                                        "assets/general_icons/search.png",
                                        color: AppColors.BorderGray,
                                        height: hp(2.1),
                                      ),
                                    )
                                  : Container(),
                              Expanded(
                                  child: TextField(
                                onChanged: (str) {
                                  setState(() {
                                    isTyping = str == '' ? false : true;
                                  });
                                  widget.onChangeSearch(str);
                                },
                                style:
                                    TextStyle(fontSize: tablet ? hp(2) : wp(4)),
                                decoration: InputDecoration.collapsed(
                                    hintText:
                                        "${eptxt('search')} ${widget.searchTitle ?? eptxt('settings')}",
                                    hintStyle: TextStyle(
                                        fontSize: tablet ? hp(1.8) : wp(3.5),
                                        fontWeight: FontWeight.w600)),
                              )),
                              GestureDetector(
                                onTap: () {
                                  if (widget.onChangeSearch != null)
                                    widget.onChangeSearch("");
                                  setState(() {
                                    searchMode = false;
                                    isTyping = false;
                                  });
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: wp(.5)),
                                  child: isTyping
                                      ? Icon(
                                          Icons.cancel,
                                          size: tablet ? hp(3.1) : wp(5.1),
                                          color: AppColors.DarkGray,
                                        )
                                      : Image.asset(
                                          "assets/general_icons/search.png",
                                          color: AppColors.BorderGray,
                                          height: tablet ? hp(2.6) : wp(5.1),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.PrimaryWhite,
                              borderRadius: BorderRadius.circular(hp(0.7)))),
                    ],
                  ),
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }
}
