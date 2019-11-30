import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/customers/widgets/add_customer_dialog.dart';
import 'package:epaisa_pos/src/widgets/dialogs/epaisa_dialog.dart';
import 'package:flutter/material.dart';

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

class SearchCustomer extends StatefulWidget {
  SearchCustomer({
    @required this.close,
    this.onAddNew,
  });

  final Function close;
  final Function onAddNew;

  @override
  _SearchCustomerState createState() => _SearchCustomerState();
}

class _SearchCustomerState extends State<SearchCustomer> {
  var showResults = false;
  String searchStr = '';
  List results = [];

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

  double getHeight(double itemHeight, int length, bool tablet) {
    int maxItems = (tablet ? 4 : 5);
    return itemHeight * (length < maxItems ? 1 : maxItems);
  }

  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    var tablet = isTablet(MediaQuery.of(context));
    final width = wp(tablet ? 50 : 96);
    final headerHeight = tablet ? hp(8.4) : hp(6.5);
    final bodyVerticalMarginHeight = tablet ? hp(4) : hp(3);
    final inputSearchHeight = tablet ? hp(8.5) : hp(6.5);
    final itemResultHeight = tablet ? hp(10) : hp(7.5);

    return new EpaisaDialog(
      bodyHeight: headerHeight + bodyVerticalMarginHeight + inputSearchHeight,
      context: context,
      close: widget.close,
      width: width,
      header: EpaisaDialogHeader(
        hp: hp,
        close: widget.close,
        title: eptxt('customer_information'),
        height: headerHeight,
      ),
      body: Container(
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
            onChanged: (value) {
              doSearch(value);
            },
            onFocusChange: (hasFocus) {
              // setState(() {
              //   showResults = hasFocus;
              // });
            },
          ),
        ),
      ),
      overflow: results.length > 0
          ? Container(
              width: width - hp(4),
              height:
                  getHeight(itemResultHeight, results.toList().length, tablet),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(hp(1.6)),
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
            )
          : Container(),
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

class SearchCustomerTextField extends StatefulWidget {
  const SearchCustomerTextField({
    Key key,
    @required this.hp,
    @required this.height,
    this.onFocusChange,
    this.onChanged,
  }) : super(key: key);

  final Function hp;
  final Function onFocusChange;
  final Function onChanged;
  final double height;

  @override
  _SearchCustomerTextFieldState createState() =>
      _SearchCustomerTextFieldState();
}

class _SearchCustomerTextFieldState extends State<SearchCustomerTextField> {
  FocusNode _focus = FocusNode();
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
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
      padding: EdgeInsets.only(bottom: bottom),
      child: TextField(
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged(value);
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
