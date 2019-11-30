import 'dart:async';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/customers/customers_info/customer_info.dart';
import 'package:epaisa_pos/src/views/customers/widgets/add_customer_dialog.dart';
import 'package:epaisa_pos/src/views/customers/widgets/distributor_item.dart';
import 'package:epaisa_pos/src/views/employee/employee_screen.dart';
import 'package:epaisa_pos/src/views/employee/widgets/add_employee.dart';
import 'package:epaisa_pos/src/views/employee/widgets/employee_item.dart';
import 'package:epaisa_pos/src/views/screen_with_side/screen_with_side.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/textfields/search_field_box.dart';
import 'package:epaisa_pos/src/widgets/utils/rect_getter.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';

import 'package:sticky_headers/sticky_headers/widget.dart';

class EmployeesList extends StatefulWidget {
  EmployeesList({this.action});
  final Function action;
  @override
  _EmployeesListState createState() => _EmployeesListState();
}

class ObjList {
  List<String> list = new List<String>();
  String key;
  ObjList({this.list, this.key});
}
Widget AddNewEmployee(widget) {
  return Container(
    margin: EdgeInsets.only(top: hp(1.5)),
    child: ButtonGradiant(
      hp(2.3),
      wp(50),
      'ADD A NEW EMPLOYEE',
      textStyle: TextStyle(
          fontSize: tablet ? hp(2) : wp(2),
          color: AppColors.PrimaryWhite,
          fontWeight: FontWeight.w600),
      onPressed: () {
        widget.action(true);
      },
    ),
  );
}
class _EmployeesListState extends State<EmployeesList> {
  List<ObjList> dist = new List<ObjList>();
  List<double> listOffset = new List<double>();
  List<ObjList> filteredList = new List<ObjList>();
  bool searchMode = false;
  BehaviorSubject<int> _indexKey = BehaviorSubject<int>();
  var _ctl = new ScrollController();
  Timer _debounce;
  String str;
  @override
  void initState() {
    dist.add(ObjList(key: "A", list: ["Aldo", "Ariel"]));
    dist.add(ObjList(key: "B", list: ["Carlos", "Cesar"]));
    dist.add(ObjList(key: "C", list: ["Oscar"]));
    dist.add(ObjList(key: "D", list: ["Cesar"]));
    dist.add(ObjList(key: "E", list: ["Chupetin"]));
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
    str = "";
    for (var i = 0; i < dist.length; i++) {
      if (i == 0)
        listOffset.add(0);
      else {
        listOffset.add(
            listOffset[i - 1] + dist[i - 1].list.length * hp(9.2) + hp(5.85));
      }
    }
    filteredList = clone(dist);

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
              paddingHorizontal: tablet ? wp(2) : wp(5),
              fontSize: tablet ? wp(1.6) : hp(2.6),
            ),
          ),
          tablet ?
          AddNewEmployee(widget) : Container(),
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
                    child: ListView.builder(
                      controller: _ctl,
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        _keys[index] = RectGetter.createGlobalKey();
                        return RectGetter(
                          key: _keys[index],
                          child: StickyHeader(
                              header: filteredList[index] != null &&
                                      filteredList[index].list.isNotEmpty
                                  ? Container(
                                      height: hp(5.2),
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
                                  if (tablet) {
                                    widget.action(false);
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EmployeeScreen()));
                                  }
                                },
                                child: EmployeeItem(
                                    list: filteredList[index].list),
                              )),
                        );
                      },
                    ),
                  ),
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
        appBar: tablet
            ? null
            : EpaisaAppBar(
                title: "EMPLOYEES",
                back: true,
                trailing: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddEmployee()));
                      //_showDialog();
                    },
                    child: Image.asset(
                      "assets/customers/add_customer.png",
                      height: hp(3.1),
                      width: hp(3.1),
                    ),
                  ),
                ],
              ),
        body: _buildContent());
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
