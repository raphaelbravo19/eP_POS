import 'dart:async';
import 'dart:io';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/distributors_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/distributors/add_distributors/add_distributors_screen.dart';
import 'package:epaisa_pos/src/views/distributors/widgets/distributor_item.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/textfields/search_field.dart';
import 'package:epaisa_pos/src/widgets/utils/rect_getter.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

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

class DistributorsScreen extends StatefulWidget {
  @override
  _DistributorsScreenState createState() => _DistributorsScreenState();
}

class ObjList {
  List<String> list = new List<String>();
  String key;
  ObjList({this.list, this.key});
}

class _DistributorsScreenState extends State<DistributorsScreen> {
  List<Distributor> distributors;
  DistributorsDao distributorsDao = new DistributorsDao(db);
  List<Map<String, dynamic>> dist = new List<Map<String, dynamic>>();
  List<double> listOffset = new List<double>();
  List<Map<String, dynamic>> filteredList = new List<Map<String, dynamic>>();
  bool searchMode = false;
  ScrollController _ctl = new ScrollController();
  BehaviorSubject<int> _indexKey = BehaviorSubject<int>();
  BehaviorSubject<String> streamSearch = BehaviorSubject<String>();
  Timer _debounce;
  String str;

  @override
  void initState() {
    str = "";
    for (var i = 0; i < dist.length; i++) {
      if (i == 0)
        listOffset.add(0);
      else {
        listOffset.add(listOffset[i - 1] +
            dist[i - 1]["list"].length * hp(9.2) +
            hp(5.85));
      }
    }
    //filteredList = clone(dist);
    _ctl.addListener(_scrollGetter);
    _indexKey.sink.add(0);
    super.initState();
  }

  Future<List<Distributor>> getDistributors() async {
    print("SI");
    dist = new List<Map<String, dynamic>>();
    distributors = await distributorsDao.getAll();

    return distributors;
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

  List<Map<String, dynamic>> clone(List<Map<String, dynamic>> temp) {
    List<Map<String, dynamic>> res = new List<Map<String, dynamic>>();
    for (var i = 0; i < temp.length; i++) {
      Map temp2 = {"key": temp[i]["key"], "list": temp[i]["list"]};
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
    var isIOS = Platform.isIOS;
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
        print(dist[0]["list"].length);
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
        List<Map<String, dynamic>> tot = new List<Map<String, dynamic>>();
        tot = clone(dist); //.toList();
        for (var i = 0; i < dist.length; i++) {
          List<String> newList =
              tot[i]["list"].where((f) => f.contains(query)).toList();
          tot[i]["list"] = newList;
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

    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        openDrawer: () {
          Scaffold.of(context).openDrawer();
        },
        menu: true,
        title: 'DISTRIBUTORS',
        trailing: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddDistributorsScreen()));
            },
            child: Image.asset(
              "assets/header/plusicon.png",
              height: tablet ? hp(3.5) : hp(2.4),
              width: tablet ? hp(3.5) : hp(2.4),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: hp(1),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: tablet ? wp(1) : wp(2.5)),
            child: SearchField(
              callback: (query) {
                streamSearch.sink.add(query);
              },
              hintText: "${eptxt('search')} ${eptxt('distributors')}",
              paddingVertical: hp(1.7),
              paddingHorizontal: tablet ? wp(1.5) : wp(3),
              fontSize: tablet ? wp(1.6) : hp(1.9),
            ),
          ),
          SizedBox(
            height: hp(0.5),
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
                        child: FutureBuilder<List<Distributor>>(
                          future: getDistributors(),
                          builder: (ctx, snapshot) {
                            print("Hola ${snapshot.data}");
                            if (snapshot.data != null) {
                              return StreamBuilder(
                                stream: streamSearch,
                                builder: (context, snap) {
                                  /*List<Map<String, dynamic>> filtered =
                                      new List<Map<String, dynamic>>();
                                  if (snap.data != null) {
                                    filtered = dist.map((f) {
                                      var newf = f;
                                      newf["list"] = new List<Distributor>();
                                      newf["list"] = f["list"]
                                          .map((x) =>
                                              x.name.toLowerCase().indexOf(
                                                  snap.data.toLowerCase()) ==
                                              0)
                                          .toList();
                                      return newf;
                                    }).toList();
                                  } else {
                                    filtered = dist.toList();
                                  }*/
                                  List<Map<String, dynamic>> filtered =
                                      new List<Map<String, dynamic>>();
                                  for (var i = 0; i < abc.length; i++) {
                                    List<Distributor> ls =
                                        new List<Distributor>();
                                    if (snap.data != null && snap.data != "") {
                                      if (snap.data[0].toUpperCase() ==
                                          abc[i]) {
                                        ls = snapshot.data
                                            .where((d) =>
                                                d.name[0].toUpperCase() ==
                                                abc[i])
                                            .where((d) =>
                                                d.name.toLowerCase().indexOf(
                                                    snap.data.toLowerCase()) ==
                                                0)
                                            .map((x) => x)
                                            .toList();
                                      }
                                    } else {
                                      ls = snapshot.data
                                          .where((d) =>
                                              d.name[0].toUpperCase() == abc[i])
                                          .map((x) => x)
                                          .toList();
                                    }
                                    print(ls);
                                    filtered.add({"key": abc[i], "list": ls});
                                  }
                                  print("NEW ARRAY $filtered");
                                  return Column(
                                      children: List.generate(
                                    filtered.length,
                                    (index) {
                                      _keys[index] =
                                          RectGetter.createGlobalKey();
                                      return RectGetter(
                                        key: _keys[index],
                                        child: StickyHeader(
                                          header: filtered[index] != null &&
                                                  filtered[index]["list"]
                                                      .isNotEmpty
                                              ? Container(
                                                  height: hp(5.85),
                                                  padding:
                                                      new EdgeInsets.symmetric(
                                                          horizontal: 16.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: new Text(
                                                    '${filtered[index]["key"]}',
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.DarkGray,
                                                        fontSize: hp(2.34),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              : Container(),
                                          content: DistributorItem(
                                              callback: (val) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            new AddDistributorsScreen(
                                                                distributor:
                                                                    val)));
                                              },
                                              list: filtered[index]["list"]),
                                        ),
                                      );
                                    },
                                  ));
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        )),
                  ),
                ),
              ),
              Container(
                width: tablet ? wp(4) : wp(6),
                padding:
                    EdgeInsets.symmetric(vertical: tablet ? hp(1.5) : hp(.5)),
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Container(
                    height: isIOS ? hp(74) : hp(85),
                    child: StreamBuilder<Object>(
                        stream: _indexKey,
                        builder: (context, snapshot) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: _buildAbc(snapshot.data),
                          );
                        }),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
