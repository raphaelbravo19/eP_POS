import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_new_business/add_business_screen.dart';
import 'package:epaisa_pos/src/views/add_new_stores/widgets/add_stores_widget.dart';
import 'package:epaisa_pos/src/views/business/widgets/business_widgets.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/views/personal/widgets/personal_widget.dart';
import 'package:epaisa_pos/src/views/printer/widgets/printer_widget.dart';
import 'package:epaisa_pos/src/views/screen_with_cart/screen_with_cart.dart';
import 'package:epaisa_pos/src/views/setting_screen/widgets/device_list_widget.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewStoresScreen extends StatefulWidget {
  CurrentStore store;
  NewStoresScreen({this.store});
  @override
  _NewStoresScreenState createState() => _NewStoresScreenState();
}

class _NewStoresScreenState extends State<NewStoresScreen> {
  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    return buildEpaisaScaffold(context, tablet);
  }

  GlobalKey<AddStoreWidgetState> key = GlobalKey<AddStoreWidgetState>();
  EpaisaScaffold buildEpaisaScaffold(BuildContext context, bool tablet) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;

    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        back: true,
        title: 'NEW STORE',
        onTapClose: () {
          key.currentState.showConfirm(callback: () {
            Navigator.pop(context);
          });
        },
      ),
      body: AddStoreWidget(
        key: key,
        store: widget.store,
        onBack: () {
          //Navigator.pop(context);
        },
      ),
    );
  }
}
