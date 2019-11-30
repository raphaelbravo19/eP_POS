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
import 'package:epaisa_pos/src/views/store_details/widgets/stores_details_widget.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoresDetailsScreen extends StatefulWidget {
  CurrentStore store;
  StoresDetailsScreen({this.store});

  @override
  _StoresDetailsScreenState createState() => _StoresDetailsScreenState();
}

class _StoresDetailsScreenState extends State<StoresDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    return buildEpaisaScaffold(context, tablet);
  }

  GlobalKey<StoreDetailsWidgetState> key = GlobalKey<StoreDetailsWidgetState>();
  EpaisaScaffold buildEpaisaScaffold(BuildContext context, bool tablet) {
    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        back: true,
        title: 'STORES',
        onTapClose: () {
          key.currentState.showConfirm(callback: () {
            //Navigator.pop(context);
          });
        },
      ),
      body: StoreDetailsWidget(
        store: widget.store,
        key: key,
        onBack: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
