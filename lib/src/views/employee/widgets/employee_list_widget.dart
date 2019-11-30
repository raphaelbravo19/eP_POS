import 'package:epaisa_pos/src/bloc/bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/customers/customers_info/customer_info.dart';
import 'package:epaisa_pos/src/views/customers/customers_info/customer_info.dart'
    as prefix0;
import 'package:epaisa_pos/src/views/employee/widgets/row_structure.dart';
import 'package:epaisa_pos/src/views/personal/widgets/personal_widget.dart';
import 'package:epaisa_pos/src/views/transactions/transactions_screen.dart';
import 'package:epaisa_pos/src/views/transactions/transactions_screen.dart'
    as prefix1;
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:epaisa_pos/src/logic/personal_bloc/personal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_common.dart';
import 'package:epaisa_pos/src/widgets/header_card/header_widget.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';

class EmployeeList extends StatefulWidget {
  bool add;
  EmployeeList({this.backaction, this.add = false});
  final Function backaction;

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  final personBloc = PersonalBloc();

  final locationBloc = LocationBloc();
  GlobalKey<TextfieldClassicState> bkey = GlobalKey<TextfieldClassicState>();
  BehaviorSubject<int> tabStream = new BehaviorSubject<int>.seeded(0);
  @override
  void dispose() {
    locationBloc.dispose();
    tabStream.close();
  }

  GlobalKey<TextfieldClassicState> _controller = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    double fontSize = tablet ? hp(2.5) : hp(2);
    final dialog = DialogCommon(context: context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.20 : width * 0.25;
    var layoutHeight = tablet ? height * 0.70 : height * 0.6;

    Widget name() {
      return RowStructure(
        imagePath: 'assets/employee/Name.png',
        child: Row(
          children: <Widget>[
            Expanded(
                child: TextfieldClassic(
              paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
              fontSize: tablet ? hp(2.5) : hp(2.1),
              labelText: "First Name",
            )),
            Expanded(
                child: TextfieldClassic(
              leftBorder: true,
              paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
              fontSize: tablet ? hp(2.5) : hp(2.1),
              labelText: "Last Name",
            )),
          ],
        ),
      );
    }

    Widget email() {
      return RowStructure(
        imagePath: 'assets/employee/Email.png',
        child: TextfieldClassic(
          fontSize: tablet ? hp(2.5) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: eptxt('email'),
        ),
      );
    }

    Widget mobNo() {
      return RowStructure(
        imagePath: 'assets/employee/MobileNumber.png',
        child: TextfieldNumber(
          fontSize: tablet ? hp(2.5) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: eptxt('mobile_number'),
        ),
      );
    }

    Widget country() {
      return RowStructure(
        imagePath: 'assets/my_account/country_sh.png',
        child: TextfieldDropdown(
          items: [
            {"name": "Bandra West", "value": 0},
            {"name": "Bandra East", "value": 1},
            {"name": "Bandra South", "value": 2},
          ],
          paddingBottomInput: hp(1),
          fontSize: fontSize,
          labelText: "Store",
        ),
      );
    }

    Widget birthday() {
      return RowStructure(
        imagePath: 'assets/customers/calendar.png',
        onTap: () async {
          final DateTime picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1955),
              lastDate: DateTime(2020),
              footerBuilder: datePickerFooter,
              width: tablet ? wp(45) : wp(80),
              headerBuilder: datePickerHeader,
              builder: (ct, child) {
                return child;
              });
          if (picked != null) {
            bkey.currentState.changeText(DateFormat.yMd().format(picked));
          }
        },
        child: TextfieldClassic(
          disabled: true,
          key: bkey,
          optional: false,
          calendar: true,
          firstDate: 1955,
          lastDate: 2020,
          customIconBuilder: (hasFocus, empty) {
            return GestureDetector(
              onTap: () async {
                final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1955),
                    lastDate: DateTime(2020),
                    footerBuilder: datePickerFooter,
                    width: tablet ? wp(45) : wp(80),
                    headerBuilder: datePickerHeader,
                    builder: (ct, child) {
                      return child;
                    });
                if (picked != null) {
                  bkey.currentState.changeText(DateFormat.yMd().format(picked));
                }
              },
              child: Container(),
            );
          },
          noClear: true,
          fontSize: tablet ? hp(2.5) : hp(2.1),
          paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
          labelText: "Birthdate",
          alwaysFocus: false,
          //alwaysBlue: true,
        ),
      );
    }

    Widget roles() {
      return RowStructure(
        imagePath: 'assets/employee/Address.png',
        child: TextfieldDropdown(
          items: [
            {"name": "Cashier", "value": 0},
            {"name": "Driver", "value": 1},
            {"name": "Client", "value": 2},
          ],
          paddingBottomInput: hp(1),
          fontSize: fontSize,
          labelText: "Roles",
        ),
      );
    }

    Widget tabInformation() {
      return Column(children: <Widget>[
        SizedBox(
          height: tablet ? hp(1) : wp(4),
        ),
        name(),
        email(),
        mobNo(),
        country(),
        birthday(),
        roles(),
      ]);
    }

    Widget graphicOne() {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: hp(1.2)),
        padding: EdgeInsets.symmetric(horizontal: wp(tablet ? 3 : 8)),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Total time worked",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.5) : wp(5),
                      fontWeight: FontWeight.w700,
                      color: AppColors.DarkGray),
                ),
                Text(
                  "8.23",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.5) : wp(5),
                      fontWeight: FontWeight.w700,
                      color: AppColors.DarkGray),
                ),
              ],
            ),
            SizedBox(
              height: hp(1.7),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.SuccessText,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: new Offset(0, 3.0),
                    blurRadius: 2,
                  )
                ],
              ),
              height: hp(tablet ? 3 : 3.8),
              child: Row(
                children: <Widget>[
                  Spacer(flex: 10),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Color(0xFF011C72),
                    ),
                  ),
                  Spacer(flex: 15),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Color(0xFF011C72),
                    ),
                  ),
                  Spacer(flex: 9),
                ],
              ),
            ),
            SizedBox(
              height: hp(1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "10:12 AM",
                  style: TextStyle(
                      fontSize: tablet ? hp(1.8) : wp(3.4),
                      letterSpacing: tablet ? 2 : wp(0.3),
                      fontWeight: FontWeight.w600,
                      color: AppColors.LightGray),
                ),
                Text(
                  "8:23 PM",
                  style: TextStyle(
                      fontSize: tablet ? hp(1.8) : wp(3.4),
                      letterSpacing: tablet ? 2 : wp(0.3),
                      fontWeight: FontWeight.w600,
                      color: AppColors.LightGray),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget tableSchedule() {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: hp(1.2)),
        padding: EdgeInsets.symmetric(horizontal: wp(3)),
        child: Column(children: [
          Container(
            color: AppColors.IconLightGray,
            padding: EdgeInsets.only(
                left: wp(tablet ? 3 : 4.5),
                right: wp(tablet ? 3.5 : 6),
                top: hp(0.7),
                bottom: hp(0.7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Time Period",
                  style: TextStyle(
                      fontSize: tablet ? hp(1.9) : wp(3.2),
                      letterSpacing: tablet ? 2.3 : wp(0.3),
                      fontWeight: FontWeight.w700,
                      color: AppColors.PrimaryWhite),
                ),
                Text(
                  "Hours",
                  style: TextStyle(
                      fontSize: tablet ? hp(1.9) : wp(3.2),
                      letterSpacing: tablet ? 2.3 : wp(0.3),
                      fontWeight: FontWeight.w700,
                      color: AppColors.PrimaryWhite),
                ),
              ],
            ),
          ),
          ...List.generate(5, (index) {
            return Container(
              color: index % 2 == 0 ? AppColors.RowGreen : AppColors.RowBlue,
              padding: EdgeInsets.only(
                  left: wp(tablet ? 3 : 4.5),
                  right: wp(tablet ? 3.5 : 6),
                  top: hp(0.7),
                  bottom: hp(0.7)),
              margin: EdgeInsets.only(top: 1.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "10.12 AM - 3.20 PM",
                    style: TextStyle(
                        fontSize: tablet ? hp(2.1) : wp(3.2),
                        letterSpacing: tablet ? 2.2 : wp(0.3),
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Text(
                    "4.53",
                    style: TextStyle(
                        fontSize: tablet ? hp(2.1) : wp(3.2),
                        letterSpacing: tablet ? 2.2 : wp(0.3),
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
            );
          })
        ]),
      );
    }

    Widget tableScheduleRange() {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: hp(1.2)),
        padding: EdgeInsets.symmetric(horizontal: wp(3)),
        child: Column(children: [
          Container(
            color: AppColors.IconLightGray,
            padding: EdgeInsets.symmetric(vertical: hp(0.5), horizontal: wp(3)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Date",
                  style: TextStyle(
                      fontSize: tablet ? hp(2) : wp(3.2),
                      letterSpacing: tablet ? 2 : wp(0.3),
                      fontWeight: FontWeight.w700,
                      color: AppColors.PrimaryWhite),
                ),
                Text(
                  "Hours",
                  style: TextStyle(
                      fontSize: tablet ? hp(2) : wp(3.2),
                      letterSpacing: tablet ? 2 : wp(0.3),
                      fontWeight: FontWeight.w700,
                      color: AppColors.PrimaryWhite),
                ),
              ],
            ),
          ),
          ...List.generate(9, (index) {
            return Container(
              color:
                  index % 2 == 0 ? AppColors.PrimaryWhite : AppColors.RowGray,
              padding:
                  EdgeInsets.symmetric(vertical: hp(0.7), horizontal: wp(3)),
              margin: EdgeInsets.only(top: 1.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${index < 9 ? "0" : ""}${index + 1} / 09 / 2019",
                    style: TextStyle(
                        fontSize: tablet ? hp(2) : wp(3.2),
                        letterSpacing: tablet ? 2 : wp(0.3),
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Text(
                    "4.53",
                    style: TextStyle(
                        fontSize: tablet ? hp(2) : wp(3.2),
                        letterSpacing: tablet ? 2 : wp(0.3),
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
            );
          }),
          SizedBox(
            height: hp(4),
          )
        ]),
      );
    }

    Widget tabSheet() {
      return GestureDetector(
        onTap: () {
          tabStream.sink.add(2);
        },
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            SelectDateExtense(
              onTap: () => prefix0.pickRangeOfDates(
                DateTime.now(),
                DateTime.now().add(Duration(days: 7)),
                context,
              ),
            ),
            SizedBox(
              height: hp(1),
            ),
            graphicOne(),
            SizedBox(
              height: hp(tablet ? 0.2 : 1.5),
            ),
            tableSchedule(),
          ]),
        ),
      );
    }

    Widget levelColumn(index, double level) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: wp(tablet ? 2 : 1.2)),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              level.toStringAsFixed(2),
              style: TextStyle(
                  fontSize: tablet ? hp(1.8) : wp(3),
                  letterSpacing: wp(0.1),
                  fontWeight: FontWeight.w600,
                  color: AppColors.BlueGray),
            ),
            SizedBox(
              height: hp(tablet ? 0.7 : 0.5),
            ),
            Container(
                height: hp(11) * level / 8,
                width: tablet ? hp(2) : wp(2.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [0.7, 0.9],
                    colors: [
                      // Colors are easy thanks to Flutter's Colors class.
                      Color(0xFF9B66FF), Color(0xFF6236FF)
                    ],
                  ),
                )),
            SizedBox(
              height: hp(1),
            ),
            Text(
              "${index < 9 ? "0" : ""}${index + 1}/09",
              style: TextStyle(
                  fontSize: tablet ? hp(1.9) : wp(3),
                  letterSpacing: wp(0.1),
                  fontWeight: FontWeight.w600,
                  color: AppColors.BlueGray),
            ),
          ],
        ),
      );
    }

    Widget graphicTwo() {
      var list = [3.42, 4.05, 6.5, 3.12, 5.55, 2.58, 3.24, 5.45, 6.52, 1.0];
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: hp(1.2)),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: wp(tablet ? 6 : 8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total time worked",
                    style: TextStyle(
                        fontSize: tablet ? hp(2.8) : wp(5),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray),
                  ),
                  Text(
                    "68.45",
                    style: TextStyle(
                        fontSize: tablet ? hp(2.8) : wp(5),
                        fontWeight: FontWeight.w700,
                        color: AppColors.DarkGray),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: hp(1),
            ),
            Container(
                width: wp(100),
                height: hp(tablet ? 18 : 14),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: wp(1.5)),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(list.length, (index) {
                      return levelColumn(index, list[index]);
                    }),
                  ),
                )),
            SizedBox(
              height: hp(2),
            ),
          ],
        ),
      );
    }

    Widget tabSheetRange() {
      return SingleChildScrollView(
        child: Column(children: <Widget>[
          SelectDateExtense(
            onTap: () => prefix1.pickRangeOfDates(
              DateTime.now(),
              DateTime.now().add(Duration(days: 7)),
              context,
            ),
          ),
          graphicTwo(),
          tableScheduleRange(),
        ]),
      );
    }

    var bgImage = AssetImage(
        "assets/splashscreen/background${tablet ? "_landscape" : ""}.png");
    Widget tabNavigator() {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.PrimaryWhite,
          image: DecorationImage(
            image: bgImage,
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: new Offset(0, 4.0),
              blurRadius: 3,
            )
          ],
        ),
        child: StreamBuilder<int>(
            stream: tabStream,
            builder: (context, snapshot) {
              return Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          tabStream.sink.add(0);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: snapshot.data == 0
                                          ? AppColors.PrimaryBlue.withOpacity(
                                              0.9)
                                          : Colors.transparent,
                                      width: 4))),
                          padding: EdgeInsets.symmetric(vertical: hp(1.1)),
                          child: Text(
                            "Information",
                            style: TextStyle(
                                fontSize: tablet ? hp(2.4) : wp(4),
                                fontWeight: FontWeight.w600,
                                color: AppColors.DarkGray),
                          ),
                        )),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      tabStream.sink.add(1);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: snapshot.data == 1
                                      ? AppColors.PrimaryBlue.withOpacity(0.9)
                                      : Colors.transparent,
                                  width: 4))),
                      padding: EdgeInsets.symmetric(vertical: hp(1.1)),
                      child: Text(
                        "Time Sheet",
                        style: TextStyle(
                            fontSize: tablet ? hp(2.4) : wp(4),
                            fontWeight: FontWeight.w600,
                            color: AppColors.DarkGray),
                      ),
                    ),
                  ))
                ],
              );
            }),
      );
    }

    Widget buildEmployee() {
      return Column(
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                StreamBuilder<int>(
                    stream: tabStream,
                    builder: (context, snapshot) {
                      switch (snapshot.data) {
                        case 0:
                          return tabInformation();
                        case 1:
                          return tabSheet();
                        case 2:
                          return tabSheetRange();
                        default:
                          return tabSheetRange();
                      }
                    }),
                tabNavigator(),
                CommonHeader(
                  create: widget.add,
                ),
              ],
            ),
          ))
        ],
      );
    }

    return buildEmployee();
  }
}

class SelectDateExtense extends StatelessWidget {
  const SelectDateExtense({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: tablet ? Colors.grey[500] : Colors.grey[300],
              offset: Offset(0.0, 2.0),
              blurRadius: 5.0,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: hp(3), vertical: hp(1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/general_icons/calendar.png',
              height: tablet ? hp(3.2) : wp(5),
              color: AppColors.PrimaryBlue,
              colorBlendMode: BlendMode.srcATop,
            ),
            Padding(
              child: Text(
                "${DateFormat('dd MMM yyyy').format(DateTime.now())} - ${DateFormat('dd MMM yyyy').format(DateTime.now().add(Duration(days: 7)))}",
                style: TextStyle(
                    fontSize: tablet ? hp(1.9) : wp(3.1),
                    fontWeight: FontWeight.w700,
                    color: AppColors.PrimaryBlue,
                    wordSpacing: 1.0),
              ),
              padding: EdgeInsets.only(
                left: tablet ? hp(2.2) : wp(3),
              ),
            ),
            Spacer(flex: 1),
            Container(
              margin: EdgeInsets.only(top: hp(0.3), left: tablet ? hp(0.5) : 0),
              child: Icon(Icons.keyboard_arrow_down,
                  size: tablet ? hp(3.6) : hp(3),
                  color: AppColors.IconDarkGray),
            ),
          ],
        ),
      ),
    );
  }
}
