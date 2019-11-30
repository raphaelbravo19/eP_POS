import 'dart:io';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/help/learn_more/learn_more_screen.dart';
import 'package:epaisa_pos/src/views/help/live_chat/live_chat_screen.dart';
import 'package:epaisa_pos/src/views/help/support/support_screen.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/views/login/widgets/background_image.dart';
import 'package:epaisa_pos/src/views/screen_with_side/screen_with_side.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelpScreen extends StatefulWidget {
  static const platform = const MethodChannel('com.epaisa.posf/tv');

  HelpScreen({this.index = -1});
  final int index;
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  int indexSelected;

  Future<void> _startTV() async {
    try {
      final int result = await HelpScreen.platform.invokeMethod('register');
      print('Battery level at $result % .');
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
    }
  }

  @override
  void initState() {
    indexSelected = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    Widget _buildButtons() {
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: hp(2)),
              padding: EdgeInsets.symmetric(horizontal: tablet ? wp(3) : wp(6)),
              child: ButtonBorder(
                elevation: 0,
                borderColor: AppColors.BorderGray.withOpacity(0.8),
                borderRadius: hp(6),
                fontSize: hp(1.9),
                fontWeight: FontWeight.w700,
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LearnMoreScreen()));
                },
                title: "LEARN MORE",
                paddingVertical: hp(2.5),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: tablet ? 0 : wp(2)),
                      child: CardItem(
                        cardColor:
                            indexSelected == 0 ? AppColors.IconDarkGray : null,
                        textColor:
                            indexSelected == 0 ? AppColors.PrimaryWhite : null,
                        arrowColor: indexSelected == 0
                            ? AppColors.PrimaryWhite
                            : AppColors.SettingArrow,
                        onTap: () {
                          print("Hola");
                          tablet
                              ? setState(() {
                                  indexSelected = 0;
                                })
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SupportScreen()));
                        },
                        fontSize: tablet ? hp(2.3) : wp(4.2),
                        verticalTabletCard: hp(0.16),
                        icon: Image.asset(
                          "assets/help/support.png",
                          height: hp(6.4),
                        ),
                        title: "Support",
                      )),
                  SizedBox(
                    height: hp(1.5),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: tablet ? 0 : wp(2)),
                      child: CardItem(
                        cardColor:
                            indexSelected == 1 ? AppColors.IconDarkGray : null,
                        textColor:
                            indexSelected == 1 ? AppColors.PrimaryWhite : null,
                        arrowColor: indexSelected == 1
                            ? AppColors.PrimaryWhite
                            : AppColors.SettingArrow,
                        onTap: () {
                          print("Hola");
                          tablet
                              ? setState(() {
                                  indexSelected = 1;
                                })
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LiveChatScreen()));
                        },
                        fontSize: tablet ? hp(2.3) : wp(4.2),
                        verticalTabletCard: hp(0.16),
                        icon: Image.asset(
                          "assets/help/live_chat.png",
                          height: hp(6.4),
                        ),
                        title: "Live Chat",
                      )),
                  SizedBox(
                    height: hp(1.5),
                  ),
                  if (Platform.isAndroid)
                    GestureDetector(
                      onTap: () {
                        _startTV();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: tablet ? 0 : wp(2)),
                        child: CardItem(
                          arrowColor: AppColors.SettingArrow,
                          fontSize: tablet ? hp(2.3) : wp(4.2),
                          verticalTabletCard: hp(0.16),
                          icon: Image.asset(
                            "assets/help/teamviewer.png",
                            height: hp(6.4),
                          ),
                          title: "TeamViewer Support",
                        ),
                      ),
                    ),
                  Spacer(
                    flex: 1,
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget buildNoWidgetSelectedWidget() {
      return Container(
        decoration: BackgroundImage.buildBackgroundImageWhite(),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: hp(5)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: hp(1)),
                child: Image.asset(
                  "assets/settingIcons/NoSettings.png",
                  height: hp(19.5),
                ),
              ),
              Text(
                "Please select how you want help?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.TermsGray.withOpacity(0.8),
                  fontSize: hp(3),
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget getScreen() {
      switch (indexSelected) {
        case 0:
          return SupportScreen();
        case 1:
          return LiveChatScreen();
        default:
          return buildNoWidgetSelectedWidget();
          break;
      }
    }

    return EpaisaScaffold(
        appBar: EpaisaAppBar(
          openDrawer: () {
            Scaffold.of(context).openDrawer();
          },
          menu: true,
          title: "HELP",
        ),
        body: tablet
            ? ScreenWithSide(
                side: _buildButtons(),
                body: getScreen(),
              )
            : _buildButtons());
  }
}
