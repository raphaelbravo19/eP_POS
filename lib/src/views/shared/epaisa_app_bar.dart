import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';

class EpaisaAppBar extends PreferredSize {
  const EpaisaAppBar(
      {this.tablet = false,
      this.title,
      this.leading,
      this.trailing,
      this.menu = false,
      this.openDrawer});

  final bool menu;
  final bool tablet;
  final String title;
  final Widget leading;
  final Function openDrawer;
  final List<Widget> trailing;

  BuildContext get context => context;
  @override
  Size get preferredSize {
    //final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    return Size.fromHeight(70);
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;

    renderTrailing() {
      if (trailing == null) {
        return [Container(width: hp(7), child: Container())];
      }
      return trailing.map((i) {
        return Container(
          // color: Colors.green,
          width: hp(7),
          child: i,
        );
      });
    }

    return PreferredSize(
      preferredSize: Size.fromHeight(hp(9)),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              //border: Border(bottom: BorderSide(color: AppColors.PrimaryBlue)),
              color: AppColors.PrimaryBlue,
              boxShadow: [
                new BoxShadow(
                    color: AppColors.Black,
                    offset: new Offset(-2, 2),
                    blurRadius: 3),
                new BoxShadow(
                    color: AppColors.Black,
                    offset: new Offset(2, 2),
                    blurRadius: 3)
              ],
            ),
            //padding: EdgeInsets.symmetric(horizontal: wp(4)),

            alignment: Alignment.center,
            height: 70,
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    menu
                        ? GestureDetector(
                            onTap: openDrawer,
                            child: Container(
                              // color: Colors.green,
                              margin: EdgeInsets.only(
                                  left: wp(3.5), right: wp(1.5)),
                              width: hp(3),

                              height: hp(3),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/header/sidelist.png',
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ))
                        : Container(
                            // color: Colors.green,
                            width: hp(7),
                            child: leading,
                          ),
                    Padding(
                      padding: EdgeInsets.only(top: hp(0.5)),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: tablet ? wp(1.6) : hp(2.2),
                            color: AppColors.PrimaryWhite,
                            letterSpacing: wp(0.4)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(width: hp(7))
                  ],
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    height: hp(9),
                    // color: Colors.red,
                    child: Row(
                      children: <Widget>[...renderTrailing().toList()],
                    ),
                  ),
                )
              ],
            ),
          ),
          // tablet ? _tabNavigator() : Container()
        ],
      ),
    );
  }
}
