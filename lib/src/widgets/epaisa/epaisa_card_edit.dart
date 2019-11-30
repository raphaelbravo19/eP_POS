import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class EpaisaCardEdit extends StatelessWidget {
  final bool tablet;
  final Function hp;
  final Widget child;
  EpaisaCardEdit({
    this.tablet = false,
    @required this.hp,
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: tablet
          ? EdgeInsets.fromLTRB(hp(3), hp(0), hp(3), hp(3))
          : EdgeInsets.all(hp(1.5)),
      child: Container(
        alignment: Alignment.center,
        padding: tablet
            ? EdgeInsets.symmetric(
                horizontal: hp(3.2),
                vertical: hp(2.5),
              )
            : EdgeInsets.all(
                tablet ? hp(3.2) : hp(1.5),
              ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(hp(1.2)),
          color: AppColors.PrimaryWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.5),
              offset: Offset(0.3, 2.0),
              blurRadius: 2.0,
            ),
            BoxShadow(
              color: AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.5),
              offset: Offset(-0.6, 0),
              blurRadius: 1.0,
            )
          ],
        ),
        child: child,
      ),
    );
  }
}
