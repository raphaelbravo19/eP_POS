import 'package:epaisa_pos/src/bloc/bloc.dart';
import 'package:epaisa_pos/src/bloc/login_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabSubOptions extends StatelessWidget {
  TabSubOptions({
    this.stateView = 1,
    this.onTap,
    Key key,
  }) : super(key: key);
  int stateView;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    Map<String, Widget> icons = {
      "cashdrawer": Image.asset(
        "assets/leftdrawer/cashdrawer.png",
        height: hp(3.5),
      ),
      "customers": Image.asset(
        "assets/leftdrawer/customers.png",
        height: hp(3.5),
      ),
      "transactions": Image.asset(
        "assets/leftdrawer/transactions.png",
        height: hp(3.5),
      ),
      "settings": Image.asset(
        "assets/leftdrawer/settings.png",
        height: hp(3.5),
      ),
      "quick": Image.asset(
        "assets/leftdrawer/quick_opt.png",
        height: hp(4),
      ),
      "value": Image.asset(
        "assets/leftdrawer/value.png",
        height: hp(4),
      ),
      "products": Image.asset(
        "assets/leftdrawer/products.png",
        height: hp(4),
      ),
      "packages": Image.asset(
        "assets/leftdrawer/packages.png",
        height: hp(4),
      ),
      "promotions": Image.asset(
        "assets/leftdrawer/promotions.png",
        height: hp(4),
      ),
      "categories": Image.asset(
        "assets/leftdrawer/categories.png",
        height: hp(4),
      ),
      "distributors": Image.asset(
        "assets/leftdrawer/distributors.png",
        height: hp(4),
      ),
      "manufacturers": Image.asset(
        "assets/leftdrawer/manufacturers.png",
        height: hp(4),
      ),
      "invent_loc": Image.asset(
        "assets/leftdrawer/inventory_movement_p.png",
        height: hp(4),
      ),
      "invent_mov": Image.asset(
        "assets/leftdrawer/inventory_movement.png",
        height: hp(4),
      ),
    };
    Map<String, String> titles = {
      "cashdrawer": eptxt('ld_cashdrawer'),
      "customers": eptxt('customers'),
      "transactions": eptxt('ld_transactions'),
      "settings": eptxt('settings'),
      "quick": eptxt('quick_payment'),
      "value": eptxt('ld_value'),
      "products": eptxt('products'),
      "packages": eptxt('packages'),
      "promotions": eptxt('promotions'),
      "categories": eptxt('categories'),
      "distributors": eptxt('distributors'),
      "manufacturers": eptxt('manufacturers'),
      "invent_loc": eptxt('ld_invent_loc'),
      "invent_mov": eptxt('ld_invent_mov'),
    };
    Map<String, Function> direct = {
      "cashdrawer": () {
        onTap(5);
      },
      "customers": () {
        onTap(9);
      },
      "transactions": () {
        onTap(4);
      },
      "settings": () {
        onTap(13);
      },
      "quick": () {
        onTap(8);
      },
      "value": () {},
      "products": () {
        onTap(0);
      },
      "packages": () {
        onTap(12);
      },
      "promotions": () {
        onTap(11);
      },
      "categories": () {
        onTap(2);
      },
      "distributors": () {
        onTap(3);
      },
      "manufacturers": () {
        onTap(1);
      },
      "invent_loc": () {},
      "invent_mov": () {},
    };
    List<String> getData() {
      switch (stateView) {
        case 0:
          return [
            "quick",
            "customers",
            "transactions",
            "settings",
          ];
        case 1:
          return [
            "cashdrawer",
            "customers",
            "transactions",
            "settings",
          ];
        case 2:
          return [
            "products",
            "packages",
            "promotions",
            "categories",
            "distributors",
            "manufacturers",
            "invent_loc",
            "invent_mov",
          ];
        case 3:
          return [
            "customers",
            "settings",
          ];
        case 4:
          return [
            "value",
            "customers",
            "transactions",
            "settings",
          ];
      }
    }

    List<Widget> buildContent() {
      List<Widget> content = List<Widget>();
      List<String> categories = getData();
      print(categories);
      for (var i = 0; i < categories.length; i++) {
        content.add(GestureDetector(
          onTap: direct[categories[i]],
          child: Container(
            padding:
                EdgeInsets.fromLTRB(tablet ? wp(2) : wp(5), hp(2), 0, hp(2)),
            child: Row(
              children: <Widget>[
                Container(
                  width: tablet ? wp(3) : wp(10),
                  alignment: Alignment.center,
                  child: icons[categories[i]],
                ),
                SizedBox(
                  width: tablet ? wp(1.5) : wp(4),
                ),
                FittedBox(
                  child: Text(titles[categories[i]],
                      maxLines: 1,
                      style: TextStyle(
                          color: AppColors.PrimaryWhite,
                          fontSize: tablet ? wp(1.7) : wp(4),
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ));
      }
      return content;
    }

    return SafeArea(
      top: false,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: ScrollConfiguration(
                behavior: RemoveOverScrollGlow(),
                child: SingleChildScrollView(
                  child: Column(children: buildContent()),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: wp(4)),
            height: hp(8.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  "assets/leftdrawer/bluetooth.png",
                  height: hp(4.1),
                ),
                GestureDetector(
                  onTap: () {
                    onTap(10);
                  },
                  child: Image.asset(
                    "assets/leftdrawer/help.png",
                    height: hp(4.1),
                  ),
                ),
                Image.asset(
                  "assets/leftdrawer/analytics.png",
                  height: hp(4.1),
                ),
                GestureDetector(
                  onTap: () {
                    loginBloc.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                    /*BlocProvider.of<AuthenticationBloc>(context)
                        .dispatch(LoggedOut());*/
                  },
                  child: Image.asset(
                    "assets/leftdrawer/signout.png",
                    height: hp(4.1),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
