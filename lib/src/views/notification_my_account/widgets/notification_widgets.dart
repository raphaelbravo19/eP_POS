import 'package:epaisa_pos/src/logic/personal_bloc/personal_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/cards/toggle_card.dart';
import 'package:epaisa_pos/src/widgets/header_card/header_widget.dart';
import 'package:epaisa_pos/src/views/employee/widgets/row_structure.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:flutter/material.dart';

class NotificationsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final personlBloc = PersonalBloc();
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    double fontSize = tablet ? hp(2.8) : hp(2.00);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.55 : width * 0.85;
    var layoutHeight = tablet ? height : height * 0.8;

    Widget paymentNameIconStructure({String paymentIcons, String cardName}) {
      return Column(
        children: <Widget>[
          Image.asset(
            paymentIcons,
            height: tablet ? hp(7.4) : hp(6.4),
          ),
          SizedBox(height: hp(0.7),),
          Text(
            cardName,
            style: TextStyle(
              color: AppColors.notificationTypeTextColor,
              fontWeight: FontWeight.w600,
              fontSize: tablet ? hp(2) : wp(3),
            ),
          )
        ],
      );
    }

    Widget titleLogo({String title, List<Widget> children}) {
      return Padding(
        padding: EdgeInsets.only(left: wp(3), right: wp(3)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: tablet ? hp(1) : wp(5), bottom: tablet ? hp(2) : wp(2)),
              child: Text(title,
                  style: TextStyle(
                    fontWeight: tablet ?  FontWeight.w700 : FontWeight.bold,
                    fontSize: tablet ? hp(2.2) : wp(4),
                    color: AppColors.PrimaryBlue,
                  )),
            ),
            Row(
              mainAxisAlignment: tablet
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.spaceAround,
              children: children,
            )
          ],
        ),
      );
    }

    Widget unSubscribeWidgets() {
      return Padding(
        padding: EdgeInsets.only(
            left: wp(4),
            right: wp(3),
            top: wp(tablet ? 0.8 : 1),
            bottom: wp(tablet ? 0 : 1)),
        child: ToggleCard(
          fontSize: tablet ? hp(2.5) : wp(4.5),
          paddingHorizontal: tablet ? hp(1) : wp(3),
          paddingVertical: tablet ? hp(3) : wp(5),
          spaceBeforeDesc: tablet ? hp(3) : wp(3),
          toggleSize: tablet ? hp(1.9) : wp(2.7),
          sized:  tablet ? hp(1.8) : wp(0),
          description: "Unsubscribe All",
        ),
      );
    }

    Widget title() {
      return Padding(
        padding: EdgeInsets.all(tablet ? hp(4) : wp(7)),
        child: Column(
          children: <Widget>[
            Text(
              "Notifications",
              style: TextStyle(
                color: AppColors.PrimaryBlue,
                fontSize: tablet ? hp(2.7) : wp(5),
                fontWeight: tablet ? FontWeight.w700 : FontWeight.bold ,
              ),
            ),
            Text(
              "Receive Notifications",
              style: TextStyle(
                color: AppColors.DarkGray,
                fontSize: tablet ? hp(2) : wp(3.5),
                fontWeight: tablet ? FontWeight.w600 : FontWeight.bold ,
              ),
            ),
          ],
        ),
      );
    }

    Widget buildNotifications() {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            title(),
            titleLogo(title: "Transaction Notification", children: [
              paymentNameIconStructure(
                  cardName: "In - App",
                  paymentIcons: 'assets/my_account/InApp.png'),
              paymentNameIconStructure(
                  cardName: "Email", paymentIcons: 'assets/employee/Email.png'),
              paymentNameIconStructure(
                  cardName: "SMS", paymentIcons: 'assets/my_account/SMS.png'),
            ]),
            //SizedBox(height: wp(3),),
            Divider(
              color: AppColors.LightGray,
              height: tablet ? hp(6) : wp(10),
            ),
            titleLogo(title: "Summary", children: [
              paymentNameIconStructure(
                  cardName: "In - App",
                  paymentIcons: 'assets/my_account/InApp.png'),
              paymentNameIconStructure(
                  cardName: "Email", paymentIcons: 'assets/employee/Email.png'),
              paymentNameIconStructure(
                  cardName: "SMS", paymentIcons: 'assets/my_account/SMS.png'),
            ]),
            Divider(
              color: AppColors.LightGray,
              height: tablet ? hp(3) : wp(7),
            ),
            titleLogo(title: "Held Transactions", children: [
              paymentNameIconStructure(
                  cardName: "In - App",
                  paymentIcons: 'assets/my_account/InApp.png'),
              paymentNameIconStructure(
                  cardName: "Email", paymentIcons: 'assets/employee/Email.png'),
              paymentNameIconStructure(
                  cardName: "SMS", paymentIcons: 'assets/my_account/SMS.png'),
            ]),
            Divider(
              color: AppColors.LightGray,
              height: tablet ? hp(3) : wp(7),
            ),
            titleLogo(title: "ePaisa Offers", children: [
              paymentNameIconStructure(
                  cardName: "In - App",
                  paymentIcons: 'assets/my_account/InApp.png'),
              paymentNameIconStructure(
                  cardName: "Email", paymentIcons: 'assets/employee/Email.png'),
              paymentNameIconStructure(
                  cardName: "SMS", paymentIcons: 'assets/my_account/SMS.png'),
            ]),
            Divider(
              color: AppColors.LightGray,
              height: tablet ? hp(1) : wp(7),
            ),
            unSubscribeWidgets(),
            SizedBox(
              height: tablet ? hp(2) : wp(2),
            )
            //name(),
          ],
        ),
      );
    }

    return buildNotifications();
  }
}
