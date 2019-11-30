import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_new_business/widgets/add_new_business_widget.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/buttons/edit_image_button.dart';
import 'package:flutter/material.dart';

//This header widget is used in Employee, Personal and Business Screens

class CommonHeader extends StatelessWidget {
  final bool showButton;
  final bool account;
  final bool create;
  final String text;
  final String imageUrl;
  final Stream streamName;
  final String id;
  final Function onchange;
  final Function backTap;
  CommonHeader(
      {this.showButton = true,
      this.account = false,
      this.create = false,
      this.imageUrl = "",
      this.text = "Company Name",
      this.streamName,
      this.onchange,
      this.backTap,
      this.id});

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    print(account);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.55 : width * 0.85;
    var layoutHeight = tablet ? height * 0.80 : height * 0.8;

    Widget name() {
      return Padding(
        padding: EdgeInsets.only(
            top: tablet ? hp(1.8) : wp(4), bottom: tablet ? hp(2) : wp(3)),
        child: StreamBuilder<String>(
            stream: streamName,
            builder: (context, snapshot) {
              return Text(
                snapshot.hasData ? snapshot.data : text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: tablet ? hp(2.6) : wp(5),
                    color: AppColors.DarkGray),
              );
            }),
      );
    }

    Widget clockButtons() {
      return Container(
        margin: EdgeInsets.only(bottom: hp(1.2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            tablet
                ? SizedBox(
                    width: wp(5),
                  )
                : Container(),
            Expanded(
              child: ButtonGradient(
                title: 'CLOCK IN',
                letterSpacing: 0,
                borderRadius: hp(tablet ? 1.7 : 1),
                primaryColor: tablet
                    ? AppColors.ClockInPrimaryT
                    : AppColors.ClockInPrimary,
                secondaryColor: tablet
                    ? AppColors.ClockInSecondaryT
                    : AppColors.ClockInSecondary,
                fontSize: tablet ? hp(2.1) : wp(3.4),
                paddingVertical: hp(1.5),
              ),
            ),
            SizedBox(
              width: tablet ? wp(2.5) : wp(2),
            ),
            Expanded(
              child: ButtonGradient(
                title: 'TAKE A BREAK',
                letterSpacing: 0,
                primaryColor: Color(0xFF011C72),
                paddingHorizontal: tablet ? hp(1) : wp(2),
                borderRadius: hp(tablet ? 1.7 : 1),
                secondaryColor: Color(0xFF0056B8),
                fontSize: tablet ? hp(2.1) : wp(3.4),
                paddingVertical: hp(1.5),
              ),
            ),
            SizedBox(
              width: tablet ? wp(2.5) : wp(2),
            ),
            Expanded(
              child: ButtonGradient(
                title: 'CLOCK OUT',
                letterSpacing: 0,
                borderRadius: hp(tablet ? 1.7 : 1),
                primaryColor: tablet
                    ? AppColors.ClockOutPrimaryT
                    : AppColors.ClockOutPrimary,
                secondaryColor: tablet
                    ? AppColors.ClockOutPrimaryT
                    : AppColors.ClockOutPrimary,
                fontSize: tablet ? hp(2.1) : wp(3.4),
                paddingVertical: hp(1.5),
              ),
            ),
            tablet
                ? SizedBox(
                    width: wp(5),
                  )
                : Container(),

            /* ButtonGradiant(
              tablet ? hp(1.5) : hp(1.5),
              tablet ? wp(12.5) : wp(33.5),
              'CLOCK IN',
              borderRadius: tablet ? hp(2) : hp(1.3),
              primaryColor:
                  tablet ? AppColors.ClockInPrimaryT : AppColors.ClockInPrimary,
              secondaryColor: tablet
                  ? AppColors.ClockInSecondaryT
                  : AppColors.ClockInSecondary,
              textStyle: TextStyle(
                  fontSize: tablet ? hp(2.1) : wp(3.6),
                  color: AppColors.PrimaryWhite,
                  fontWeight: FontWeight.w600),
              onPressed: () {},
            ),
            SizedBox(
              width: tablet ? hp(6) : wp(8),
            ),
            ButtonGradiant(
              tablet ? hp(1.5) : hp(1.5),
              tablet ? wp(12.5) : wp(33.5),
              'TAKE A BREAK',
              borderRadius: tablet ? hp(2) : hp(1.3),
              primaryColor:
                  tablet ? AppColors.ClockInPrimaryT : AppColors.ClockInPrimary,
              secondaryColor: tablet
                  ? AppColors.ClockInSecondaryT
                  : AppColors.ClockInSecondary,
              textStyle: TextStyle(
                  fontSize: tablet ? hp(2.1) : wp(3.6),
                  color: AppColors.PrimaryWhite,
                  fontWeight: FontWeight.w600),
              onPressed: () {},
            ),
            SizedBox(
              width: tablet ? hp(6) : wp(8),
            ),
            ButtonGradiant(
              tablet ? hp(1.5) : hp(1.5),
              tablet ? wp(12.5) : wp(33.5),
              'CLOCK OUT',
              borderRadius: tablet ? hp(2) : hp(1.3),
              primaryColor:
                  tablet ? AppColors.ClockOutPrimaryT : AppColors.ClockOutPrimary,
              secondaryColor: tablet
                  ? AppColors.ClockOutSecondaryT
                  : AppColors.ClockOutSecondary,
              textStyle: TextStyle(
                  fontSize: tablet ? hp(2.1) : wp(3.6),
                  color: AppColors.PrimaryWhite,
                  fontWeight: FontWeight.w600),
              onPressed: () {},
            ), */
          ],
        ),
      );
    }

    Widget AddEmployee() {
      return Column(
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: hp(2)),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: tablet ? wp(2) : wp(4), vertical: hp(2.6)),
            decoration: BoxDecoration(
              color: AppColors.PrimaryWhite,
              image: DecorationImage(
                image: AssetImage('assets/splashscreen/background.png'),
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                    color: AppColors.DarkGray.withOpacity(0.4),
                    offset: Offset(0, 4.0),
                    blurRadius: 3.0)
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: hp(0.5)),
                  height: tablet ? hp(15) : hp(11),
                  width: tablet ? hp(15) : hp(11),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(
                            tablet ? hp(7.5) : hp(6),
                          ),
                          child: Image.asset(
                            'assets/employee/userplaceholder.png',
                            color: AppColors.Black.withOpacity(0.21),
                          )),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Image.asset(
                          'assets/my_account/Edit.png',
                          height: tablet ? hp(4.4) : hp(4),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: hp(1.3),
                ),
                Text(
                  "Full Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: tablet ? hp(2.5) : wp(4.6),
                      color: AppColors.DarkGray),
                ),
                // ProfileImageButton(
                //   account: account,
                //   size: tablet ? hp(15) : hp(10),
                // ),
                // name(),
              ],
            ),
          ),
          SizedBox(
            height: hp(1),
          ),
        ],
      );
    }

    Widget Employee() {
      return Container(
        // margin: EdgeInsets.only(top: hp(2)),
        padding: EdgeInsets.symmetric(
            horizontal: tablet ? wp(2) : wp(4),
            vertical: tablet ? hp(0) : hp(0)),
        decoration: BoxDecoration(
          color: AppColors.PrimaryWhite,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/loginscreen/white_background.png'),
          ),
          boxShadow: [
            BoxShadow(
                color: AppColors.DarkGray.withOpacity(0.4),
                offset: Offset(0.5, tablet ? 5.0 : 2.0),
                blurRadius: 1.0)
          ],
          borderRadius: BorderRadius.circular(tablet ? hp(0) : hp(0)),
          //border: new Border.all(width: borderWidth, color: borderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: hp(tablet? 0 : 1)),
              alignment: Alignment.centerLeft,
              child: tablet
                  ? backTap != null
                      ? GestureDetector(
                          onTap: backTap,
                          child: Container(
                            height: hp(2.4),
                            width: hp(2.4),
                            color: AppColors.DarkGray,
                          ))
                      : SizedBox(
                          height: tablet ? hp(3) : hp(2),
                        )
                  : SizedBox(
                      height: tablet ? hp(3) : hp(2),
                    ),
            ),
            ProfileImageButton(
                account: account,
                size: tablet ? hp(5) : hp(10),
                imageUrl: imageUrl,
                id: id,
                onchange: onchange),
            name(),
            showButton ? clockButtons() : SizedBox(),
            SizedBox(
              height: tablet? 0 : hp(1),
            )
          ],
        ),
      );
    }

    return create ? AddEmployee() : Employee();
  }
}
