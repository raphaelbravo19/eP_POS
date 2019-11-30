import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';

class DialogForDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final double posx;
  final double posy;
  final double height;
  final double width;
  final double fontSize;
  final Function onTap;
  final Function itemBuilder;
  final Function updateFocus;
  final bool multi;
  final List<int> multiItems;
  final Function updateMulti;
  DialogForDropdown(
      {Key key,
      this.items,
      this.posx,
      this.posy,
      this.onTap,
      this.height,
      this.width,
      this.fontSize,
      this.itemBuilder,
      this.updateFocus,
      this.multi = false,
      this.updateMulti,
      this.multiItems})
      : super(key: key);

  @override
  DialogForDropdownState createState() => DialogForDropdownState();
}

class DialogForDropdownState extends State<DialogForDropdown> {
  bool showModal;
  List<int> tempList;
  @override
  void initState() {
    showModal = true;
    print("KK");
    tempList = widget.multiItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var finalHeight = widget.height *
        (widget.items.length < 3 ? widget.items.length * 0.5 : 1.5);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Container(
        alignment: Alignment.center,
        width: wp(100),
        height: hp(100),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            GestureDetector(
              onTapDown: (TapDownDetails) {
                //print("works");
                if (widget.updateFocus != null) widget.updateFocus();
                setState(() {
                  showModal = false;
                });
                Navigator.of(context).pop();
              },
              /*onTap: () {
                Navigator.of(context).pop();
              },*/
              child: Container(
                width: wp(100),
                height: hp(100),
                color: Colors.black.withOpacity(0),
              ),
            ),
            Positioned(
              top: widget.posy + finalHeight > hp(99)
                  ? hp(99) - finalHeight
                  : widget.posy,
              left: widget.posx,
              child: showModal
                  ? Container(
                      //padding: EdgeInsets.all(20),
                      height: finalHeight,
                      width: widget.width,
                      decoration: BoxDecoration(
                        color: AppColors.PrimaryWhite,
                        boxShadow: [
                          new BoxShadow(
                              color: AppColors.DarkGray.withOpacity(0.5),
                              offset: new Offset(0.3, 2.0),
                              blurRadius: 2.0),
                          new BoxShadow(
                              color: AppColors.DarkGray.withOpacity(0.5),
                              offset: new Offset(-0.6, 0),
                              blurRadius: 1.0)
                        ],
                      ),
                      child: Scrollbar(
                        child: ScrollConfiguration(
                          behavior: RemoveOverScrollGlow(),
                          child: SingleChildScrollView(
                            child: Column(
                              children:
                                  List.generate(widget.items.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    //Navigator.pop(context);

                                    if (!widget.multi) {
                                      if (widget.onTap != null) {
                                        widget.onTap(index);
                                      }
                                      updateShow();
                                      Navigator.of(context).pop();
                                    } else {
                                      if (tempList.indexOf(index) != -1) {
                                        setState(() {
                                          tempList.remove(index);
                                        });
                                      } else {
                                        setState(() {
                                          tempList.add(index);
                                        });
                                      }
                                      widget.updateMulti(tempList);
                                    }

                                    ///selectedIndex = index;
                                  },
                                  child: widget.itemBuilder != null
                                      ? widget.itemBuilder(
                                          index: index,
                                          height: widget.height * 0.5,
                                        )
                                      : Container(
                                          alignment: Alignment.centerLeft,
                                          height: widget.height * 0.5,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: widget.width * 0.03),
                                          child: widget.multi
                                              ? Row(
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.all(
                                                          widget.fontSize *
                                                              0.1),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: widget
                                                                    .fontSize *
                                                                0.1,
                                                            color: tempList.indexOf(
                                                                        index) !=
                                                                    -1
                                                                ? AppColors
                                                                    .PrimaryBlue
                                                                : AppColors
                                                                    .DarkGray,
                                                          ),
                                                          borderRadius: BorderRadius
                                                              .circular(widget
                                                                      .fontSize *
                                                                  0.1)),
                                                      margin: EdgeInsets.only(
                                                          right: widget.width *
                                                              0.03),
                                                      child: Container(
                                                        color: tempList.indexOf(
                                                                    index) !=
                                                                -1
                                                            ? AppColors
                                                                .PrimaryBlue
                                                            : Colors
                                                                .transparent,
                                                      ),
                                                      height:
                                                          widget.fontSize * 0.9,
                                                      width:
                                                          widget.fontSize * 0.9,
                                                    ),
                                                    Text(
                                                        widget.items[index]
                                                            ['name'],
                                                        style: TextStyle(
                                                            color: AppColors
                                                                    .DisabledText
                                                                .withOpacity(
                                                                    0.9),
                                                            fontSize:
                                                                widget.fontSize,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700))
                                                  ],
                                                )
                                              : Text(
                                                  widget.items[index]['name'],
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.DisabledText
                                                              .withOpacity(0.9),
                                                      fontSize: widget.fontSize,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                        ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ))
                  : Container(),
            )
          ],
        ),
      ),
    );
  }

  void updateShow() {
    setState(() {
      showModal = false;
    });
  }
}
