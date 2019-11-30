import 'dart:io';

import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/currentcompanys_dao.dart';
import 'package:epaisa_pos/data/models/currentstores_dao.dart';
import 'package:epaisa_pos/src/logic/my_account_bloc/my_account_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_new_business/add_business_screen.dart';
import 'package:epaisa_pos/src/views/add_new_business/widgets/add_new_business_widget.dart';
import 'package:epaisa_pos/src/views/add_new_stores/add_stores_screen.dart';
import 'package:epaisa_pos/src/views/business_details/business_details_screen.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/views/store_details/stores_details_screen.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/header_card/header_widget.dart';
import 'package:epaisa_pos/src/views/employee/widgets/row_structure.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:flutter/material.dart';

class BusinessWidget extends StatefulWidget {
  Function changeCompany;
  Function changeStore;
  BusinessWidget({this.changeCompany, this.changeStore});

  @override
  _BusinessWidgetState createState() => _BusinessWidgetState();
}

class _BusinessWidgetState extends State<BusinessWidget> {
  CurrentCompanysDao companyDao;
  CurrentStoresDao storesDao;
  @override
  void initState() {
    companyDao = new CurrentCompanysDao(db);
    storesDao = new CurrentStoresDao(db);
    super.initState();
  }

  Future getData() async {
    var list = await companyDao.getAll();
    return list;
  }

  Future getStores(String companyId) async {
    var list = await storesDao.getByCompany(companyId);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    double fontSize = tablet ? hp(2.8) : hp(2.00);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.45 : width * 0.85;
    var layoutHeight = tablet ? height : height * 0.8;
    bool isIOS = Platform.isIOS;
    Widget buildBusinessCard(
        {String title,
        String iconPath = "",
        Widget screenName,
        Function onTap,
        Color cardColor,
        Color textColor,
        Color arrowColor,
        String urlImage}) {
      return Container(
          padding: EdgeInsets.only(
              top: tablet ? wp(1) : wp(3),
              left: tablet ? wp(0) : wp(2),
              right: tablet ? wp(0) : wp(2)),
          child: CardItem(
            onTap: onTap ??
                () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => screenName));
                },
            fontSize: tablet ? hp(2.1) : wp(4),
            cardColor: cardColor,
            verticalTabletCard: tablet ? hp(0.07) : hp(0),
            textColor: textColor,
            showForwardArrow: tablet ? false : true,
            arrowColor: arrowColor ?? AppColors.SettingArrow,
            icon: urlImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                        tablet ? hp(7) : isIOS ? hp(5.7) : hp(6)),
                    child: urlImage.indexOf("files") != -1 ||
                            urlImage.indexOf("Application") != -1
                        ? Image.file(
                            File(urlImage.substring(7, urlImage.length - 1)),
                            height: tablet ? hp(7) : isIOS ? hp(5.7) : hp(6),
                            width: tablet ? hp(7) : isIOS ? hp(5.7) : hp(6),
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            urlImage,
                            height: tablet ? hp(7) : isIOS ? hp(5.7) : hp(6),
                            width: tablet ? hp(7) : isIOS ? hp(5.7) : hp(6),
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ))
                : iconPath != ""
                    ? Image.asset(
                        iconPath,
                        height: tablet ? hp(7) : isIOS ? hp(5.7) : hp(6),
                        width: tablet ? hp(7) : isIOS ? hp(5.7) : hp(6),
                        fit: BoxFit.fill,
                      )
                    : Container(
                        height: tablet ? hp(7) : isIOS ? hp(5.7) : hp(6),
                        width: tablet ? hp(7) : isIOS ? hp(5.7) : hp(6),
                        decoration: BoxDecoration(
                            color: Colors.grey, shape: BoxShape.circle),
                      ),
            title: title,
          ));
    }

    Widget buildStore() {
      return Padding(
        padding: EdgeInsets.only(top: wp(1), bottom: wp(0)),
        child: Text(
          "Stores",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: tablet ? hp(1.9) : wp(4),
            color: AppColors.DarkGray,
          ),
        ),
      );
    }

    Widget buildStoresCard(
        {CurrentStore store,
        String iconPath,
        Widget screenName,
        Function onTap,
        Color cardColor,
        Color textColor,
        Color arrowColor}) {
      return Container(
          padding: EdgeInsets.only(
              top: tablet ? hp(1) : wp(2),
              left: tablet ? hp(0) : wp(2),
              right: tablet ? hp(0) : wp(2)),
          child: CardItem(
            businessCard: true,
            onTap: onTap ??
                () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => screenName));
                },
            fontSize: tablet ? hp(1.9) : wp(3.8),
            cardColor: cardColor,
            verticalTabletCard: 0.6,
            verticalMobileCard: 1,
            textColor: textColor,
            showForwardArrow: tablet ? false : true,
            arrowColor: arrowColor ?? AppColors.SettingArrow,
            icon: Image.asset(
              iconPath,
              height: tablet ? hp(4.5) : wp(9),
            ),
            title: store.name,
          ));
    }

    Widget buildBusinessAndStores({CurrentCompany company}) {
      List<String> storeList = ["Bandra West", "Borivali West", "Dadar East"];

      Widget buildDivider() {
        return Container(
            height: tablet ? hp(0.2) : wp(0.6), color: AppColors.LightGray);
      }

      return Container(
        child: Column(
          children: <Widget>[
            buildBusinessCard(
                title: company.name,
                //iconPath: "assets/my_account/Cafe.png",
                urlImage: company.image,
                //screenName: BusinessDetailsScreen(),
                onTap: () {
                  if (tablet) {
                    widget.changeCompany(company);
                    myAccountBloc.selectedMyAccountOptionSink
                        .add("BusinessDetailsScreen");
                  } else {
                    print("hola");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNewBusinessScreen(
                                  company: company,
                                )));
                  }
                }),
            buildStore(),
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.hasData == false ||
                    snapshot.data.length == null ||
                    snapshot.data == null) {
                  //print('project snapshot data is: ${projectSnap.data}');
                  return Container();
                } else {
                  return Column(
                      children: List.generate(snapshot.data.length, (index) {
                    return buildStoresCard(
                        store: snapshot.data[index],
                        iconPath: "assets/my_account/Store.png",
                        screenName: NewStoresScreen(
                          store: snapshot.data[index],
                        ),
                        onTap: () {
                          if (tablet) {
                            widget.changeStore(snapshot.data[index]);
                            myAccountBloc.selectedMyAccountOptionSink
                                .add("StoreDetailsScreen");
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewStoresScreen(
                                          store: snapshot.data[index],
                                        )));
                          }
                        });
                  }));
                }
              },
              future: getStores(company.id),
            ),
            SizedBox(
              height: tablet ? hp(2) : wp(3),
            ),
            buildDivider(),
          ],
        ),
      );
    }

    Widget addNewBusinessAndStoreButtons() {
      return Container(
        padding: EdgeInsets.only(
            top: hp(3), bottom: hp(0), right: hp(2.5), left: hp(2.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ButtonGradiant(
              hp(1.85),
              wp(28),
              'ADD NEW BUSINESS',
              textStyle: TextStyle(
                  fontSize: tablet ? layoutHeight * 0.02 : layoutHeight * 0.025,
                  color: AppColors.PrimaryWhite,
                  fontWeight: FontWeight.w600),
              onPressed: () {
                myAccountBloc.selectedMyAccountOptionSink.add("AddNewBusiness");
                print("Add new Business");
                //Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewBusinessWidget()));
              },
            ),
            SizedBox(width: wp(1.5)),
            ButtonGradiant(
              hp(1.85),
              wp(28),
              'ADD NEW STORE',
              textStyle: TextStyle(
                  fontSize: tablet ? layoutHeight * 0.02 : layoutHeight * 0.025,
                  color: AppColors.PrimaryWhite,
                  fontWeight: FontWeight.w600),
              onPressed: () {
                myAccountBloc.selectedMyAccountOptionSink.add("AddNewStore");
              },
            ),
          ],
        ),
      );
    }

    Widget buildBusiness() {
      return Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              tablet ? addNewBusinessAndStoreButtons() : SizedBox(),
              FutureBuilder(
                builder: (context, companySnap) {
                  if (companySnap.connectionState == ConnectionState.none ||
                      companySnap.hasData == false ||
                      companySnap.data.length == null ||
                      companySnap.data == null) {
                    //print('project snapshot data is: ${projectSnap.data}');
                    return Container();
                  } else {
                    return Column(
                        children:
                            List.generate(companySnap.data.length, (index) {
                      return buildBusinessAndStores(
                          company: companySnap.data[index]);
                    }));
                  }
                },
                future: getData(),
              ),
            ],
          ),
        ),
      );
    }

    return buildBusiness();
  }
}
