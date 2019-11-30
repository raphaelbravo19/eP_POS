import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_new_stores/widgets/add_stores_widget.dart';
import 'package:epaisa_pos/src/views/notification_my_account/widgets/notification_widgets.dart';
import 'package:epaisa_pos/src/views/reports/widgets/reports_widgets.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    return buildEpaisaScaffold(context, tablet);
  }

  EpaisaScaffold buildEpaisaScaffold(BuildContext context, bool tablet) {

    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        back: true,
        title: 'NOTIFICATIONS',

      ),
      body: NotificationsWidget(),
    );
  }
}
