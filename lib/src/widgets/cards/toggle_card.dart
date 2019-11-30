import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/login/widgets/background_image.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:flutter/material.dart';

class ToggleCard extends StatefulWidget {
  final String description;
  final double paddingVertical;
  final double paddingHorizontal;
  final double fontSize;
  final double letterSpacing;
  final double toggleSize;
  final double spaceBeforeDesc;
  final double sized;
  final Function onChanged;
  final bool background;
  final bool initial;
  ToggleCard(
      {Key key,
      this.description,
      this.letterSpacing,
      this.paddingHorizontal,
      this.paddingVertical,
      this.fontSize,
      this.spaceBeforeDesc,
      this.sized,
      this.toggleSize = 0,
      this.onChanged,
      this.initial = false,
      this.background = true})
      : super(key: key);

  @override
  ToggleCardState createState() => ToggleCardState();
}

class ToggleCardState extends State<ToggleCard> {
  GlobalKey<ButtonToggleState> toggle = GlobalKey<ButtonToggleState>();

  void change(val) {
    toggle.currentState.toggleButton(val);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.PrimaryWhite,
        image: widget.background? DecorationImage(
          image: AssetImage('assets/splashscreen/background.png'),
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ) : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.DarkGray.withOpacity(0.4),
            offset: Offset(0.5, 2.0),
            blurRadius: 1.0,
          )
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: widget.paddingHorizontal,
        vertical: widget.paddingVertical,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: widget.spaceBeforeDesc ?? 0),
            child: Text(
              widget.description,
              style: TextStyle(
                color: AppColors.DarkGray,
                fontWeight: FontWeight.w700,
                fontSize: widget.fontSize,
                letterSpacing: widget.letterSpacing,
              ),
            ),
          ),
          ButtonToggle(
            key: toggle,
            size: widget.toggleSize,
            initial: widget.initial,
            paddingRight: widget.sized != null ? widget.sized : 0,
            onChanged: (bool value) {
              if (widget.onChanged != null) {
                widget.onChanged(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
