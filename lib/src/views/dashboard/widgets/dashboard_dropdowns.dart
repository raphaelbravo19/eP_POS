import 'dart:convert';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/currentcompanys_dao.dart';
import 'package:epaisa_pos/data/models/currentstores_dao.dart';
import 'package:epaisa_pos/src/networking/networking.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:rxdart/rxdart.dart';

class DashboardDropdowns extends StatefulWidget {
  final double width;
  final bool isTablet;
  BehaviorSubject<int> streamCompany;
  BehaviorSubject<String> streamCompanyId;
  DashboardDropdowns({
    @required this.width,
    this.streamCompany,
    this.streamCompanyId,
    this.isTablet = false,
  });

  @override
  _DashboardDropdownsState createState() => _DashboardDropdownsState();
}

class _DashboardDropdownsState extends State<DashboardDropdowns> {
  CurrentCompanysDao companyDao = new CurrentCompanysDao(db);
  CurrentStoresDao storesDao = new CurrentStoresDao(db);

  Future<List<dynamic>> getCompanies() async {
    var list = await companyDao.getAll();
    return list.map((item) => {"name": item.name, "value": item.id}).toList();
  }

  Future<List<dynamic>> getStores() async {
    var list = await storesDao.getAll();
    return list
        .map((item) =>
            {"name": item.name, "value": item.id, "companyId": item.companyId})
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    var tablet = isTablet(MediaQuery.of(context));
    return Container(
      width: widget.width,
      margin: EdgeInsets.only(bottom: hp(1)),
      // decoration: BoxDecoration(color: Colors.green),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              width: widget.width / 2.1,
              child: FutureBuilder<List<dynamic>>(
                builder: (context, companySnap) {
                  if (companySnap.hasData) {
                    if (widget.streamCompany.value == null) {
                      widget.streamCompany.sink.add(0);
                    }
                    if (widget.streamCompanyId.value == null) {
                      widget.streamCompanyId.sink
                          .add(companySnap.data[0]["value"]);
                    }
                    return TextfieldDropdown(
                        items: companySnap.data,
                        paddingBottomInput: hp(0.8),
                        fontSize: tablet ? hp(2.8) : wp(4),
                        scaleDropdown: 1.5,
                        alwaysBlue: true,
                        showBlueDropdownColor: true,
                        labelText: "Company",
                        onChanged: (str) {
                          widget.streamCompanyId.sink.add(str);
                        },
                        onChangeIndex: (index) {
                          widget.streamCompany.sink.add(index);
                        });
                  } else {
                    return TextfieldDropdown(
                      items: [
                        {"name": "Item Example", "value": "0"}
                      ],
                      paddingBottomInput: hp(0.8),
                      fontSize: tablet ? hp(2.8) : wp(4),
                      alwaysBlue: true,
                      scaleDropdown: 1.5,
                      showBlueDropdownColor: true,
                      labelText: "Company",
                    );
                  }
                },
                future: getCompanies(),
              )),
          Container(
            width: widget.width / 2.1,
            child: FutureBuilder<List<dynamic>>(
              builder: (context, companySnap) {
                if (companySnap.hasData) {
                  return StreamBuilder(
                      stream: widget.streamCompanyId,
                      builder: (context, snap) {
                        if (snap.data != null) {
                          print(companySnap.data
                              .where((x) => x["companyId"] == snap.data)
                              .toList());
                          return TextfieldDropdown(
                            items: companySnap.data
                                .where((x) => x["companyId"] == snap.data)
                                .toList(),
                            paddingBottomInput: hp(0.8),
                            fontSize: tablet ? hp(2.8) : wp(4),
                            scaleDropdown: 1.5,
                            alwaysBlue: true,
                            showBlueDropdownColor: true,
                            labelText: "Store",
                            resetOnUpdate: true,
                          );
                        } else {
                          return TextfieldDropdown(
                            items: [
                              {"name": "Item Example", "value": "0"}
                            ],
                            paddingBottomInput: hp(0.8),
                            fontSize: tablet ? hp(2.8) : wp(4),
                            alwaysBlue: true,
                            scaleDropdown: 1.5,
                            showBlueDropdownColor: true,
                            labelText: "Store",
                          );
                        }
                      });
                } else {
                  return TextfieldDropdown(
                    items: [
                      {"name": "Item Example", "value": "0"}
                    ],
                    paddingBottomInput: hp(0.8),
                    fontSize: tablet ? hp(2.8) : wp(4),
                    alwaysBlue: true,
                    scaleDropdown: 1.5,
                    showBlueDropdownColor: true,
                    labelText: "Store",
                  );
                }
                //print('project snapshot data is: ${projectSnap.data}');
              },
              future: getStores(),
            ),
          )
        ],
      ),
    );
  }
}
