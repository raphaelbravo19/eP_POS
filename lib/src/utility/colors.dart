import 'package:flutter/material.dart';

class AppColors {
  static const PrimaryWhite = Color(0xFFFFFFFF); //#FFFFFF
  static const LightDarkWhite = Color(0xFFF6F7FB); //#F6F7FB
  static const DarkWhite = Color(0xFFF5F5F5); //#F5F5F5
  static const DisabledBorder = Color(0xFFEBEBEB); //#EBEBEB
  static const Gray = Color(0xFFD8D8D8); //#D8D8D8
  static const IconGray = Color(0xFFBDC1CD); //#BDC1CD
  static const TextLightGray = Color(0xFF808080); //#808080
  static const LightGray = Color(0xFFAAAAAA); //#AAAAAA
  static const DisabledText = Color(0xFF6B6B6B); //#6B6B6B
  static const TermsGray = Color(0xFF666666); //#666666
  static const TextGray = Color(0xFF5D6770); //#5D6770
  static const DarkGray = Color(0xFF52565F); //#52565F
  static const IconLightGray = Color(0xFF9B9B9B); //#9b9b9b
  static const IconDarkGray = Color(0xFF47525D); //#47525D
  static const BackPrimaryGray = Color(0xFF474747); //#474747
  static const BorderGray = Color(0xFF979797); //#979797
  static const BackSecondGray = Color(0xFF333333); //#333333
  static const Black = Color(0xFF373E44); //#373E44
  static const IconLightGreen = Color(0xFFCFF1E8); //#CFF1E8
  static const SuccessText = Color(0xFF09BA83); //#09BA83
  static const TabletClockinPrimary = Color(0xFF09BA83); //#09BA83
  static const TabletClockinSecondary = Color(0xFF00CF8E); //##00CF8E
  static const LightGreen = Color(0xFFB8E986); //#B8E986
  static const NotificationGreen = Color(0xFF2EBD41); //#2EBD41
  static const FocusBoxBlue = Color(0xFF0091FF); //#0091FF
  static const SecondBlue = Color(0xFF0079AA); //#0079AA
  static const LightBlue = Color(0xFF50E3C2); //#50E3C2
  static const LightYellow = Color(0xFFFFF576); //##FFF576
  static const PrimaryBlue = Color(0xFF174285); //#174285
  static const FocusText = Color(0xFF174285); //#174285
  static const IconLightBlue = Color(0xFF747AA0); //#747AA0
  static const LightRed = Color(0xFFFFB4C2); //#FFB4C2
  static const LightPink = Color(0xFFF6EAFF); //#F6EAFF
  static const ErrorText = Color(0xFFD0021B); //#D0021B
  static const LightOrange = Color(0xFFFFBD83); //#FFBD83
  static const DiscountText = Color(0xFFFF6000); //#FF6000
  static const SettingArrow = Color(0x8A000000); //#8A000000
  static const ClockInPrimaryT = Color(0xFF09BA83); //#8A000000
  static const ClockInSecondaryT = Color(0xFF00CF8E); //#8A000000
  static const ClockOutPrimaryT = Color(0xFFD32F2F); //#8A000000
  static const ClockOutSecondaryT = Color(0xFFFF6659); //#8A000000
  static const ClockInPrimary = Color(0xFF9DE686); //#9DE686
  static const ClockInSecondary = Color(0xFF2FAD66); //#F2FAD66
  static const ClockOutPrimary = Color(0xFFD32F2F); //#D32F2F
  static const ClockOutSecondary = Color(0xFFFF6659); //#FF6659
  static const NoPrinterText = Color(0xFF888888); //#FF888888
  static const MagicColor = Color(0xFF63358F); //#63358F
  static const RowGreen = Color(0xFF85DDC2); //#85DDC2
  static const sideArrowColor = Color(0X33000000); //#33000000
  static const notificationTypeTextColor = Color(0XFF202225); //#202225
  static const RowBlue = Color(0xFF8AA0E7);
  static const RowGray = Color(0xFFDDDDDD);
  static const BlueGray = Color(0xFF737A92);
}

const List<Color> baseColors = [
  Color(0xFF005005), //#005005
  Color(0xFFD32F2F), //#D32F2F
  Color(0xFF723207), //#723207
  Color(0xFF2557A4), //#2557A4
  Color(0xFFF7B500), //#F7B500
  Color(0xFFDDFD36), //#DDFD36
  Color(0xFFB620E0), //#B620E0
  Color(0xFF52565F), //#52565F
  Color(0xFF6236FF), //#6236FF
  Color(0xFF44D7B6), //#44D7B6
  Color(0xFF32C5FF), //#32C5FF
];

class TransactionColors {
  static const Approved = Color(0xFF43C141); //##43C141

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
