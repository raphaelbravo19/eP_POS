import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/add_promotion_dates_content.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/add_promotion_info_content.dart';
import 'package:epaisa_pos/src/views/promotions/screens/add_promotion_screen/add_promotion_requeriments_content.dart';
import 'package:epaisa_pos/src/widgets/general/tab_navigation_screen.dart';
import 'package:flutter/material.dart';

class AddPromotionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tablet = isTablet(MediaQuery.of(context));
    return TabNavigationScreen(
      title: 'Add Promotion',
      screens: [
        {
          "title": 'Promotion Info',
          "content": tablet
              ? Row(
                  children: <Widget>[
                    Expanded(child: AddPromotionInfoContent()),
                    Expanded(
                      child: Opacity(
                        opacity: 0.5,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            AddPromotionRequerimentsContent(),
                            GestureDetector(
                              child: Container(
                                color: Colors.transparent,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : AddPromotionInfoContent()
        },
        {
          "title": 'Requirements',
          "content": tablet
              ? Row(
                  children: <Widget>[
                    Expanded(child: AddPromotionRequerimentsContent()),
                    Expanded(
                      child: Opacity(
                        opacity: 0.5,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            AddPromotionDatesContent(),
                            GestureDetector(
                              child: Container(
                                color: Colors.transparent,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : AddPromotionRequerimentsContent()
        },
        {
          "title": 'Dates',
          "content": tablet
              ? Row(
                  children: <Widget>[
                    Expanded(
                      child: Opacity(
                        opacity: 0.5,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            AddPromotionRequerimentsContent(),
                            GestureDetector(
                              child: Container(
                                color: Colors.transparent,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: AddPromotionDatesContent())
                  ],
                )
              : AddPromotionDatesContent()
        },
      ],
    );
  }
}
