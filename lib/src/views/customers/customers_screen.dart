import 'dart:async';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/customers/customers_info/customer_info.dart';
import 'package:epaisa_pos/src/views/customers/widgets/add_customer_dialog.dart';
import 'package:epaisa_pos/src/views/customers/widgets/distributor_item.dart';
import 'package:epaisa_pos/src/views/screen_with_side/screen_with_side.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/textfields/search_field_box.dart';
import 'package:epaisa_pos/src/widgets/utils/rect_getter.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class CustomersScreen extends StatefulWidget {
  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class ObjList {
  List<String> list = new List<String>();
  String key;
  ObjList({this.list, this.key});
}

class _CustomersScreenState extends State<CustomersScreen> {
  List<ObjList> dist = new List<ObjList>();
  List<double> listOffset = new List<double>();
  List<ObjList> filteredList = new List<ObjList>();
  bool searchMode = false;
  ScrollController _ctl = new ScrollController();
  BehaviorSubject<int> _indexKey = BehaviorSubject<int>();
  Timer _debounce;
  String str;
  @override
  void initState() {
    dist.add(ObjList(key: "A", list: ["Aldo", "Ariel"]));
    dist.add(ObjList(key: "B", list: ["Carlos", "Cesar"]));
    dist.add(ObjList(key: "C", list: ["Esteban"]));
    dist.add(ObjList(key: "D", list: ["Esteban"]));
    dist.add(ObjList(key: "E", list: ["Esteban"]));
    dist.add(ObjList(key: "F", list: ["Esteban"]));
    dist.add(ObjList(key: "G", list: ["Esteban"]));
    dist.add(ObjList(key: "H", list: ["Esteban"]));
    dist.add(ObjList(key: "I", list: ["Esteban"]));
    dist.add(ObjList(key: "J", list: []));
    dist.add(ObjList(key: "K", list: ["Esteban"]));
    dist.add(ObjList(key: "L", list: ["Esteban"]));
    dist.add(ObjList(key: "M", list: ["Esteban"]));
    dist.add(ObjList(key: "N", list: ["Esteban"]));
    dist.add(ObjList(key: "O", list: ["Esteban"]));
    dist.add(ObjList(key: "P", list: ["Esteban"]));
    dist.add(ObjList(key: "Q", list: ["Esteban"]));
    dist.add(ObjList(key: "R", list: ["Esteban"]));
    dist.add(ObjList(key: "S", list: ["Esteban"]));
    dist.add(ObjList(key: "T", list: ["Esteban"]));
    dist.add(ObjList(key: "U", list: ["Esteban"]));
    dist.add(ObjList(key: "V", list: ["Esteban"]));
    dist.add(ObjList(key: "W", list: ["Esteban"]));
    dist.add(ObjList(key: "Z", list: ["Esteban"]));
    dist.add(ObjList(key: "#", list: ["Esteban"]));
    for (var i = 0; i < dist.length; i++) {
      if (i == 0)
        listOffset.add(0);
      else {
        listOffset.add(
            listOffset[i - 1] + dist[i - 1].list.length * hp(9.2) + hp(5.85));
      }
    }
    print(listOffset);
    filteredList = clone(dist);
    str = "";
    _ctl.addListener(_scrollGetter);
    _indexKey.sink.add(0);
    super.initState();
  }

  void _scrollGetter() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      for (var i = 0; i < listOffset.length; i++) {
        if (_ctl.offset < listOffset[i]) {
          if (i == 0)
            _indexKey.sink.add(0);
          else {
            _indexKey.sink.add(i - 1);
          }
          break;
        }
      }
    });
  }

  List<ObjList> clone(List<ObjList> temp) {
    List<ObjList> res = new List<ObjList>();
    for (var i = 0; i < temp.length; i++) {
      ObjList temp2 = new ObjList(key: temp[i].key, list: temp[i].list);
      res.add(temp2);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    var listViewKey = RectGetter.createGlobalKey();

    var _keys = {};

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

    void filterList(String query) {
      if (query == "") {
        //filteredList.clear();
        filteredList = clone(dist);
        print(dist[0].list.length);
        /*dist.forEach((f) {
          f.list.forEach((x) {
            print(x);
          });
        });*/
        setState(() {
          str = '';
        });
      } else {
        print("New$query");
        List<ObjList> tot = new List<ObjList>();
        tot = clone(dist); //.toList();
        for (var i = 0; i < dist.length; i++) {
          List<String> newList =
              tot[i].list.where((f) => f.contains(query)).toList();
          tot[i].list = newList;
        }
        setState(() {
          filteredList = tot;
          str = query;
        });
      }
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

    List<Widget> _buildAbc(index) {
      print(index);
      List<Widget> content = List<Widget>();
      print(str);
      for (var i = 0; i < abc.length; i++) {
        content.add(GestureDetector(
          onTap: () {
            print(i);
            jumpTo(i);
          },
          child: Text(
            abc[i],
            textAlign: TextAlign.center,
            style: TextStyle(
                color: str != ''
                    ? str[0] == abc[i]
                        ? AppColors.PrimaryBlue
                        : AppColors.DarkGray
                    : index == i ? AppColors.PrimaryBlue : AppColors.DarkGray,
                fontSize: tablet ? wp(1.3) : hp(1.6),
                fontWeight: str != ''
                    ? str[0] == abc[i] ? FontWeight.w700 : FontWeight.w600
                    : index == i ? FontWeight.w700 : FontWeight.w600),
          ),
        ));
      }

      return content;
    }

    Widget _buildContent() {
      return Column(
        children: <Widget>[
          Container(
            //padding: EdgeInsets.symmetric(horizontal: tablet ? wp(1) : wp(2.5)),
            child: SearchFieldBox(
              callback: (query) {
                filterList(query);
              },
              hintText: "${eptxt('search')}",
              paddingVertical: hp(1.9),
              paddingHorizontal: tablet ? wp(1.5) : wp(5),
              fontSize: tablet ? wp(1.6) : hp(2.6),
            ),
          ),
          Expanded(
              child: Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(
                  left: tablet ? wp(0.5) : wp(1),
                  //right: tablet ? wp(3) : wp(6)
                ),
                child: Container(
                  child: RectGetter(
                      key: listViewKey,
                      child: SingleChildScrollView(
                        controller: _ctl,
                        child: Column(
                          children: List.generate(
                            filteredList.length,
                            (index) {
                              _keys[index] = RectGetter.createGlobalKey();
                              return RectGetter(
                                key: _keys[index],
                                child: StickyHeader(
                                    header: filteredList[index] != null &&
                                            filteredList[index].list.isNotEmpty
                                        ? Container(
                                            height: hp(5.85),
                                            padding: new EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            alignment: Alignment.centerLeft,
                                            child: new Text(
                                              '${filteredList[index].key}',
                                              style: TextStyle(
                                                  color: AppColors.DarkGray,
                                                  fontSize: hp(2.34),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        : Container(),
                                    content: GestureDetector(
                                      onTap: () {
                                        if (!tablet)
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomersInfoScreen()));
                                      },
                                      child: DistributorItem(
                                          list: filteredList[index].list),
                                    )),
                              );
                            },
                          ),
                        ),
                      )),
                ),
              ),
              Container(
                  width: tablet ? wp(4) : wp(6),
                  padding:
                      EdgeInsets.symmetric(vertical: tablet ? hp(1.5) : hp(.5)),
                  alignment: Alignment.center,
                  child: StreamBuilder<Object>(
                      stream: _indexKey,
                      builder: (context, snapshot) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: _buildAbc(snapshot.data),
                        );
                      }))
            ],
          ))
        ],
      );
    }

    return EpaisaScaffold(
        appBar: EpaisaAppBar(
          openDrawer: () {
            Scaffold.of(context).openDrawer();
          },
          menu: true,
          title: "CUSTOMERS",
          trailing: <Widget>[
            GestureDetector(
              onTap: () {
                _showDialog();
              },
              child: Image.asset(
                "assets/customers/add_customer.png",
                height: hp(3.1),
                width: hp(3.1),
              ),
            )
          ],
        ),
        body: tablet
            ? ScreenWithSide(
                sidePercent: 38,
                side: _buildContent(),
                body: CustomersInfoScreen(),
              )
            : _buildContent());
  }

  void _showDialog() {
    // flutter defined function
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return AddCustomerDialog();
      },
    ));
  }
}
