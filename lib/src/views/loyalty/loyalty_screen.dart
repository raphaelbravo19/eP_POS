
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/loyalty/widgets/loyalty_widget.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:flutter/material.dart';

class LoyaltyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    return buildEpaisaScaffold(context, tablet);
  }

  EpaisaScaffold buildEpaisaScaffold(BuildContext context, bool tablet) {

    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        back: true,
        title: 'LOYALTY',
      ),
      body: LoyaltyWidget(),
    );
  }
}