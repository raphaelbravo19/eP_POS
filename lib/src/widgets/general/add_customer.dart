import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:flutter/material.dart';

class AddCustomer extends StatelessWidget {
  const AddCustomer({
    Key key,
    @required this.hp,
  }) : super(key: key);

  final Function hp;

  @override
  Widget build(BuildContext context) {
    var tablet = isTablet(MediaQuery.of(context));
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;

    return GestureDetector(
      onTap: () => searchCustomer(context, null),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.TextGray,
          borderRadius: tablet
              ? null
              : BorderRadius.only(
                  topRight: Radius.circular(hp(1)),
                  topLeft: Radius.circular(hp(1)),
                ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/general_icons/add_customer.png',
                height: tablet ? hp(3) : hp(3),
              ),
              margin: EdgeInsets.only(right: hp(1)),
            ),
            Text(
              eptxt('add_customer').toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: tablet ? hp(2.3) : wp(4),
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
