import 'package:epaisa_pos/src/utility/code_scanner.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/countries.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/packages/widgets/package_item.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list_pin.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/horizontal_list.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_qrscanner.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_with_header.dart';
import 'package:epaisa_pos/src/widgets/textfields/search_field.dart';
import 'package:flutter/material.dart';

class ExchangeItems extends StatefulWidget {
  @override
  _ExchangeItemsState createState() => _ExchangeItemsState();
}

class _ExchangeItemsState extends State<ExchangeItems> {
  var _selectedView = 0;
  var _showCounter = false;
  GlobalKey<DialogWithHeaderState> _modal = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final bool tablet = isTablet(MediaQuery.of(context));

    Widget _searchContainer() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: tablet ? wp(1) : wp(2.5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SearchField(
                hintText:
                    "${eptxt('search')} ${eptxt('categories')} | ${eptxt('products')} | ${eptxt('packages')}",
                paddingVertical: hp(1.7),
                paddingHorizontal: tablet ? wp(1.5) : wp(3),
                fontSize: tablet ? wp(1.6) : hp(1.9),
              ),
            ),
            SizedBox(
              width: tablet ? wp(2) : wp(2),
            ),
            Container(
              alignment: Alignment.center,
              //color: Colors.red,
              height: tablet ? hp(3.4) + wp(1.8) : hp(5.6),
              width: tablet ? hp(3.4) + wp(1.8) : hp(5.6),
              child: ButtonQRScanner(
                onTap: () {
                  CodeScanner.scan(
                    onSuccess: (code) {
                      ScreenUtils(MediaQuery.of(context).size)
                          .showCustomDialog(code, context);
                    },
                    onError: (e) => print(e),
                    onBackButton: (e) => print(e),
                  );
                },
                borderRadius: hp(0.85),
              ),
            ),
          ],
        ),
      );
    }

    List<Map<String, dynamic>> lw = List.generate(abc.length, (index) {
      return {
        "text": "${abc[index]}adbury Bourn Vita & Lays Sour cream and on lasdd",
        "price": 25.0,
        "cant": 12,
        "color": AppColors.PrimaryBlue
      };
    });
    void _showDialog(String message) {
      // flutter defined function

      Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          var selected = 0;
          return DialogWithHeader(
            key: _modal,
            message: message,
            width: tablet ? wp(66) : wp(95),
            marginContent: tablet ? wp(1) : wp(3),
            height: tablet ? hp(69) : hp(60),
            content: GridList(
                children: lw,
                totalWidth: tablet ? wp(60) : wp(88),
                marginH: tablet ? hp(0.2) : wp(1),
                gridLength: tablet ? 4 : 3,
                height: tablet ? hp(19) : wp(22),
                onTapGeneral: (_sel) {
                  _modal.currentState.changeTitle("Categories");
                  _modal.currentState.changeContent(
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          HorizontalLists(
                            lw: lw,
                            selected: _sel,
                          ),
                          GridList(
                              children: lw,
                              totalWidth: tablet ? wp(60) : wp(88),
                              marginH: tablet ? hp(0.2) : wp(1),
                              gridLength: tablet ? 4 : 3,
                              height: tablet ? hp(19) : wp(22),
                              onTapGeneral: (_select) {
                                print(_select);
                                _modal.currentState.closeModal();
                              })
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
      ));
    }

    Widget _buildTabs() {
      var first = _selectedView == 0;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: tablet ? wp(1) : wp(2.5)),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedView = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: first
                                      ? tablet ? 1 : 0.6
                                      : tablet ? 2 : 1.1,
                                  color: AppColors.DisabledText.withOpacity(
                                      first ? 0.2 : 0.3)),
                              borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(hp(tablet ? 1.2 : 0.8)),
                                  topLeft:
                                      Radius.circular(hp(tablet ? 1.2 : 0.8)))),
                          padding: EdgeInsets.symmetric(
                              vertical: first ? hp(1.15) : hp(1)),
                          child: Opacity(
                              opacity: first ? 0.8 : 0.3,
                              child: Image.asset(
                                "assets/payments/grid.png",
                                height: tablet ? hp(3.5) : hp(3.5),
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedView = 1;
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: !first
                                        ? tablet ? 2 : 1.1
                                        : tablet ? 1 : 0.6,
                                    color: AppColors.DisabledText.withOpacity(
                                        !first ? 0.2 : 0.3)),
                                borderRadius: BorderRadius.only(
                                    bottomRight:
                                        Radius.circular(hp(tablet ? 1.2 : 0.8)),
                                    topRight: Radius.circular(
                                        hp(tablet ? 1.1 : 0.8)))),
                            padding: EdgeInsets.symmetric(
                                vertical: !first ? hp(1.15) : hp(1)),
                            child: Opacity(
                                opacity: !first ? 0.8 : 0.3,
                                child: Image.asset(
                                  "assets/payments/list.png",
                                  height: tablet ? hp(3.5) : hp(3.5),
                                ))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: wp(1),
            ),
            Expanded(
              flex: tablet ? 2 : 1,
              child: GestureDetector(
                onTap: () {
                  _showDialog("Categories");
                },
                child: Container(
                  height: hp(5.6),
                  padding: EdgeInsets.symmetric(vertical: hp(0.5)),
                  decoration: BoxDecoration(
                    color: AppColors.PrimaryWhite,
                    borderRadius: BorderRadius.circular(hp(tablet ? 1 : 0.7)),
                    boxShadow: [
                      new BoxShadow(
                          color: AppColors.DarkGray.withOpacity(
                              tablet ? 0.8 : 0.6),
                          offset: new Offset(0.6, 1.3),
                          blurRadius: 1.0)
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "CATEGORIES",
                    style: TextStyle(
                        fontSize: tablet ? hp(2) : wp(3.5),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: hp(1)),
      child: Column(
        children: <Widget>[
          _searchContainer(),
          Container(
            padding: EdgeInsets.symmetric(vertical: hp(1)),
            child: _buildTabs(),
          ),
          GridListPin(
            itemBuilder: ({String text, color, onTap, int index}) {
              return PackageItem(
                showCounter: (index == 0 && _showCounter),
                noPackage: true,
                onTap: () {
                  setState(() {
                    _showCounter = true;
                  });
                },
                text: text,
                color: color,
                scale: tablet ? wp(1.3) : hp(1.9),
                price: lw[index]["price"],
                quantity: lw[index]["cant"],
                gridLength: tablet ? 6 : 3,
              );
            },
            children: lw,
            gridLength: 4,
            height: tablet ? hp(20) : hp(18),
            indexState: 0,
            totalWidth: wp(58),
            selected: 0,
            selectedView: 0,
            verticalMargin: hp(1.3),
            onTapFirst: (index) {},
          ),
        ],
      ),
    );
  }
}
