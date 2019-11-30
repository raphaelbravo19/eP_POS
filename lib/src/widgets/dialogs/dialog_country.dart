import 'dart:async';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/countries.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';

import 'package:epaisa_pos/src/widgets/utils/rect_getter.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class DialogCountry extends StatefulWidget {
  DialogCountry({this.countrySelected, this.onClick, this.onClose});
  CountryData countrySelected;
  Function onClick;
  Function onClose;
  @override
  _DialogCountryState createState() => _DialogCountryState();
}

class _DialogCountryState extends State<DialogCountry> {
  List<CountryList> dist = new List<CountryList>();
  List<CountryList> filteredList = new List<CountryList>();
  bool showModal = true;
  bool searchMode = false;
  String query;
  @override
  void initState() {
    structCountries().then(
      (data) {
        setState(() {
          dist = data;
        });
      },
    );
    super.initState();
  }

  void closeModal() {
    Navigator.of(context).pop();
    setState(() {
      showModal = false;
    });
    if (widget.onClose != null) widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    var listViewKey = RectGetter.createGlobalKey();
    var _keys = {};
    var _ctl = new ScrollController();
    List<int> getVisible() {
      var rect = RectGetter.getRectFromKey(listViewKey);
      var _items = <int>[];
      _keys.forEach((index, key) {
        var itemRect = RectGetter.getRectFromKey(key);
        if (itemRect != null &&
            !(itemRect.top > rect.bottom || itemRect.bottom < rect.top))
          _items.add(index);
      });
      return _items;
    }

    void scrollLoop(int target, Rect listRect) {
      var first = getVisible().first;
      bool direction = first < target;
      Rect _rect;
      if (_keys.containsKey(target))
        _rect = RectGetter.getRectFromKey(_keys[target]);
      if (_rect == null ||
          (direction
              ? _rect.bottom < listRect.top
              : _rect.top > listRect.bottom)) {
        var offset = _ctl.offset +
            (direction ? listRect.height / 2 : -listRect.height / 2);
        offset = offset < 0.0 ? 0.0 : offset;
        offset = offset > _ctl.position.maxScrollExtent
            ? _ctl.position.maxScrollExtent
            : offset;
        _ctl.jumpTo(offset);
        Timer(Duration.zero, () {
          scrollLoop(target, listRect);
        });
        return;
      }

      _ctl.jumpTo(_ctl.offset + _rect.top - listRect.top);
    }

    void jumpTo(int target) {
      var listRect = RectGetter.getRectFromKey(listViewKey);
      print(listRect);
      if (listRect != null) {
        scrollLoop(target, listRect);
      }
    }

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

    List<Widget> _buildAbc() {
      List<Widget> content = List<Widget>();
      for (var i = 0; i < abc.length; i++) {
        content.add(Expanded(
          child: GestureDetector(
            onTap: () {
              //print(i);
              jumpTo(i);
            },
            child: Container(
              width: wp(5),
              child: Text(
                abc[i],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: tablet ? wp(1.3) : hp(1.6),
                    fontWeight: FontWeight.w700,
                    color: AppColors.PrimaryBlue),
              ),
            ),
          ),
        ));
      }

      return content;
    }

    return Scaffold(
      backgroundColor: showModal ? AppColors.PrimaryBlue : Colors.transparent,
      body: SafeArea(
        child: !showModal
            ? Container()
            : Container(
                color: AppColors.DarkWhite,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.PrimaryBlue,
                        border:
                            Border.all(color: AppColors.PrimaryBlue, width: 3),
                        boxShadow: [
                          new BoxShadow(
                              color: AppColors.DarkGray,
                              offset: new Offset(0, 2),
                              blurRadius: 3.0),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                width: wp(100),
                                padding:
                                    EdgeInsets.symmetric(vertical: hp(1.6)),
                                child: Text(
                                  "Select Country/region code",
                                  style: TextStyle(
                                      fontSize: hp(2.5),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.PrimaryWhite),
                                ),
                              ),
                              Positioned(
                                right: wp(0.5),
                                top: hp(0.5),
                                child: GestureDetector(
                                  onTap: () {
                                    closeModal();
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: hp(1.3),
                                                horizontal: wp(2.95)),
                                            child: Image.asset(
                                              "assets/general_icons/xbutton.png",
                                              height: hp(2.2),
                                              color: AppColors.PrimaryWhite,
                                            )),
                                      )),
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: wp(97),
                            margin: EdgeInsets.only(bottom: hp(2)),
                            padding: EdgeInsets.symmetric(
                                vertical: hp(1), horizontal: wp(2)),
                            decoration: BoxDecoration(
                                color: AppColors.PrimaryWhite,
                                borderRadius: BorderRadius.circular(hp(1.1))),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.search,
                                  color: AppColors.PrimaryBlue,
                                  size: hp(3),
                                ),
                                SizedBox(
                                  width: wp(2),
                                ),
                                Expanded(
                                  child: TextField(
                                    onChanged: (str) {
                                      print(str);
                                      if (str != '') {
                                        filteredList = filterQuery(str, dist);
                                      }
                                      setState(() {
                                        searchMode = str != '';
                                        query = str;
                                      });
                                    },
                                    style: TextStyle(
                                        fontSize: hp(2),
                                        color: AppColors.PrimaryBlue,
                                        fontWeight: FontWeight.w600),
                                    decoration: InputDecoration.collapsed(
                                        hintText: "${eptxt('search')}...",
                                        hintStyle: TextStyle(
                                            fontSize: hp(2),
                                            color: AppColors.PrimaryBlue,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: wp(2), right: wp(1.8)),
                                      child: Image.asset(
                                        "assets/general_icons/xbutton.png",
                                        height: hp(1.5),
                                        color: AppColors.PrimaryBlue,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          wp(3),
                          tablet ? hp(1) : hp(2),
                          wp(3.8),
                          tablet ? hp(0.3) : hp(1)),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/flags/${widget.countrySelected.alpha2Code}_64.png',
                            height: tablet ? hp(5.4) : hp(3.5),
                            width: tablet ? hp(5.4) : hp(3.5),
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: tablet ? hp(3) : wp(4),
                          ),
                          Expanded(
                            child: Text(
                              "${widget.countrySelected.name} (+${widget.countrySelected.dialCode})",
                              style: TextStyle(
                                  fontSize: tablet ? hp(1.9) : hp(1.7),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.PrimaryBlue),
                            ),
                          ),
                          Image.asset(
                            'assets/general_icons/check.png',
                            height: tablet ? hp(3.7) : hp(2.2),
                            color: AppColors.PrimaryBlue,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: hp(1),
                      width: wp(100),
                      color: AppColors.PrimaryWhite,
                    ),
                    Expanded(
                        child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(
                              //left: tablet ? wp(0.5) : wp(1),
                              //right: tablet ? wp(3) : wp(6)
                              ),
                          child: Container(
                            color: AppColors.PrimaryWhite,
                            child: RectGetter(
                              key: listViewKey,
                              child: SingleChildScrollView(
                                controller: _ctl,
                                child: Column(
                                  children: [
                                    ...List.generate(
                                      searchMode
                                          ? filteredList.length
                                          : dist.length,
                                      (index) {
                                        _keys[index] =
                                            RectGetter.createGlobalKey();
                                        return RectGetter(
                                          key: _keys[index],
                                          child: StickyHeader(
                                              header: (searchMode
                                                              ? filteredList[
                                                                  index]
                                                              : dist[index]) !=
                                                          null &&
                                                      (searchMode
                                                              ? filteredList[
                                                                  index]
                                                              : dist[index])
                                                          .list
                                                          .isNotEmpty
                                                  ? Container(
                                                      height: hp(5),
                                                      color:
                                                          AppColors.DarkWhite,
                                                      padding: new EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16.0),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: new Text(
                                                        '${(searchMode ? filteredList[index] : dist[index]).key}',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .DarkGray,
                                                            fontSize: hp(2.34),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    )
                                                  : Container(),
                                              content: Column(
                                                  children: (searchMode
                                                          ? filteredList[index]
                                                          : dist[index])
                                                      .list
                                                      .map((f) {
                                                return CountryItem(
                                                  country: f,
                                                  onClick: (val) {
                                                    widget.onClick(val);
                                                    closeModal();
                                                  },
                                                );
                                              }).toList())),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            width: tablet ? wp(4) : wp(6),
                            color: AppColors.DarkWhite,
                            padding: EdgeInsets.symmetric(
                                vertical: tablet ? hp(1.5) : hp(.5)),
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: _buildAbc(),
                            ))
                      ],
                    ))
                  ],
                ),
              ),
      ),
    );
  }
}

class CountryItem extends StatelessWidget {
  CountryItem({this.country, this.onClick});
  final CountryObj country;
  final Function onClick;
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    return Container(
      padding: EdgeInsets.fromLTRB(
          wp(3), tablet ? 0 : hp(0.7), wp(5), tablet ? 0 : hp(0.7)),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(width: 1, color: AppColors.DisabledBorder)),
          color: AppColors.PrimaryWhite),
      child: GestureDetector(
        onTap: () {
          onClick(country);
        },
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/flags/${country.alpha2Code}_64.png',
              height: tablet ? hp(5.4) : hp(3.5),
              width: tablet ? hp(5.4) : hp(3.5),
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: tablet ? hp(3) : wp(4),
            ),
            Flexible(
              child: Text(
                "${country.name} (+${country.callingCodes[0]})",
                style: TextStyle(
                    fontSize: tablet ? hp(1.9) : hp(1.7),
                    fontWeight: FontWeight.w700,
                    color: AppColors.TextGray),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
