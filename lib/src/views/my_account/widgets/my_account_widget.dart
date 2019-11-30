import 'package:epaisa_pos/src/logic/my_account_bloc/my_account_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/business/business_screen.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/views/login/widgets/background_image.dart';
import 'package:epaisa_pos/src/views/personal/personal_screen.dart';
import 'package:epaisa_pos/src/views/reports/reports_screen.dart';
import 'package:flutter/material.dart';

class MyAccountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final myAccountBloc = MyAccountBloc();

    Widget card(
        {String title,
        String iconPath,
        Widget screenName,
        Function onTap,
        Color cardColor,
        Color textColor,
        Color arrowColor}) {
      return Container(
          padding: EdgeInsets.only(
              top: tablet ? wp(1) : wp(3),
              left: tablet ? wp(0) : wp(2),
              right: tablet ? wp(0) : wp(2)),
          child: CardItem(
            onTap: onTap ??
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => screenName),
                  );
                },
            fontSize: hp(2.3),
            cardColor: cardColor,
            verticalTabletCard: 1,
            textColor: textColor,
            arrowColor: arrowColor ?? AppColors.SettingArrow,
            icon: Image.asset(
              iconPath,
              height: hp(6.4),
            ),
            title: title,
          ));
    }

    Widget myAccountOptionList() {
      return StreamBuilder<String>(
          stream: myAccountBloc.selectedMyAccountOptionStream,
          builder: (context, snapshotSettingName) {
            return Container(
              height: MediaQuery.of(context).size.height,
              decoration: BackgroundImage.buildBackgroundImageWhite(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    children: <Widget>[
                      card(
                          title: "Personal",
                          iconPath: "assets/my_account/Personal.png",
                          cardColor: snapshotSettingName.data == "Personal"
                              ? AppColors.IconDarkGray
                              : null,
                          textColor: snapshotSettingName.data == "Personal"
                              ? AppColors.PrimaryWhite
                              : null,
                          arrowColor: snapshotSettingName.data == "Personal"
                              ? AppColors.PrimaryWhite
                              : null,
                          onTap: () {
                            tablet
                                ? myAccountBloc.selectedMyAccountOptionSink
                                    .add("Personal")
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PersonalScreen()));
                          }),
                      card(
                          title: "Business",
                          iconPath: "assets/my_account/Business.png",
                          cardColor: snapshotSettingName.data == "Business"
                              ? AppColors.IconDarkGray
                              : null,
                          textColor: snapshotSettingName.data == "Business"
                              ? AppColors.PrimaryWhite
                              : null,
                          arrowColor: snapshotSettingName.data == "Business"
                              ? AppColors.PrimaryWhite
                              : null,
                          onTap: () {
                            tablet
                                ? myAccountBloc.selectedMyAccountOptionSink
                                    .add("Business")
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BusinessScreen()));
                          }),
                      card(
                          title: "Notifications",
                          iconPath: "assets/my_account/Notifications.png",
                          cardColor: snapshotSettingName.data == "Notifications"
                              ? AppColors.IconDarkGray
                              : null,
                          textColor: snapshotSettingName.data == "Notifications"
                              ? AppColors.PrimaryWhite
                              : null,
                          arrowColor:
                              snapshotSettingName.data == "Notifications"
                                  ? AppColors.PrimaryWhite
                                  : null,
                          onTap: () {
                            /*tablet
                            ? myAccountBloc.selectedMyAccountOptionSink
                            .add("Notifications")
                            : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNewBusinessScreen()));*/
                          }),
                      card(
                          title: "Reports",
                          iconPath: "assets/my_account/Reports.png",
                          cardColor: snapshotSettingName.data == "Device"
                              ? AppColors.IconDarkGray
                              : null,
                          textColor: snapshotSettingName.data == "Device"
                              ? AppColors.PrimaryWhite
                              : null,
                          arrowColor: snapshotSettingName.data == "Device"
                              ? AppColors.PrimaryWhite
                              : null,
                          onTap: () {
                            tablet
                                ? myAccountBloc.selectedMyAccountOptionSink
                                .add("Reports")
                                : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportsScreen()));
                          }),
                      card(
                          title: "Passwords",
                          iconPath: "assets/my_account/Password.png",
                          cardColor: snapshotSettingName.data == "Device"
                              ? AppColors.IconDarkGray
                              : null,
                          textColor: snapshotSettingName.data == "Device"
                              ? AppColors.PrimaryWhite
                              : null,
                          arrowColor: snapshotSettingName.data == "Device"
                              ? AppColors.PrimaryWhite
                              : null,
                          onTap: () {}),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    return myAccountOptionList();
  }
}
