import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';

class CustomTextStyles {
  BuildContext context;
  Function hp, wp;
  TextStyle textTitleStyle;
  TextStyle textSubtitleStyle;
  TextStyle textFieldTitleStyle;
  TextStyle textFieldHintStyle;
  TextStyle textFieldContentStyle;
  TextStyle textSearchStyle;
  TextStyle textTableHeaderStyle;
  TextStyle textTableListTitleStyle;
  TextStyle textTableListContentStyle;
  TextStyle textAddButton;
  TextStyle textDeleteButton;
  TextStyle textNoContentPlaceholderTitle;
  TextStyle textNoContentPlaceholderSubtitle;

  CustomTextStyles({@required BuildContext context}) {
    this.context = context;
    wp = ScreenUtils(MediaQuery.of(context).size).wp;
    hp = ScreenUtils(MediaQuery.of(context).size).hp;
    initStyles();
  }

  initStyles() {
    textTitleStyle = Theme.of(context).textTheme.display4.copyWith(
          fontSize: hp(4.92),
          fontWeight: FontWeight.w800,
        );
    textSubtitleStyle = Theme.of(context).textTheme.display4.copyWith(
        fontSize: hp(3.10),
        fontWeight: FontWeight.w600,
        color: Theme.of(context).highlightColor);
    textFieldTitleStyle = Theme.of(context).textTheme.display4.copyWith(
          fontSize: wp(1.34),
          color: Theme.of(context).primaryColorDark,
        );
    textFieldHintStyle = Theme.of(context).textTheme.overline.copyWith(
        fontSize: wp(1.4),
        color: Theme.of(context).dividerColor.withAlpha(120),
        fontWeight: FontWeight.w600);

    textFieldContentStyle = Theme.of(context).textTheme.display3.copyWith(
          fontSize: hp(2.14),
        );
    textSearchStyle = Theme.of(context).textTheme.overline.copyWith(
        fontSize: hp(1.84),
        fontWeight: FontWeight.w800,
        color: Colors.grey[400]);

    textTableHeaderStyle =
        Theme.of(context).textTheme.display4.copyWith(fontSize: hp(2.14));

    textTableListTitleStyle =
        Theme.of(context).textTheme.display4.copyWith(fontSize: hp(2.14));

    textTableListContentStyle = Theme.of(context)
        .textTheme
        .body1
        .copyWith(fontSize: hp(1.74), fontWeight: FontWeight.w300);

    textAddButton = Theme.of(context).textTheme.display4.copyWith(
          fontSize: hp(2.34),
          color: Theme.of(context).primaryColor,
        );

    textDeleteButton = Theme.of(context).textTheme.display4.copyWith(
          fontSize: hp(2.74),
          color: Theme.of(context).primaryColor,
        );

    textNoContentPlaceholderTitle = Theme.of(context)
        .textTheme
        .body1
        .copyWith(fontSize: hp(7.31), fontWeight: FontWeight.w700);

    textNoContentPlaceholderSubtitle =
        Theme.of(context).textTheme.body1.copyWith(fontSize: hp(1.74));
  }
}
