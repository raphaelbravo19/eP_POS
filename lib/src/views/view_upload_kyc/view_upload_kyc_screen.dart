import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_new_business/add_business_screen.dart';
import 'package:epaisa_pos/src/views/add_new_business/widgets/add_new_business_widget.dart';
import 'package:epaisa_pos/src/views/add_new_stores/widgets/add_stores_widget.dart';
import 'package:epaisa_pos/src/views/business_details/widgets/business_details_widget.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/view_upload_kyc/widgets/view_upload_kyc_widget.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewUploadKycScreen extends StatelessWidget {
  final bool showViewButton;
  final Function onUpload;
  final Function onShow;
  final AddBusinessBloc bloc;
  ViewUploadKycScreen(
      {this.showViewButton = false, this.onUpload, this.bloc, this.onShow});

  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    return buildEpaisaScaffold(context, tablet);
  }

  EpaisaScaffold buildEpaisaScaffold(BuildContext context, bool tablet) {
    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        backasClose: true,
        back: true,
        thick: true,
        title: showViewButton ? 'VIEW KYC' : 'UPLOAD KYC',
      ),
      body: ViewUploadKycWidget(
          showViewButton: showViewButton,
          onUpload: onUpload,
          onShow: onShow,
          bloc: bloc),
    );
  }
}
