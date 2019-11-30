import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_new_business/add_business_screen.dart';
import 'package:epaisa_pos/src/views/add_new_stores/add_stores_screen.dart';
import 'package:epaisa_pos/src/views/business/widgets/business_widgets.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/views/personal/widgets/personal_widget.dart';
import 'package:epaisa_pos/src/views/printer/widgets/printer_widget.dart';
import 'package:epaisa_pos/src/views/screen_with_cart/screen_with_cart.dart';
import 'package:epaisa_pos/src/views/setting_screen/widgets/device_list_widget.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/store_details/stores_details_screen.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    return buildEpaisaScaffold(context, tablet);
  }

  EpaisaScaffold buildEpaisaScaffold(BuildContext context, bool tablet) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;

    void choiceAction(String choice) {
      if (choice == PopupOptions.addBusiness) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddNewBusinessScreen();
        }));
      } else if (choice == PopupOptions.addStore) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NewStoresScreen();
        }));
      }
    }

    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        back: true,
        title: 'BUSINESS',
        trailing: <Widget>[
          Container(
            child: PopupMenuButton<String>(
              padding: EdgeInsets.all(0),
              child: Image.asset(
                "assets/header/plusicon.png",
                height: hp(2.4),
                width: hp(2.4),
              ),
              onSelected: choiceAction,
              offset: Offset(0.0, 40.0),
              itemBuilder: (BuildContext context) {
                return PopupOptions.choices.map((String choice) {
                  return PopupMenuItem<String>(
                      value: choice,
                      child: Text(
                        choice,
                        style: TextStyle(
                          color: AppColors.Black,
                          fontSize: wp(4.4),
                          fontWeight: FontWeight.w700,
                        ),
                      ));
                }).toList();
              },
            ),
          )
        ],
      ),
      body: BusinessWidget(),
    );
  }
}

class PopupOptions {
  static const String addBusiness = "Add Business";
  static const String addStore = "Add Store";

  static const List<String> choices = <String>[addBusiness, addStore];
}
