import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/customers/widgets/add_customer_dialog.dart';
import 'package:epaisa_pos/src/views/payments/checkout/checkout.dart';
import 'package:epaisa_pos/src/views/payments/payments_screen.dart';
import 'package:epaisa_pos/src/views/reset_password/widgets/otp_fields.dart';
import 'package:epaisa_pos/src/views/reset_password/widgets/timer.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/dialogs/screen_as_modal.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_password.dart';
import 'package:epaisa_pos/src/widgets/texts/text_gray.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

List customers = [
  {"name": "Vashti Dulle", "phone": "+911234567890"},
  {"name": "Cyndi Wein", "phone": "+911234567890"},
  {"name": "Ryan Edman", "phone": "+911234567890"},
  {"name": "Kenna Pompa", "phone": "+911234567890"},
  {"name": "Temeka Sontag", "phone": "+911234567890"},
  {"name": "Myung Grisby", "phone": "+911234567890"},
  {"name": "Shona Fritch", "phone": "+911234567890"},
  {"name": "Kazuko Merrigan", "phone": "+911234567890"},
  {"name": "Odilia Kearse", "phone": "+911234567890"},
  {"name": "Kandace Telesco", "phone": "+911234567890"},
  {"name": "Abbie Belli", "phone": "+911234567890"},
  {"name": "Louie Ruf", "phone": "+911234567890"},
];

class SearchCustomerDialog extends StatefulWidget {
  SearchCustomerDialog({Key key, this.close, this.onAddNew}) : super(key: key);
  Function close;
  Function onAddNew;
  @override
  SearchCustomerDialogState createState() => SearchCustomerDialogState();
}

class SearchCustomerDialogState extends State<SearchCustomerDialog> {
  bool showModal = true;
  bool resendDisabled = true;
  var showResults = false;
  String searchStr = '';
  List results = [];
  BehaviorSubject<double> position = new BehaviorSubject<double>.seeded(0.0);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    position.close();
    super.dispose();
  }

  void closeModal() {
    Navigator.of(context).pop();
    setState(() {
      showModal = false;
    });
  }

  void _showDialog(
      {BuildContext context,
      Widget paymentScreen,
      double width,
      double height}) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    Navigator.of(context).pushReplacement(
      new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return ScreenAsModal(
            body: paymentScreen,
            width: width,
            height: height,
          );
        },
      ),
    );
  }

  doSearch(String value) {
    final itemResultHeight = tablet ? hp(10) : hp(7.5);

    List found = customers.where((customer) {
      String customerName = customer['name'].toLowerCase();
      return customerName.contains(value.toLowerCase());
    }).map((customer) {
      return CustomerResultItem(
        onTap: () {
          widget.close();
        },
        height: itemResultHeight,
        name: '${customer['name'].toUpperCase()} / ${customer['phone']}',
      );
    }).toList();

    setState(() {
      searchStr = value;
      results = found.length > 0
          ? found
          : [
              CustomerResultItem(
                onTap: () {
                  // flutter defined function
                  if (widget.onAddNew != null) {
                    widget.onAddNew();
                  } else {
                    Navigator.of(context).pushReplacement(
                      new PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) {
                          return AddCustomerDialog();
                        },
                      ),
                    );
                  }
                },
                height: itemResultHeight,
                name: '+ ADD A NEW CUSTOMER',
                bold: true,
              )
            ].toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    final bodyVerticalMarginHeight = tablet ? hp(2) : hp(3);
    final inputSearchHeight = tablet ? hp(8.5) : hp(6.5);
    final itemResultHeight = tablet ? hp(10) : hp(7.5);
    final width = (tablet ? wp(54) : wp(85));
    Widget _titleNumber() {
      return Column(
        children: <Widget>[
          Text(
            "We have sent an OTP to",
            style: TextStyle(
                color: AppColors.DarkGray,
                fontSize: tablet ? hp(2.8) : hp(2.2),
                fontWeight: FontWeight.w600),
          ),
          Text(
            "+91 98675 43210",
            style: TextStyle(
                color: AppColors.PrimaryBlue,
                fontSize: tablet ? hp(3) : hp(2.4),
                fontWeight: FontWeight.w700),
          )
        ],
      );
    }

    List<Widget> _timeResend() {
      return [
        OtpFields(),
        SizedBox(
          height: hp(3),
        ),
        TimerButton(
          seconds: 10,
          onStart: () {},
          onFinish: () {
            setState(() {
              resendDisabled = false;
            });
          },
        ),
        SizedBox(
          height: hp(3),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: tablet ? wp(4.5) : wp(10)),
          child: ButtonGradient(
            disabled: resendDisabled,
            borderRadius: hp(3),
            fontSize: tablet ? hp(2.2) : hp(1.8),
            paddingVertical: tablet ? hp(2) : hp(1.8),
            title: "RESEND OTP",
          ),
        )
      ];
    }

    List<Widget> _formReset() {
      return [
        SizedBox(
          height: tablet ? hp(3) : hp(2),
        ),
        Text(
          "Insert New Password",
          style: TextStyle(
              color: AppColors.DarkGray,
              fontSize: tablet ? hp(2.5) : hp(2.2),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1),
        ),
        SizedBox(
          height: tablet ? hp(0.5) : hp(1),
        ),
        TextfieldPassword(
          fontSize: tablet ? hp(2.4) : hp(2.01),
          paddingBottomInput: hp(1),
          labelText: "Password",
        ),
        SizedBox(
          height: tablet ? hp(0.2) : hp(0.5),
        ),
        TextfieldPassword(
          fontSize: tablet ? hp(2.4) : hp(2.01),
          paddingBottomInput: hp(1),
          labelText: "Re-type Password",
        ),
        SizedBox(
          height: hp(3),
        ),
        ButtonGradient(
          disabled: true,
          borderRadius: hp(3),
          fontSize: tablet ? hp(2.2) : hp(1.8),
          paddingVertical: tablet ? hp(2) : hp(1.8),
          title: "RESET PASSWORD",
        ),
        SizedBox(
          height: hp(3),
        ),
      ];
    }

    double getHeight(double itemHeight, int length, bool tablet) {
      int maxItems = (tablet ? 4 : 5);
      return itemHeight * (length < maxItems ? 1 : maxItems);
    }

    Widget content() {
      return Container(
        width: (tablet ? wp(54) : wp(85)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, hp(0.5), 0, hp(1)),
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: tablet ? hp(2) : hp(1.3)),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.LightGray, width: 2.5))),
                      alignment: Alignment.center,
                      width: (tablet ? wp(54) : wp(85)),
                      child: Text(
                        "Customer Information",
                        style: TextStyle(
                            fontSize: tablet ? hp(3.1) : hp(2.2),
                            fontWeight: FontWeight.w700,
                            color: AppColors.DarkGray),
                      ),
                    ),
                    Positioned(
                        top: tablet ? hp(2.3) : hp(1.3),
                        right: hp(1.9),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showModal = false;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              "assets/general_icons/xbutton.png",
                              height: tablet ? hp(2.8) : hp(2.2),
                            ))),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: bodyVerticalMarginHeight,
                  horizontal: hp(2),
                ),
                alignment: Alignment.center,
                child: Container(
                  height: inputSearchHeight,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(hp(1.3)),
                    border: Border.all(color: Colors.black12),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        offset: const Offset(0, 0),
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        offset: const Offset(-0, -0),
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        offset: const Offset(0, -0),
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        offset: const Offset(-0, 0),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0, 0),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: tablet ? hp(2.4) : hp(1.6)),
                  child: SearchCustomerTextField(
                    hp: hp,
                    height: inputSearchHeight,
                    onChanged: (value, val) {
                      position.sink.add(val);
                      doSearch(value);
                    },
                    updatePosition: (val) {
                      position.sink.add(val);
                    },
                    onFocusChange: (hasFocus) {
                      // setState(() {
                      //   showResults = hasFocus;
                      // });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: tablet ? hp(2.5) : hp(2.7),
              ),
            ]),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Container(
        alignment: Alignment.center,
        width: wp(100),
        height: hp(100),
        child: !showModal
            ? Container()
            : Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showModal = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: wp(100),
                      height: hp(100),
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: (tablet ? wp(54) : wp(85)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      tablet ? wp(1.5) : wp(3)),
                                  color: AppColors.PrimaryWhite,
                                ),
                                child: content()),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                  results.length > 0
                      ? StreamBuilder<double>(
                          stream: position,
                          builder: (context, snapshot) {
                            if(snapshot.data!=null){
                            if (snapshot.data > 1) {
                              return Positioned(
                                  top: snapshot.data,
                                  child: Container(
                                    width: width - hp(4),
                                    height: getHeight(itemResultHeight,
                                        results.toList().length, tablet),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(hp(1.6)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 1,
                                        )
                                      ],
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: results,
                                      ),
                                    ),
                                  ));
                            } else {
                              return Container();
                            }
                            }else{
                              return Container();
                            }
                          })
                      : Container()
                ],
              ),
      ),
    );
  }
}

class SearchCustomerTextField extends StatefulWidget {
  const SearchCustomerTextField(
      {Key key,
      @required this.hp,
      @required this.height,
      this.onFocusChange,
      this.onChanged,
      this.updatePosition})
      : super(key: key);

  final Function hp;
  final Function onFocusChange;
  final Function onChanged;
  final double height;
  final Function updatePosition;
  @override
  _SearchCustomerTextFieldState createState() =>
      _SearchCustomerTextFieldState();
}

class _SearchCustomerTextFieldState extends State<SearchCustomerTextField> {
  FocusNode _focus = FocusNode();
  GlobalKey keyContainer = new GlobalKey();
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    Future.delayed(Duration(milliseconds: 10), () {
      RenderBox obj = keyContainer.currentContext.findRenderObject();
      var positionRed = obj.localToGlobal(Offset.zero);
      var sum = positionRed.dy + obj.size.height;
      widget.updatePosition(sum);
      print("${positionRed.dy}");
    });
  }

  @override
  void didUpdateWidget(SearchCustomerTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(Duration(milliseconds: 10), () {
      RenderBox obj = keyContainer.currentContext.findRenderObject();
      var positionRed = obj.localToGlobal(Offset.zero);
      var sum = positionRed.dy + obj.size.height;
      widget.updatePosition(sum);
      print("${positionRed.dy}");
    });
  }

  void _onFocusChange() {
    if (widget.onFocusChange != null) {
      widget.onFocusChange(_focus.hasFocus);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      key: keyContainer,
      padding: EdgeInsets.only(bottom: bottom),
      child: TextField(
        onChanged: (value) {
          if (widget.onChanged != null) {
            RenderBox obj = keyContainer.currentContext.findRenderObject();
            var positionRed = obj.localToGlobal(Offset.zero);
            widget.onChanged(value, positionRed.dy + obj.size.height);
          }
        },
        focusNode: _focus,
        decoration: InputDecoration(
          hintText: eptxt('hint_search_customer'),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: widget.height * 0.28,
            height: tablet ? 1.8 : 1.2,
          ),
          suffixIcon: Container(
            padding: EdgeInsets.all(widget.height * 0.3),
            child: Image.asset(
              "assets/general_icons/search.png",
              fit: BoxFit.contain,
            ),
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          height: tablet ? 1.6 : 1.2,
          fontSize: widget.height * 0.32,
          color: AppColors.BackPrimaryGray,
        ),
      ),
    );
  }
}

class CustomerResultItem extends StatelessWidget {
  const CustomerResultItem({
    Key key,
    this.isLast = false,
    @required this.height,
    @required this.name,
    this.bold = false,
    @required this.onTap,
  }) : super(key: key);

  final String name;
  final bool isLast;
  final bool bold;
  final double height;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final hp = ScreenUtils.of(context).hp;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: hp(3)),
        height: height,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: !isLast
              ? Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(108, 123, 138, 0.25),
                    width: 1,
                  ),
                )
              : null,
        ),
        child: Text(
          name,
          style: TextStyle(
            fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
            color: AppColors.BackPrimaryGray,
            fontSize: height * 0.2,
            letterSpacing: hp(0.1),
          ),
        ),
      ),
    );
  }
}
