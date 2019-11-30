import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_checkbox.dart';
import 'package:flutter/material.dart';

class CheckWithLabel extends StatelessWidget {
  const CheckWithLabel({
    Key key,
    @required this.hp,
    this.tablet = false,
    this.checked = false,
    this.label2,
    this.margin,
    this.radio = false,
    @required this.label,
  }) : super(key: key);

  final Function hp;
  final String label;
  final String label2;
  final bool tablet;
  final bool checked;
  final bool radio;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final wp = ScreenUtils.of(context).wp;

    return Container(
      // alignment: Alignment.topLeft,
      margin: margin != null
          ? margin
          : EdgeInsets.only(bottom: tablet ? hp(3) : wp(4)),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: hp(2)),
            child: radio
                ? EpaisaRadioBox(
                    size: tablet ? hp(2.5) : wp(5),
                    hp: hp,
                    tablet: tablet,
                    checked: checked,
                  )
                : EpaisaCheckBox(
                    size: tablet ? hp(2.5) : wp(5),
                    hp: hp,
                    tablet: tablet,
                    checked: checked,
                  ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: AppColors.PrimaryBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: tablet ? hp(2.3) : wp(3.2),
                ),
              ),
              if (label2 != null)
                Text(
                  label2,
                  style: TextStyle(
                    color: AppColors.PrimaryBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: tablet ? hp(2.2) : wp(3.2),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
