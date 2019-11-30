import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/cash_management/widgets/cash_management_widget.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/views/screen_with_cart/screen_with_cart.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CashManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildEpaisaScaffold(context);
  }

  EpaisaScaffold buildEpaisaScaffold(BuildContext context) {

    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        back: true,
        title: 'CASH MANAGEMENT',
      ),
      body: CashManagementWidget()
    );
  }
}
