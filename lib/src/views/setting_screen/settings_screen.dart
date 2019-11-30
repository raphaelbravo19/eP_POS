import 'package:epaisa_pos/src/logic/setting_bloc/setting_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/card_reader/card_reader_screen.dart';
import 'package:epaisa_pos/src/views/card_reader/widgets/card_reader_widget.dart';
import 'package:epaisa_pos/src/views/card_reader/widgets/cash_drawer_widget.dart';
import 'package:epaisa_pos/src/views/cash_drawer/cash_drawer_screen.dart';
import 'package:epaisa_pos/src/views/cash_management/cash_management_screen.dart';
import 'package:epaisa_pos/src/views/cash_management/widgets/cash_management_widget.dart';
import 'package:epaisa_pos/src/views/customize_home/customize_home_screen.dart';
import 'package:epaisa_pos/src/views/customize_home/widgets/customize_home_widget.dart';
import 'package:epaisa_pos/src/views/devices/device_screen.dart';
import 'package:epaisa_pos/src/views/employee/employee_list.dart';
import 'package:epaisa_pos/src/views/employee/widgets/employee_list_widget.dart';
import 'package:epaisa_pos/src/views/hardware/hardware_screen.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/views/login/widgets/background_image.dart';
import 'package:epaisa_pos/src/views/loyalty/loyalty_screen.dart';
import 'package:epaisa_pos/src/views/loyalty/widgets/loyalty_widget.dart';
import 'package:epaisa_pos/src/views/payment_option_settiing/payment_option_screen.dart';
import 'package:epaisa_pos/src/views/payment_option_settiing/wedgits/payment_options_widget.dart';
import 'package:epaisa_pos/src/views/printer/printer_screen.dart';
import 'package:epaisa_pos/src/views/printer/widgets/printer_widget.dart';
import 'package:epaisa_pos/src/views/screen_with_side/screen_with_side.dart';
import 'package:epaisa_pos/src/views/setting_screen/product_attr/product_attr.dart';
import 'package:epaisa_pos/src/views/setting_screen/widgets/device_list_widget.dart';
import 'package:epaisa_pos/src/views/setting_transaction/transection_screen.dart';
import 'package:epaisa_pos/src/views/setting_transaction/widgets/transection_widget.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool hardwareList = false;
  String hardwareType;

  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    return buildEpaisaScaffold(context, tablet);
  }

  EpaisaScaffold buildEpaisaScaffold(BuildContext context, bool tablet) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final settingBloc = SettingBloc();
    List<Map<String, dynamic>> allSettings = [
      {
        "name": "Device",
        "id": "Device",
        "icon": "assets/settingIcons/Device.png",
        "screen": DeviceScreen()
      },
      {
        "name": "Hardware",
        "id": "Hardware",
        "icon": "assets/settingIcons/Hardware.png",
        "screen": HardwareScreen()
      },
      {
        "name": "Employees",
        "id": "Employees",
        "icon": "assets/settingIcons/Employees.png",
        "screen": EmployeesList()
      },
      {
        "name": "Cash Management",
        "id": "CashManagement",
        "icon": "assets/settingIcons/CashManagement.png",
        "screen": CashManagementScreen()
      },
      {
        "name": "Payment Options",
        "id": "PaymentOption",
        "icon": "assets/settingIcons/PaymentOption.png",
        "screen": PaymentOptionScreen()
      },
      {
        "name": "Loyalty",
        "id": "Loyality",
        "icon": "assets/settingIcons/Loyality.png",
        "screen": LoyaltyScreen()
      },
      {
        "name": "Transactions",
        "id": "Transaction",
        "icon": "assets/settingIcons/Transaction.png",
        "screen": TransactionScreen()
      },
      {
        "name": "Customize Home Screen",
        "id": "Customize",
        "icon": "assets/settingIcons/Customize.png",
        "screen": CustomizeHomeScreen()
      },
      {
        "name": "Product Attributes",
        "id": "ProductAttributes",
        "icon": "assets/settingIcons/Customize.png",
        "screen": ProductAttributesScreen()
      },
      {
        "name": "Printers",
        "id": "Printer",
        "icon": "assets/hardware/Printer.png",
        "screen": PrinterScreen()
      },
      {
        "name": "Card Reader",
        "id": "CardReader",
        "icon": "assets/hardware/CardReader.png",
        "screen": CardReaderScreen()
      },
      {
        "name": "Cash Drawers",
        "id": "CashDrawer",
        "icon": "assets/hardware/CashDrawer.png",
        "screen": CashDrawerScreen()
      },
      {
        "name": "Enable Fingerprint",
        "icon": "assets/devices/Fingerprint.png",
        "type": "toggle"
      },
      {
        "name": "Enable Sound",
        "icon": "assets/devices/Sound.png",
        "type": "toggle"
      },
      {
        "name": "Enable Camera",
        "icon": "assets/devices/Camera.png",
        "type": "toggle"
      },
      {"name": "Enable Offline Transactions", "icon": null, "type": "toggle"},
      {"name": "Enable Round-off", "icon": null, "type": "toggle"},
      {"name": "Send OTP on Refund", "icon": null, "type": "toggle"},
    ];
    Widget card(
        {String title,
        String iconPath,
        Widget screenName,
        Function onTap,
        bool showArrow = true,
        Color cardColor,
        Color textColor,
        Color arrowColor}) {
      return Container(
          padding: EdgeInsets.only(
              top: tablet ? hp(1) : wp(3),
              left: tablet ? hp(0) : wp(2),
              right: tablet ? hp(0) : wp(2)),
          child: CardItem(
            onTap: onTap ??
                () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => screenName));
                },
            fontSize: tablet ? hp(2.3) : wp(4.2),
            cardColor: cardColor,
            showForwardArrow: showArrow,
            verticalTabletCard: 1,
            verticalMobileCard: 1.35,
            textColor: textColor,
            arrowColor: arrowColor ?? AppColors.SettingArrow,
            icon: Image.asset(
              iconPath,
              height: tablet ? hp(6.4) : wp(12),
            ),
            title: title,
          ));
    }

    Widget settingsList() {
      return StreamBuilder<String>(
          stream: settingBloc.selectedSettingNameStream,
          builder: (context, snapshotSettingName) {
            return StreamBuilder<String>(
                stream: settingBloc.filterSettingQueryStream,
                builder: (context, snapshot) {
                  var queryString = snapshot.data;
                  if (queryString != '' && queryString != null) {
                    var listFiltered = allSettings
                        .where((f) => f["name"]
                            .toUpperCase()
                            .contains(queryString.toUpperCase()))
                        .toList();
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BackgroundImage.buildBackgroundImageWhite(),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: Column(
                            children:
                                List.generate(listFiltered.length, (index) {
                              if (listFiltered[index]["type"] == 'toggle') {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: tablet ? hp(1) : wp(0),
                                      right: tablet ? hp(1) : wp(0)),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: tablet ? hp(1) : wp(3),
                                        left: tablet ? hp(0) : wp(2),
                                        right: tablet ? hp(0) : wp(2)),
                                    child: CardItem(
                                      fontSize: tablet ? hp(2.3) : wp(4.2),
                                      borderRadiusValue: 1,
                                      verticalTabletCard: 1.35,
                                      verticalMobileCard: 1.35,
                                      icon: listFiltered[index]["icon"] != null
                                          ? Image.asset(
                                              listFiltered[index]["icon"],
                                              height: tablet ? hp(6.4) : wp(12),
                                            )
                                          : null,
                                      title: listFiltered[index]["name"],
                                      showForwardArrow: false,
                                      otherWidget: ButtonToggle(
                                        confirmDialog: true,
                                        size: tablet ? hp(1.6) : wp(2.9),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return card(
                                title: listFiltered[index]["name"],
                                iconPath: listFiltered[index]["icon"],
                                cardColor: snapshotSettingName.data ==
                                        "${listFiltered[index]["id"]}"
                                    ? AppColors.IconDarkGray
                                    : null,
                                textColor: snapshotSettingName.data ==
                                        "${listFiltered[index]["id"]}"
                                    ? AppColors.PrimaryWhite
                                    : null,
                                arrowColor: snapshotSettingName.data ==
                                        "${listFiltered[index]["id"]}"
                                    ? AppColors.PrimaryWhite
                                    : null,
                                onTap: () {
                                  tablet
                                      ? settingBloc.selectedSettingNameSink
                                          .add("${listFiltered[index]["id"]}")
                                      : Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                          return listFiltered[index]["screen"];
                                        }));
                                },
                              );
                            }),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BackgroundImage.buildBackgroundImageWhite(),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Column(
                            children: <Widget>[
                              card(
                                title: eptxt('settings_device'),
                                iconPath: "assets/settingIcons/Device.png",
                                cardColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data == "Device"
                                        ? AppColors.IconDarkGray
                                        : null,
                                textColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data == "Device"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                arrowColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data == "Device"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                onTap: () {
                                  print("tablet: $tablet");
                                  if (tablet) {
                                    setState(() {
                                      hardwareList = false;
                                    });
                                  }
                                  tablet
                                      ? settingBloc.selectedSettingNameSink
                                          .add("Device")
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DeviceScreen()));
                                },
                              ),
                              card(
                                  title: eptxt('settings_hardware'),
                                  iconPath: "assets/settingIcons/Hardware.png",
                                  cardColor: hardwareList ||
                                          snapshotSettingName.data ==
                                              "Printer" ||
                                          snapshotSettingName.data ==
                                              "CardReader" ||
                                          snapshotSettingName.data ==
                                              "CashDrawer"
                                      ? AppColors.IconDarkGray
                                      : null,
                                  textColor: hardwareList ||
                                          snapshotSettingName.data ==
                                              "Printer" ||
                                          snapshotSettingName.data ==
                                              "CardReader" ||
                                          snapshotSettingName.data ==
                                              "CashDrawer"
                                      ? AppColors.PrimaryWhite
                                      : null,
                                  arrowColor: hardwareList ||
                                          snapshotSettingName.data ==
                                              "Printer" ||
                                          snapshotSettingName.data ==
                                              "CardReader" ||
                                          snapshotSettingName.data ==
                                              "CashDrawer"
                                      ? AppColors.PrimaryWhite
                                      : null,
                                  onTap: () {
                                    tablet
                                        ? setState(() {
                                            hardwareList = true;
                                          }) //settingBloc.selectedSettingNameSink
                                        //.add("Hardware")
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HardwareScreen()));
                                  }),
                              card(
                                title: eptxt('settings_employees'),
                                iconPath: "assets/settingIcons/Employees.png",
                                cardColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data == "Employees"
                                        ? AppColors.IconDarkGray
                                        : null,
                                textColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data == "Employees"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                arrowColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data == "Employees"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                onTap: () {
                                  print("tablet: $tablet");
                                  if (tablet) {
                                    setState(() {
                                      hardwareList = false;
                                    });
                                  }

                                  tablet
                                      ? settingBloc.selectedSettingNameSink
                                          .add("Employees")
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EmployeesList(),
                                          ),
                                        );
                                },
                              ),
                              card(
                                title: eptxt('settings_cash'),
                                iconPath:
                                    "assets/settingIcons/CashManagement.png",
                                cardColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data ==
                                            "CashManagement"
                                        ? AppColors.IconDarkGray
                                        : null,
                                textColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data ==
                                            "CashManagement"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                arrowColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data ==
                                            "CashManagement"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                onTap: () {
                                  print("tablet: $tablet");
                                  if (tablet) {
                                    setState(() {
                                      hardwareList = false;
                                    });
                                  }
                                  tablet
                                      ? settingBloc.selectedSettingNameSink
                                          .add("CashManagement")
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CashManagementScreen()));
                                },
                              ),
                              card(
                                title: eptxt('settings_payments'),
                                iconPath:
                                    "assets/settingIcons/PaymentOption.png",
                                cardColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data ==
                                            "PaymentOption"
                                        ? AppColors.IconDarkGray
                                        : null,
                                textColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data ==
                                            "PaymentOption"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                arrowColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data ==
                                            "PaymentOption"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                onTap: () {
                                  print("tablet: $tablet");
                                  if (tablet) {
                                    setState(() {
                                      hardwareList = false;
                                    });
                                  }
                                  tablet
                                      ? settingBloc.selectedSettingNameSink
                                          .add("PaymentOption")
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentOptionScreen()));
                                },
                              ),
                              card(
                                title: eptxt('loyalty'),
                                iconPath: "assets/settingIcons/Loyality.png",
                                cardColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data == "Loyalty"
                                        ? AppColors.IconDarkGray
                                        : null,
                                textColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data == "Loyalty"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                arrowColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data == "Loyalty"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                onTap: () {
                                  print("tablet: $tablet");
                                  if (tablet) {
                                    setState(() {
                                      hardwareList = false;
                                    });
                                  }
                                  tablet
                                      ? settingBloc.selectedSettingNameSink
                                          .add("Loyalty")
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoyaltyScreen()));
                                },
                              ),
                              card(
                                title: eptxt('transactions'),
                                iconPath: "assets/settingIcons/Transaction.png",
                                cardColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data == "Transaction"
                                        ? AppColors.IconDarkGray
                                        : null,
                                textColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data == "Transaction"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                arrowColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data == "Transaction"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                onTap: () {
                                  print("Transaction tablet: $tablet");
                                  if (tablet) {
                                    setState(() {
                                      hardwareList = false;
                                    });
                                  }
                                  tablet
                                      ? settingBloc.selectedSettingNameSink
                                          .add("Transaction")
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TransactionScreen()));
                                },
                              ),
                              card(
                                title: eptxt('settings_customize'),
                                iconPath: "assets/settingIcons/Customize.png",
                                cardColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data ==
                                            "CustomizeHome"
                                        ? AppColors.IconDarkGray
                                        : null,
                                textColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data ==
                                            "CustomizeHome"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                arrowColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data ==
                                            "CustomizeHome"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                onTap: () {
                                  print("Transaction tablet: $tablet");
                                  if (tablet) {
                                    setState(() {
                                      hardwareList = false;
                                    });
                                  }
                                  tablet
                                      ? settingBloc.selectedSettingNameSink
                                          .add("CustomizeHome")
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CustomizeHomeScreen()));
                                },
                              ),
                              card(
                                title: "Product Attributes",
                                iconPath: "assets/settingIcons/Customize.png",
                                cardColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data ==
                                            "ProductAttributes"
                                        ? AppColors.IconDarkGray
                                        : null,
                                textColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data ==
                                            "ProductAttributes"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                arrowColor: hardwareList
                                    ? null
                                    : snapshotSettingName.data ==
                                            "ProductAttributes"
                                        ? AppColors.PrimaryWhite
                                        : null,
                                onTap: () {
                                  print("Transaction tablet: $tablet");
                                  if (tablet) {
                                    setState(
                                      () {
                                        hardwareList = false;
                                      },
                                    );
                                  }
                                  tablet
                                      ? settingBloc.selectedSettingNameSink
                                          .add("ProductAttributes")
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductAttributesScreen(),
                                          ),
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                });
          });
    }

    Widget buildHardwareList() {
      return StreamBuilder<Object>(
          stream: settingBloc.selectedSettingNameStream,
          builder: (context, snapshotSettingName) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: hp(12),
                ),
                card(
                  title: eptxt('printers'),
                  iconPath: "assets/hardware/Printer.png",
                  showArrow: false,
                  cardColor:
                      hardwareType == "Printer" ? AppColors.IconGray : null,
                  textColor: snapshotSettingName.data == "Printer"
                      ? AppColors.PrimaryWhite
                      : null,
                  onTap: () {
                    print("Tap: Printer");
                    if (tablet) {
                      settingBloc.selectedSettingNameSink.add("Printer");
                      setState(() {
                        hardwareList = false;
                      });
                    } else
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrinterScreen()));
                  },
                ),
                card(
                  title: eptxt('card_reader'),
                  iconPath: "assets/hardware/CardReader.png",
                  showArrow: false,
                  cardColor:
                      hardwareType == "CardReader" ? AppColors.IconGray : null,
                  textColor: snapshotSettingName.data == "CardReader"
                      ? AppColors.PrimaryWhite
                      : null,
                  onTap: () {
                    print("Tap: Card Reader");
                    if (tablet) {
                      settingBloc.selectedSettingNameSink.add("CardReader");
                      setState(() {
                        hardwareList = false;
                      });
                    } else
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CardReaderScreen()));
                  },
                ),
                card(
                  title: eptxt('cash_drawers'),
                  iconPath: "assets/hardware/CashDrawer.png",
                  showArrow: false,
                  cardColor:
                      hardwareType == "CashDrawer" ? AppColors.IconGray : null,
                  textColor: snapshotSettingName.data == "CashDrawer"
                      ? AppColors.PrimaryWhite
                      : null,
                  onTap: () {
                    print("Tap: Cash Drawer");
                    if (tablet) {
                      settingBloc.selectedSettingNameSink.add("CashDrawer");
                      setState(() {
                        hardwareList = false;
                      });
                    } else
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CashDrawerScreen()));
                  },
                ),
              ],
            );
          });
    }

    Widget buildHardwareWidget() {
      return Row(
        children: <Widget>[
          Container(
            width: hp(50),
            decoration: BoxDecoration(
              color: AppColors.DarkWhite,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/loginscreen/white_background.png'),
              ),
              boxShadow: [
                new BoxShadow(
                    color: AppColors.DarkGray.withOpacity(0.4),
                    offset: new Offset(5, 0),
                    blurRadius: 2.0),
              ],
            ),
            //decoration: BackgroundImage.buildBackgroundImageWhite(),
            child: buildHardwareList(),
          ),
        ],
      );
    }

    Widget buildNoWidgetSelectedWidget() {
      return Container(
        decoration: BackgroundImage.buildBackgroundImageWhite(),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: hp(5)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: hp(1)),
                child: Image.asset(
                  "assets/settingIcons/NoSettings.png",
                  height: hp(19.5),
                ),
              ),
              Text(
                "Please select a settings\n from the left",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.TermsGray.withOpacity(0.8),
                  fontSize: hp(3),
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
        case 'Device':
          print("Device selected");
          return DeviceList();
        case 'Employees':
          print("Employees selected");
          return EmployeesList(action: (a) {
            if (a == true){
              settingBloc.selectedSettingNameSink.add("AddEmployees");

            }else {
              settingBloc.selectedSettingNameSink.add("EmployeesDetail");
            }});
        case 'AddEmployees':
          print("Add Employees selected");
          return EmployeeList(add: true);
        case 'EmployeesDetail':
          print("Employees selected");
          return EmployeeList();
        case 'CashManagement':
          print("CashManagement selected");
          return CashManagementWidget();
        case 'Loyalty':
          print("Loyalty selected");
          return LoyaltyWidget();
        case 'Hardware':
          print("Hardware selected");
          return buildHardwareWidget();
        case 'Printer':
          print("Printer selected");
          return PrinterWidget();
        case 'CardReader':
          print("CardReader selected");
          return CardReaderWidget();
        case 'CashDrawer':
          print("CashDrawer selected");
          return CashDrawerWidget();
        case 'PaymentOption':
          print("PaymentOption selected");
          return PaymentOptionsWidget();
        case 'Transaction':
          print("Transaction selected");
          return TransactionWidgets();
        case 'CustomizeHome':
          print("CustomizeHome selected");
          return CustomizeHomeWidget();
        case 'ProductAttributes':
          print("ProductAttributes selected");
          return ProductAttributesList();
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
        onChangeSearch: (val) {
          settingBloc.filterSettingQuerySink.add(val);
        },
        searchIcon: true,
        menu: true,
        title: 'SETTINGS',
      ),
      body: StreamBuilder(
          stream: multilangBloc.stream,
          builder: ((context, _) {
            return StreamBuilder(
              stream: settingBloc.selectedSettingNameStream,
              builder: (context, snapshotSettingName) {
                return StreamBuilder<bool>(
                    stream: settingBloc.showHardwareStream,
                    builder: (context, snapshot) {
                      print("ShowSideBar ${snapshotSettingName.data}");
                      if (snapshotSettingName.hasData) {
                        if (snapshotSettingName.data == "Printer") {
                          if (mounted) {
                            hardwareType = "Printer";
                          }
                        } else if (snapshotSettingName.data == "CardReader") {
                          if (mounted) {
                            hardwareType = "CardReader";
                          }
                        } else if (snapshotSettingName.data == "CashDrawer") {
                          if (mounted) {
                            hardwareType = "CashDrawer";
                          }
                        } else {
                          if (mounted) {
                            hardwareType = "";
                          }
                        }
                      }

                      return tablet
                          ? ScreenWithSide(
                              side: settingsList(),
                              body: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  buildSelectedSettingWidget(
                                      selectedWidget: snapshotSettingName.data),
                                  if (hardwareList) buildHardwareWidget()
                                ],
                              ))
                          : settingsList();
                    });
              },
            );
          })),
    );
  }
}
