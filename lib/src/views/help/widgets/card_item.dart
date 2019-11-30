import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String title;
  final double fontSize;
  final Widget icon;
  final Function onTap;
  final bool showForwardArrow;
  final Widget otherWidget;
  final Color arrowColor;
  final double horizontalTabletCard;
  final double horizontalMobileCard;
  final double verticalTabletCard;
  final double verticalMobileCard;
  final int spaceBeforeTextMobile;
  final double borderRadiusValue;
  final double borderMobileRadiusValue;
  final Color cardColor;
  final Color textColor;
  final bool isIcon;
  final bool businessCard;
  final bool extraPaddingRight;
  CardItem({
    this.businessCard = false,
    this.title = "",
    this.icon,
    @required this.fontSize,
    this.onTap,
    this.arrowColor,
    this.horizontalMobileCard,
    this.horizontalTabletCard,
    this.verticalMobileCard,
    this.verticalTabletCard,
    this.spaceBeforeTextMobile,
    this.borderRadiusValue,
    this.borderMobileRadiusValue,
    this.cardColor,
    this.textColor,
    this.showForwardArrow = true,
    this.otherWidget,
    this.extraPaddingRight = true,
    this.isIcon = true,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: tablet
                ? wp(horizontalTabletCard != null
                    ? horizontalTabletCard
                    : businessCard ? 2.7 : 2)
                : wp(horizontalMobileCard != null
                    ? horizontalMobileCard
                    : businessCard ? 4.9 : 4),
            vertical: tablet
                ? wp(verticalTabletCard ?? 2)
                : hp(verticalMobileCard ?? 1.4)),
        decoration: BoxDecoration(
          color: cardColor ?? AppColors.PrimaryWhite,
          border: Border.all(color: Colors.grey, width: 0.1),
          image: DecorationImage(
            image: AssetImage('assets/splashscreen/background.png'),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.DarkGray.withOpacity(0.4),
              offset: Offset(0.5, 2.0),
              blurRadius: 1.0,
            )
          ],
          borderRadius: BorderRadius.circular(tablet
              ? hp(borderRadiusValue ?? 0)
              : hp(borderMobileRadiusValue ?? 1)),
          //border: new Border.all(width: borderWidth, color: borderColor),
        ),
        child: Row(
          children: <Widget>[
            icon != null ? icon : SizedBox(),
            icon != null
                ? SizedBox(
                    width: tablet
                        ? wp(isIcon ? 2 : 0)
                        : wp(spaceBeforeTextMobile ?? 6),
                  )
                : SizedBox(),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: fontSize != null ? fontSize : 15,
                  fontWeight: FontWeight.w700,
                  color: textColor ?? AppColors.DarkGray,
                ),
              ),
            ),
            showForwardArrow
                ? Icon(Icons.arrow_forward_ios,
                    color:
                        arrowColor ?? AppColors.DisabledText.withOpacity(0.4))
                : SizedBox(),
            otherWidget ?? SizedBox(),
            SizedBox(
              width: tablet ? wp(0) : extraPaddingRight ? wp(3) : 0,
            ),
          ],
        ),
      ),
    );
  }
}
