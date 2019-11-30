import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/attributes_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:epaisa_pos/src/widgets/general/check_icon.dart';
import 'package:flutter/material.dart';

class ProductAttributesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    return buildEpaisaScaffold(context, tablet);
  }

  Widget buildEpaisaScaffold(BuildContext context, bool tablet) {
    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        back: true,
        title: 'PRODUCT ATTRIBUTES',
      ),
      body: ProductAttributesList(),
    );
  }
}

class ProductAttributesList extends StatefulWidget {
  @override
  ProductAttributesListstate createState() => ProductAttributesListstate();
}

class ProductAttributesListstate extends State<ProductAttributesList> {
  List<ProductAttribute> attr;
  ProductAttributesDao dao = new ProductAttributesDao(db);
  @override
  void initState() {
    super.initState();
    getData();
  }

  var loaded = false;
  Future getData() async {
    attr = await dao.getAll();
    attr = attr.where((x) => x.name != "Product").toList();
    setState(() {
      loaded = true;
    });
  }

  List<String> attributes = [
    'Shade',
    'Fabric',
    'Style',
    'Mixture',
    'Size',
    'Usage',
    'Styling',
  ];
  List<String> customAttributes = ['Vendor'];
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    Widget card({String title}) {
      return CardItem(
        fontSize: tablet ? hp(2.3) : wp(4.2),
        borderRadiusValue: 1,
        verticalTabletCard: 1.2,
        verticalMobileCard: 1.5,
        title: title,
        extraPaddingRight: false,
        showForwardArrow: false,
        otherWidget: ButtonToggle(
          //confirmDialog: true,
          size: tablet ? hp(1.6) : wp(2.3),
        ),
      );
    }

    Widget buildDivider() {
      return Container(
        height: 0.4,
        padding: EdgeInsets.all(tablet ? hp(2) : wp(0.1)),
        color: Colors.grey,
      );
    }

    Widget buildDeviceList() {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: hp(2),
            ),
            Text(
              "Default Attributes",
              style: TextStyle(
                color: AppColors.PrimaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: tablet ? hp(2.5) : wp(4.3),
              ),
            ),
            SizedBox(
              height: tablet ? hp(0.6) : hp(.3),
            ),
            Container(
              width: tablet ? wp(35) : wp(89),
              child: FittedBox(
                child: Text(
                  "Choose the attributes you want to add to your product.",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.DarkGray,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: tablet ? hp(1) : hp(1),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.only(left: tablet ? hp(5.5) : wp(5)),
                        child: Text(
                          "Attributes",
                          style: TextStyle(
                            color: AppColors.PrimaryBlue,
                            fontWeight: FontWeight.w800,
                            fontSize: tablet ? hp(2.2) : wp(3.2),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: tablet ? hp(16) : wp(22),
                      child: Text(
                        "Required",
                        style: TextStyle(
                          color: AppColors.PrimaryBlue,
                          fontWeight: FontWeight.w800,
                          fontSize: tablet ? hp(2.2) : wp(3.2),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: hp(1),
                ),
                ...(loaded
                    ? List.generate(attr.length, (index) {
                        return Container(
                          padding: EdgeInsets.only(
                              bottom: tablet ? hp(1) : hp(0.7), left: wp(2)),
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: card(
                                  title: attr[index].name,
                                ),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  width: tablet ? hp(16) : wp(22),
                                  child: CheckIcon(
                                    value: attr[index].isRequired,
                                    size: tablet ? hp(5) : wp(8),
                                  )),
                            ],
                          ),
                        );
                      })
                    : [])
              ],
            ),
            SizedBox(
              height: tablet ? hp(1) : hp(1.5),
            ),
            buildDivider(),
            SizedBox(
              height: tablet ? hp(1) : hp(1.5),
            ),
            Text(
              "Custom Attributes",
              style: TextStyle(
                color: AppColors.PrimaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: tablet ? hp(2.5) : wp(4.3),
              ),
            ),
            SizedBox(
              height: tablet ? hp(0.6) : hp(.3),
            ),
            Container(
              width: tablet ? wp(35) : wp(89),
              child: FittedBox(
                child: Text(
                  "Add upto 5 attributes you want to add to your product.",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.DarkGray,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: tablet ? hp(2) : hp(1.5),
            ),
            ...(List.generate(customAttributes.length, (index) {
              return Container(
                padding: EdgeInsets.only(
                    bottom: tablet ? hp(1) : hp(0.7), left: wp(2)),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: card(
                        title: customAttributes[index],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: tablet ? hp(16) : wp(22),
                        child: CheckIcon(
                          size: tablet ? hp(5) : wp(8),
                        )),
                  ],
                ),
              );
            })),
            SizedBox(
              height: tablet ? hp(1.5) : hp(1.5),
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: tablet ? wp(6.5) : wp(5.2)),
              child: ButtonGradient(
                borderRadius: tablet ? hp(4) : hp(1.9),
                paddingVertical: tablet ? hp(2.4) : hp(2),
                title: "+ ADD NEW ATTRIBUTE",
                fontSize: tablet ? hp(1.8) : wp(3),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: tablet ? hp(5) : hp(3),
            ),
          ],
        ),
      );
    }

    return buildDeviceList();
  }
}
