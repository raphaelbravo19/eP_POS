import 'dart:io';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class PackageItem extends StatefulWidget {
  final double scale;

  final Color color;
  Function onTap;
  final String text;
  final double price;
  final int quantity;
  final int gridLength;
  final bool noPrice;
  final bool noQuant;
  final bool sideName;
  final bool noPackage;
  final bool checkMark;
  final bool showCounter;
  final double bottomPadding;
  final Function onChecked;
  final bool checked;
  final String products;
  final String image;
  PackageItem(
      {this.scale = 0,
      this.color,
      this.text = "",
      this.onTap,
      this.price = 25.0,
      this.quantity = 12,
      this.gridLength = 2,
      this.noPrice = false,
      this.noQuant = false,
      this.noPackage = false,
      this.showCounter = false,
      this.checkMark = false,
      this.sideName = false,
      this.bottomPadding = 0,
      this.onChecked,
      this.image = "",
      this.checked = false,
      this.products = ""});

  @override
  _PackageItemState createState() => _PackageItemState();
}

class _PackageItemState extends State<PackageItem> {
  bool checked = false;
  @override
  void initState() {
    checked = widget.checked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    var tablet = isTablet(MediaQuery.of(context));
    bool isIOS = Platform.isIOS;
    var title =
        widget.text != "" ? (widget.text.toUpperCase()) : "Fruits & Vegetables";
    var maxLength =
        (((tablet ? wp(100) : wp(91)) / widget.scale * (isIOS ? 3.6 : 4)) /
                    widget.gridLength)
                .toInt() -
            (widget.gridLength * 3);
    return GestureDetector(
      onTap: widget.onTap != null
          ? () => widget.onTap()
          : () {
              setState(() {
                checked = !checked;
              });
              if (widget.onChecked != null) {
                widget.onChecked(checked);
              }
            },
      child: Container(
        margin: EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.scale * 0.3),
          color: AppColors.PrimaryWhite,
          boxShadow: [
            new BoxShadow(
                color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.8),
                offset: new Offset(0.6, 1.0),
                blurRadius: 1.0)
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: <Widget>[
                widget.image != '' && widget.image != null
                    ? Expanded(
                        flex: 5,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widget.scale),
                              child: Container(
                                child: widget.image != '' &&
                                        widget.image != null
                                    ? widget.image.indexOf("files") != -1 ||
                                            widget.image
                                                    .indexOf("Application") !=
                                                -1
                                        ? Image.file(
                                            new File(widget.image.substring(
                                                7, widget.image.length - 1)),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            widget.image,
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes
                                                      : null,
                                                ),
                                              );
                                            },
                                          )
                                    : SizedBox(),
                              ),
                            ),
                            if (widget.showCounter)
                              Container(
                                color: AppColors.Black.withOpacity(0.6),
                                padding: EdgeInsets.symmetric(
                                  horizontal: widget.scale * 0.8,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/general_icons/minus.png",
                                      height: widget.scale * 2,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: widget.scale * 2),
                                        child: Container(
                                          alignment: Alignment.center,
                                          // color: Colors.red,
                                          child: Text(
                                            3.toString(),
                                            style: TextStyle(
                                              color: AppColors.PrimaryWhite,
                                              fontWeight: FontWeight.w700,
                                              fontSize: widget.scale * 1.4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/general_icons/plus.png",
                                      height: widget.scale * 2,
                                    )
                                  ],
                                ),
                              ),
                            widget.noPackage
                                ? Container()
                                : Positioned(
                                    left: 0, // widget.scale * 0.1,
                                    top: 0, // widget.scale * 0.1,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: tablet
                                          ? widget.scale * 2.8
                                          : widget.scale * 2.3,
                                      width: tablet
                                          ? widget.scale * 2.8
                                          : widget.scale * 2.3,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: widget.scale * 0.1,
                                          vertical: widget.scale * 0.4),
                                      decoration: BoxDecoration(
                                          color: AppColors.PrimaryBlue,
                                          boxShadow: [
                                            new BoxShadow(
                                                color: AppColors.DarkGray
                                                    .withOpacity(
                                                        tablet ? 0.6 : 0.8),
                                                offset: new Offset(1.0, 1.0),
                                                blurRadius: 2.0)
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              widget.scale * 0.3)),
                                      //border: Border.all(
                                      //  color: AppColors.LightGray, width: 0.9)),
                                      child: Image.asset(
                                        "assets/leftdrawer/packages.png",
                                        color: AppColors.DarkWhite.withOpacity(
                                            0.8),
                                      ),
                                    ),
                                  ),
                            widget.checkMark
                                ? Positioned(
                                    right: widget.scale * 0.3,
                                    top: widget.scale * 0.3,
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: tablet
                                            ? widget.scale * 1.5
                                            : widget.scale * 1.4,
                                        width: tablet
                                            ? widget.scale * 1.5
                                            : widget.scale * 1.4,
                                        decoration: BoxDecoration(
                                            color: AppColors.DarkWhite,
                                            borderRadius: BorderRadius.circular(
                                                widget.scale * 0.2),
                                            border: Border.all(
                                                color: widget.quantity < 10
                                                    ? AppColors.ErrorText
                                                    : AppColors.LightGray,
                                                width: 2)),
                                        child: checked
                                            ? Container(
                                                height: tablet
                                                    ? widget.scale * 0.8
                                                    : widget.scale * 0.6,
                                                width: tablet
                                                    ? widget.scale * 0.8
                                                    : widget.scale * 0.6,
                                                color: AppColors.DarkGray,
                                              )
                                            : Container()),
                                  )
                                : Container()
                          ],
                        ),
                      )
                    : Container(
                        height:
                            tablet ? widget.scale * 2.8 : widget.scale * 2.3,
                        alignment: Alignment.center,
                        child: Stack(
                          children: <Widget>[
                            widget.noPackage
                                ? Container()
                                : Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: tablet
                                          ? widget.scale * 2.8
                                          : widget.scale * 2.3,
                                      width: tablet
                                          ? widget.scale * 2.8
                                          : widget.scale * 2.3,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: widget.scale * 0.1,
                                          vertical: widget.scale * 0.4),
                                      decoration: BoxDecoration(
                                          color: AppColors.PrimaryBlue,
                                          boxShadow: [
                                            new BoxShadow(
                                                color: AppColors.DarkGray
                                                    .withOpacity(
                                                        tablet ? 0.6 : 0.8),
                                                offset: new Offset(1.0, 1.0),
                                                blurRadius: 2.0)
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              widget.scale * 0.3)),
                                      //border: Border.all(
                                      //  color: AppColors.LightGray, width: 0.9)),
                                      child: Image.asset(
                                        "assets/leftdrawer/packages.png",
                                        color: AppColors.DarkWhite.withOpacity(
                                            0.8),
                                      ),
                                    )),
                            widget.checkMark
                                ? Positioned(
                                    right: widget.scale * 0.3,
                                    top: widget.scale * 0.3,
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: tablet
                                            ? widget.scale * 1.5
                                            : widget.scale * 1.4,
                                        width: tablet
                                            ? widget.scale * 1.5
                                            : widget.scale * 1.4,
                                        decoration: BoxDecoration(
                                            color: AppColors.DarkWhite,
                                            borderRadius: BorderRadius.circular(
                                                widget.scale * 0.2),
                                            border: Border.all(
                                                color: widget.quantity < 10
                                                    ? AppColors.ErrorText
                                                    : AppColors.LightGray,
                                                width: 2)),
                                        child: checked
                                            ? Container(
                                                height: tablet
                                                    ? widget.scale * 0.8
                                                    : widget.scale * 0.6,
                                                width: tablet
                                                    ? widget.scale * 0.8
                                                    : widget.scale * 0.6,
                                                color: AppColors.DarkGray,
                                              )
                                            : Container()),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                widget.image == '' || widget.image == null
                    ? Expanded(
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                widget.scale * 0.4,
                                0, //tablet ? scale * 1.5 : scale * 0.7,
                                widget.sideName
                                    ? widget.scale * 1.6
                                    : widget.scale * 0.2,
                                0 //scale * 2,
                                ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                                title.length > maxLength * 1.5
                                    ? title.substring(
                                            0, (maxLength * 1.5).toInt()) +
                                        '...'
                                    : title,
                                style: TextStyle(
                                    fontSize: tablet
                                        ? widget.scale * 0.77 * 1.2
                                        : widget.scale * 0.725 * 1.2,
                                    fontWeight: tablet
                                        ? FontWeight.w600
                                        : FontWeight.w700,
                                    color: AppColors.DisabledText))),
                      )
                    : SizedBox(),
                Expanded(
                    flex: widget.image == '' || widget.image == null ? 1 : 3,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(top: hp(0.3)),
                      child: Column(
                        children: <Widget>[
                          if (widget.image != '' && widget.image != null)
                            Container(
                                padding: EdgeInsets.fromLTRB(
                                    widget.scale * 0.4,
                                    0, //tablet ? scale * 1.5 : scale * 0.7,
                                    widget.sideName
                                        ? widget.scale * 1.6
                                        : widget.scale * 0.2, //scale * 2,
                                    widget.bottomPadding +
                                        (widget.sideName
                                            ? tablet
                                                ? widget.scale * 0.4
                                                : widget.scale * 0.4
                                            : 0)),
                                alignment: Alignment.topLeft,
                                child: Text(
                                    title.length > maxLength
                                        ? title.substring(0, maxLength) + '...'
                                        : title,
                                    style: TextStyle(
                                        fontSize: tablet
                                            ? widget.scale * 0.77
                                            : widget.scale * 0.725,
                                        fontWeight: tablet
                                            ? FontWeight.w600
                                            : FontWeight.w700,
                                        color: AppColors.DisabledText))),
                          widget.noPrice
                              ? Container()
                              : Container(
                                  padding: EdgeInsets.fromLTRB(
                                      widget.scale * 0.4,
                                      0, //tablet ? scale * 1.5 : scale * 0.7,
                                      widget.scale * 0.2, //scale * 2,
                                      widget.scale * 0.2),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "₹ ${widget.price.toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontSize: tablet
                                              ? widget.scale * 0.75
                                              : widget.scale * 0.72,
                                          fontWeight: tablet
                                              ? FontWeight.w700
                                              : FontWeight.w700,
                                          color: AppColors.DisabledText)),
                                )
                        ],
                      ),
                    ))
              ],
            ),
            widget.noQuant
                ? Container()
                : Positioned(
                    right: widget.scale * 0.3,
                    bottom: widget.scale * 0.3,
                    child: Container(
                      alignment: Alignment.center,
                      height: tablet ? widget.scale * 1.7 : widget.scale * 1.6,
                      padding: EdgeInsets.symmetric(
                          horizontal: widget.scale * 0.08,
                          vertical: widget.scale * 0.28),
                      width: tablet ? widget.scale * 1.7 : widget.scale * 1.6,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(widget.scale * 0.3),
                          border: Border.all(
                              color: widget.quantity < 10
                                  ? AppColors.ErrorText
                                  : AppColors.LightGray,
                              width: 0.9)),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          widget.products != "" ? widget.products : "10",
                          style: TextStyle(
                              //fontSize: tablet ? scale * 0.9 : scale * 0.85,
                              fontWeight:
                                  tablet ? FontWeight.w600 : FontWeight.w800,
                              color: widget.quantity < 10
                                  ? AppColors.ErrorText
                                  : AppColors.DisabledText),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
