import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({this.navigate});
  final Function navigate;
  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    var tablet = isTablet(MediaQuery.of(context));

    Widget CardNotification() {
      return Container(
        child: Column(
          children: <Widget>[
            Dismissible(
              key: GlobalKey(),
              child: EpaisaNotification(isTablet: tablet),
            ),
          ],
        ),
      );
    }

    List<Widget> list = new List<Widget>();
    for (var i = 0; i < 7; i++) {
      list.add(CardNotification());
    }
    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        searchIcon: true,
        searchTitle: "notifications",
        menu: true,
        openDrawer: () {
          Scaffold.of(context).openDrawer();
        },
        title: "NOTIFICATIONS",
      ),
      body: Container(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: list,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EpaisaNotification extends StatelessWidget {
  const EpaisaNotification({
    Key key,
    this.isTablet = false,
  }) : super(key: key);

  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: tablet ? hp(1.5) : wp(0)),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: wp(2), right: wp(2)),
            child: EpaisaCard(
              border: true,
              child: Container(
                padding: EdgeInsets.only(
                    top: hp(3), bottom: hp(3), left: hp(0), right: hp(2)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: isTablet ? 15 : 33,
                      child: Container(
                        height: hp(10),
                        padding: EdgeInsets.all(hp(0.5)),
                        child: Image.asset(
                          'assets/general_icons/epaisa_icon.png',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: isTablet ? 85 : 67,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: hp(1.6)),
                              child: Text(
                                'Flat \$100 off next transaction.',
                                style: TextStyle(
                                  fontSize: isTablet ? hp(2.2) : wp(3.5),
                                  color: AppColors.PrimaryBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: hp(1.6)),
                              child: Text(
                                'Use Code ePaisa100 and get flat \$100 off your next transaction',
                                style: TextStyle(
                                  fontSize: isTablet ? hp(2) : wp(3.5),
                                  color: AppColors.BackPrimaryGray,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              '24-Oct-2018',
                              style: TextStyle(
                                fontSize: isTablet ? hp(2.2) : wp(3.8),
                                color: AppColors.DisabledText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: wp(1.3),
            top: -hp(0.5),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              height: hp(1.35),
              width: hp(1.35),
            ),
          ),
        ],
      ),
    );
  }
}
