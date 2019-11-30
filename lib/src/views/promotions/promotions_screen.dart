import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list_pin.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/horizontal_list.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/item_category.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/add_promotion_screen.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_with_icon.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_with_header.dart';
import 'package:epaisa_pos/src/widgets/textfields/search_field.dart';
import 'package:flutter/material.dart';

class PromotionsScreen extends StatefulWidget {
  @override
  _PromotionsScreenState createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends State<PromotionsScreen> {
  int indexState = 0;
  int _selected = -1;
  int _selectedView = 0;
  GlobalKey<DialogWithHeaderState> _modal = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // BarcodeScanner.scan().then((onValue) {
    //   print(onValue);
    // }).catchError((onError) {
    //   print(onError);
    // });
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

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

    Widget _searchContainer() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: tablet ? wp(1) : wp(2.5)),
        // color: Colors.red,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SearchField(
                hintText: "${eptxt('search')} ${eptxt('promotions')}",
                paddingVertical: hp(1.7),
                paddingHorizontal: tablet ? wp(1.5) : wp(3),
                fontSize: tablet ? wp(1.6) : hp(1.9),
              ),
            ),
            if (indexState == 1)
              SizedBox(
                width: tablet ? wp(2) : wp(2),
              ),
            if (indexState == 1)
              Container(
                alignment: Alignment.center,
                //color: Colors.red,
                height: tablet ? hp(3.4) + wp(1.8) : hp(5.6),
                width: tablet ? hp(3.4) + wp(1.8) : hp(5.6),
                child: ButtonWithIcon(
                  icon: Icon(Icons.format_align_center),
                  onTap: () {},
                  borderRadius: hp(0.85),
                ),
              ),
          ],
        ),
      );
    }

    List<Map<String, dynamic>> lw = List.generate(abc.length, (index) {
      return {
        "text": "${abc[index]}ruits & Vegetables",
        "color": baseColors[index % 10]
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
            width: wp(95),
            marginContent: wp(3),
            height: hp(60),
            content: GridList(
                children: lw,
                totalWidth: wp(88),
                marginH: wp(1),
                gridLength: 3,
                height: hp(11),
                onTapGeneral: (_sel) {
                  print("Hola");
                  _modal.currentState.changeTitle("Sub Categories");
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
                              totalWidth: wp(88),
                              marginH: wp(1),
                              gridLength: 3,
                              height: hp(11),
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

    Widget _buildContent({bool isTablet = false}) {
      return EpaisaScaffold(
        appBar: EpaisaAppBar(
          openDrawer: () {
            Scaffold.of(context).openDrawer();
          },
          menu: true,
          title: "PROMOTIONS",
          trailing: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPromotionScreen()));
              },
              child: Image.asset(
                "assets/header/plusicon.png",
                height: tablet ? hp(3.5) : hp(2.4),
                width: tablet ? hp(3.5) : hp(2.4),
              ),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: hp(1),
              ),
              _searchContainer(),
              SizedBox(
                height: hp(1),
              ),
              tablet || indexState == 2
                  ? SizedBox(height: hp(0.5))
                  : Container(),
              GridListPin(
                itemBuilder: ({String text, color, onTap, int index}) {
                  return isTablet
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              hp(1),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset.fromDirection(45),
                                blurRadius: 1,
                                spreadRadius: 0.8,
                              )
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 60,
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: hp(5)),
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                        hp(1),
                                      ),
                                    ),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      'SALE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 40,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(
                                        hp(1),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(hp(0.5)),
                                    child: FittedBox(
                                      child: Text(
                                        text.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: hp(1.6),
                                            fontWeight: FontWeight.w500),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : ItemCategory(
                          onTap: onTap,
                          text: text,
                          color: color,
                          scale: tablet ? wp(1.3) : hp(1.9),
                          tablet: tablet,
                        );
                },
                children: lw,
                gridLength: tablet ? 6 : 3,
                height: hp(12),
                selectedView: _selectedView,
                selected: _selected,
                indexState: indexState,
                verticalMargin: hp(1.3),
                totalWidth: wp(90.5),
                onTapFirst: (index) {
                  setState(() {
                    indexState = indexState + 1;
                    _selected = index;
                  });
                },
              ), //_gridList(),
            ],
          ),
        ),
      );
    }

    return _buildContent(isTablet: isTablet(MediaQuery.of(context)));
  }
}
