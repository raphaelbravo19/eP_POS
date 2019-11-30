import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_new_business/add_business_screen.dart';
import 'package:epaisa_pos/src/views/add_new_stores/widgets/add_stores_widget.dart';
import 'package:epaisa_pos/src/views/business_details/widgets/business_details_widget.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_classic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessDetailsScreen extends StatefulWidget {
  CurrentCompany company;
  BusinessDetailsScreen({this.company});

  @override
  _BusinessDetailsScreenState createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    return buildEpaisaScaffold(context, tablet);
  }

  GlobalKey<DialogClassicState> dialog = new GlobalKey<DialogClassicState>();

  showConfirm() {
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return DialogClassic(
            key: dialog,
            content: () {
              return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: tablet ? hp(2.5) : hp(2.2),
                      horizontal: tablet ? hp(3) : wp(5)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(hp(1)),
                      border: Border.all(color: AppColors.PrimaryWhite),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.Black.withOpacity(0.4),
                          offset: new Offset(3, 3),
                          blurRadius: 6,
                        )
                      ],
                      color: AppColors.PrimaryWhite),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Confirm",
                        style: TextStyle(
                            fontSize: tablet ? hp(3.6) : wp(5.5),
                            color: AppColors.DarkGray,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: hp(.5),
                      ),
                      Text(
                        "Are you sure you want to\nsave the business?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: tablet ? hp(2.6) : wp(3.5),
                            color: AppColors.DarkGray,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: hp(3.5),
                      ),
                      Container(
                        width: tablet ? hp(45) : wp(55),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: ButtonGradient(
                              callback: () async {
                                dialog.currentState.closeModal();
                                await key.currentState.create();
                              },
                              shadowLevel: 1.5,
                              title: "YES",
                              borderRadius: hp(3),
                              paddingVertical: hp(1.7),
                              fontSize: tablet ? hp(3) : wp(3.5),
                            )),
                            SizedBox(
                              width: wp(2),
                            ),
                            Expanded(
                                child: ButtonGradient(
                              callback: () {
                                dialog.currentState.closeModal();
                                Navigator.pop(context);
                              },
                              shadowLevel: 1.5,
                              title: "NO",
                              borderRadius: hp(3),
                              paddingVertical: hp(1.7),
                              fontSize: tablet ? hp(3) : wp(3.5),
                            ))
                          ],
                        ),
                      )
                    ],
                  ));
            });
      },
    ));
  }

  GlobalKey<BusinessDetailsWidgetState> key =
      GlobalKey<BusinessDetailsWidgetState>();
  EpaisaScaffold buildEpaisaScaffold(BuildContext context, bool tablet) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;

    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        back: true,
        title: 'BUSINESS',
        onTapClose: () {
          showConfirm();
        },
      ),
      body: BusinessDetailsWidget(company: widget.company, key: key),
    );
  }
}
