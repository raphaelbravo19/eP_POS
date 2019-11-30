import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/card_reader/widgets/card_reader_widget.dart';
import 'package:epaisa_pos/src/views/card_reader/widgets/cash_drawer_widget.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/views/printer/widgets/printer_widget.dart';
import 'package:epaisa_pos/src/views/screen_with_cart/screen_with_cart.dart';
import 'package:epaisa_pos/src/views/setting_screen/widgets/device_list_widget.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CashDrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    return buildEpaisaScaffold(context, tablet);
  }

  EpaisaScaffold buildEpaisaScaffold(BuildContext context, bool tablet) {

    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        back: true,
        title: 'CASH DRAWER',
      ),
      body: CashDrawerWidget(),
    );
  }
}