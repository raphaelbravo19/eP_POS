import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class DistributorItem extends StatelessWidget {
  List<Distributor> list = new List<Distributor>();
  Function callback;
  DistributorItem({this.list, this.callback});
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(list.length, (index) {
            List pl = list[index].products != null
                ? json.decode(list[index].products)
                : [];
            var productLength = 0;
            if (pl is List) {
              productLength = pl.length;
            }
            final int mobileLen = list[index].mobile.length;
            String str = list[index].mobile.substring(0, mobileLen - 10) +
                " " +
                list[index].mobile.substring(mobileLen - 10, mobileLen - 5) +
                " " +
                list[index].mobile.substring(mobileLen - 5, mobileLen);
            return GestureDetector(
              onTap: () {
                if (callback != null) {
                  Distributor d = list[index];
                  callback(d);
                }
              },
              child: Container(
                  padding: EdgeInsets.only(right: tablet ? wp(3) : wp(6)),
                  decoration: BoxDecoration(
                      color: AppColors.PrimaryWhite,
                      border: Border(
                          bottom: BorderSide(
                              color: AppColors.DisabledText.withOpacity(0.2),
                              width: 1))),
                  child: Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: hp(1.7), horizontal: hp(1.8)),
                          alignment: Alignment.center,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(hp(5.9)),
                              child: Container(
                                width: hp(5.9),
                                height: hp(5.9),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.DarkGray),
                                child: list[index].image != null
                                    ? list[index].image.indexOf("files") !=
                                                -1 ||
                                            list[index]
                                                    .image
                                                    .indexOf("Application") !=
                                                -1
                                        ? Image.file(
                                            new File(list[index]
                                                .image
                                                .substring(
                                                    7,
                                                    list[index].image.length -
                                                        1)),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            list[index].image,
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
                                    : Container(),
                              ))),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                list[index].name,
                                style: TextStyle(
                                    color: AppColors.DarkGray,
                                    fontWeight: FontWeight.w700,
                                    fontSize: hp(2.1),
                                    letterSpacing: 0.5),
                              )),
                          Padding(
                              padding: EdgeInsets.only(top: hp(0.5)),
                              child: Text(str,
                                  style: TextStyle(
                                      color: AppColors.DisabledText.withOpacity(
                                          0.5),
                                      fontWeight: FontWeight.w700,
                                      fontSize: hp(1.5),
                                      letterSpacing: 1))),
                        ],
                      )),
                      Container(
                          padding: EdgeInsets.only(right: hp(1.5)),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Text(
                                    productLength.toString(), //list[index],
                                    style: TextStyle(
                                        color: AppColors.DarkGray,
                                        fontWeight: FontWeight.w700,
                                        fontSize: hp(2.1),
                                        letterSpacing: 0.5),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(top: hp(0.5)),
                                  child: Text("Products",
                                      style: TextStyle(
                                          color: AppColors.DisabledText
                                              .withOpacity(0.5),
                                          fontWeight: FontWeight.w700,
                                          fontSize: hp(1.5),
                                          letterSpacing: 1))),
                            ],
                          )),
                    ],
                  )),
            );
          }),
        ),
      ),
    );
  }
}
