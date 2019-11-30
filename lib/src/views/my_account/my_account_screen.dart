import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/src/logic/my_account_bloc/my_account_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_new_business/add_business_screen.dart';
import 'package:epaisa_pos/src/views/add_new_business/widgets/add_new_business_widget.dart';
import 'package:epaisa_pos/src/views/add_new_stores/widgets/add_stores_widget.dart';
import 'package:epaisa_pos/src/views/business/business_screen.dart';
import 'package:epaisa_pos/src/views/business/widgets/business_widgets.dart';
import 'package:epaisa_pos/src/views/business_details/widgets/business_details_widget.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/views/login/widgets/background_image.dart';
import 'package:epaisa_pos/src/views/my_account/widgets/my_account_widget.dart';
import 'package:epaisa_pos/src/views/notification_my_account/notifications_screen.dart';
import 'package:epaisa_pos/src/views/notification_my_account/widgets/notification_widgets.dart';
import 'package:epaisa_pos/src/views/password/password_screen.dart';
import 'package:epaisa_pos/src/views/password/widgets/password_widgets.dart';
import 'package:epaisa_pos/src/views/personal/personal_screen.dart';
import 'package:epaisa_pos/src/views/personal/widgets/personal_widget.dart';
import 'package:epaisa_pos/src/views/reports/reports_screen.dart';
import 'package:epaisa_pos/src/views/reports/widgets/reports_widgets.dart';
import 'package:epaisa_pos/src/views/screen_with_side/screen_with_side.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/store_details/widgets/stores_details_widget.dart';
import 'package:flutter/material.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  CurrentCompany cc;
  CurrentStore cs;
  GlobalKey<AddNewBusinessWidgetState> newbusikey =
      GlobalKey<AddNewBusinessWidgetState>();
  GlobalKey<AddNewBusinessWidgetState> busikey =
      GlobalKey<AddNewBusinessWidgetState>();
  GlobalKey<AddStoreWidgetState> newstorekey = GlobalKey<AddStoreWidgetState>();
  GlobalKey<StoreDetailsWidgetState> storekey =
      GlobalKey<StoreDetailsWidgetState>();
  @override
  Widget build(BuildContext context) {
    myAccountBloc.selectedMyAccountOptionStream.listen((data) {
      print("Data screen: $data");
    });

    final bool tablet = isTablet(MediaQuery.of(context));
    return buildEpaisaScaffold(context, tablet);
  }

  EpaisaScaffold buildEpaisaScaffold(BuildContext context, bool tablet) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    //final myAccountBloc = MyAccountBloc();

    Widget card(
        {String title,
        String iconPath,
        Widget screenName,
        Function onTap,
        Color cardColor,
        Color textColor,
        Color arrowColor}) {
      return Container(
          padding: EdgeInsets.only(
              top: tablet ? wp(1) : wp(3),
              left: tablet ? wp(0) : wp(2),
              right: tablet ? wp(0) : wp(2)),
          child: CardItem(
            onTap: () {
              if (myAccountBloc.selectedMyAccountOption.value ==
                  "AddNewBusiness") {
                newbusikey.currentState.showConfirm(
                    callback: onTap ??
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => screenName)));
              } else if (myAccountBloc.selectedMyAccountOption.value ==
                  "BusinessDetailsScreen") {
                busikey.currentState.showConfirm(
                    callback: onTap ??
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => screenName)));
              } else if (myAccountBloc.selectedMyAccountOption.value ==
                  "StoreDetailsScreen") {
                storekey.currentState.showConfirm(
                    callback: onTap ??
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => screenName)));
              } else if (myAccountBloc.selectedMyAccountOption.value ==
                  "AddNewStore") {
                newstorekey.currentState.showConfirm(
                    callback: onTap ??
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => screenName)));
              } else {
                if (onTap != null) {
                  onTap();
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => screenName));
                }
              }
            },
            fontSize: tablet ? hp(2.3) : wp(4.2),
            cardColor: cardColor,
            verticalTabletCard: 1,
            textColor: textColor,
            arrowColor: arrowColor ?? AppColors.SettingArrow,
            icon: Image.asset(
              iconPath,
              height: hp(6.4),
            ),
            title: title,
          ));
    }

    Widget myAccountOptionList() {
      return StreamBuilder<String>(
          stream: myAccountBloc.selectedMyAccountOptionStream,
          builder: (context, snapshotSettingName) {
            bool isBusiness = snapshotSettingName.data == "Business" ||
                snapshotSettingName.data == "AddNewStore" ||
                snapshotSettingName.data == "BusinessDetailsScreen" ||
                snapshotSettingName.data == "StoreDetailsScreen" ||
                snapshotSettingName.data == "AddNewBusiness";

            return Container(
              height: MediaQuery.of(context).size.height,
              decoration: BackgroundImage.buildBackgroundImageWhite(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    children: <Widget>[
                      card(
                          title: "Personal",
                          iconPath: "assets/my_account/Personal.png",
                          cardColor: snapshotSettingName.data == "Personal"
                              ? AppColors.IconDarkGray
                              : null,
                          textColor: snapshotSettingName.data == "Personal"
                              ? AppColors.PrimaryWhite
                              : null,
                          arrowColor: snapshotSettingName.data == "Personal"
                              ? AppColors.PrimaryWhite
                              : null,
                          onTap: () {
                            tablet
                                ? myAccountBloc.selectedMyAccountOptionSink
                                    .add("Personal")
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PersonalScreen()));
                          }),
                      card(
                          title: "Business",
                          iconPath: "assets/my_account/Business.png",
                          cardColor: isBusiness ? AppColors.IconDarkGray : null,
                          textColor: isBusiness ? AppColors.PrimaryWhite : null,
                          arrowColor:
                              isBusiness ? AppColors.PrimaryWhite : null,
                          onTap: () {
                            tablet
                                ? myAccountBloc.selectedMyAccountOptionSink
                                    .add("Business")
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BusinessScreen()));
                          }),
                      card(
                          title: "Notifications",
                          iconPath: "assets/my_account/Notifications.png",
                          cardColor: snapshotSettingName.data == "Notifications"
                              ? AppColors.IconDarkGray
                              : null,
                          textColor: snapshotSettingName.data == "Notifications"
                              ? AppColors.PrimaryWhite
                              : null,
                          arrowColor:
                              snapshotSettingName.data == "Notifications"
                                  ? AppColors.PrimaryWhite
                                  : null,
                          onTap: () {
                            tablet
                                ? myAccountBloc.selectedMyAccountOptionSink
                                    .add("Notifications")
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NotificationsScreen()));
                          }),
                      card(
                          title: "Reports",
                          iconPath: "assets/my_account/Reports.png",
                          cardColor: snapshotSettingName.data == "Reports"
                              ? AppColors.IconDarkGray
                              : null,
                          textColor: snapshotSettingName.data == "Reports"
                              ? AppColors.PrimaryWhite
                              : null,
                          arrowColor: snapshotSettingName.data == "Reports"
                              ? AppColors.PrimaryWhite
                              : null,
                          onTap: () {
                            tablet
                                ? myAccountBloc.selectedMyAccountOptionSink
                                    .add("Reports")
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReportsScreen()));
                          }),
                      card(
                          title: "Password",
                          iconPath: "assets/my_account/Password.png",
                          cardColor: snapshotSettingName.data == "Password"
                              ? AppColors.IconDarkGray
                              : null,
                          textColor: snapshotSettingName.data == "Password"
                              ? AppColors.PrimaryWhite
                              : null,
                          arrowColor: snapshotSettingName.data == "Password"
                              ? AppColors.PrimaryWhite
                              : null,
                          onTap: () {
                            tablet
                                ? myAccountBloc.selectedMyAccountOptionSink
                                    .add("Password")
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PasswordScreen()));
                          }),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    Widget buildNoWidgetSelectedWidget() {
      return Container(
        decoration: BackgroundImage.buildBackgroundImageWhite(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                "assets/settingIcons/NoSettings.png",
                height: hp(25.0),
              ),
              Text(
                "Please select a settings\n from the left",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.IconGray,
                  fontSize: hp(4.0),
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget buildSelectedSettingWidget({String selectedWidget}) {
      String widgetName = selectedWidget;

      switch (widgetName) {
        case 'Personal':
          return PersonalWidget();
        case 'Business':
          return BusinessWidget(changeCompany: (val) {
            print(val);
            setState(() {
              cc = val;
            });
          }, changeStore: (val) {
            print(val);
            setState(() {
              cs = val;
            });
          });
        case 'AddNewBusiness':
          return AddNewBusinessWidget(
            key: newbusikey,
            onBack: () {
              myAccountBloc.selectedMyAccountOptionSink.add("Business");
            },
          );
        case 'AddNewStore':
          return AddStoreWidget(
            key: newstorekey,
            onBack: () {
              myAccountBloc.selectedMyAccountOptionSink.add("Business");
            },
          );
        case 'BusinessDetailsScreen':
          return cc.name != null
              ? AddNewBusinessWidget(
                  key: busikey,
                  company: cc,
                  onBack: () {
                    myAccountBloc.selectedMyAccountOptionSink.add("Business");
                  },
                )
              : Container();
        case 'StoreDetailsScreen':
          return cs.name != null
              ? StoreDetailsWidget(
                  key: storekey,
                  store: cs,
                  onBack: () {
                    myAccountBloc.selectedMyAccountOptionSink.add("Business");
                  },
                )
              : Container();
        case 'Reports':
          return ReportsWidget();
        case 'Notifications':
          return NotificationsWidget();
        case 'Password':
          return PasswordWidget();
        default:
          return buildNoWidgetSelectedWidget();
          break;
      }
    }

    return EpaisaScaffold(
        appBar: EpaisaAppBar(
            openDrawer: () {
              Scaffold.of(context).openDrawer();
            },
            menu: true,
            title: 'MY ACCOUNT',
            searchIcon: true,
            searchTitle: "my account"),
        body: StreamBuilder(
          stream: myAccountBloc.selectedMyAccountOptionStream,
          builder: (context, snapshotSettingName) {
            print("Setting Name: ${snapshotSettingName.data}");
            return tablet
                ? ScreenWithSide(
                    side: myAccountOptionList(),
                    body: Container(
                      child: buildSelectedSettingWidget(
                          selectedWidget: snapshotSettingName.data),
                    ))
                : myAccountOptionList();
          },
        ));
  }
}
