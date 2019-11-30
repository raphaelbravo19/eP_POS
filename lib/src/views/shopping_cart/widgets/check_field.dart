import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class CheckField extends StatefulWidget {
  CheckField({this.size = 10, this.text = ""});
  final double size;
  final String text;
  @override
  _CheckFieldState createState() => _CheckFieldState();
}

class _CheckFieldState extends State<CheckField> {
  bool active = true;
  @override
  Widget build(BuildContext context) {
    double size = widget.size;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                active = !active;
              });
            },
            child: Container(
              height: size,
              width: size,
              margin: EdgeInsets.only(right: size * 0.6),
              child: active
                  ? Container(
                      margin: EdgeInsets.all(size * 0.11),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.PrimaryBlue,
                      ),
                    )
                  : Container(),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 2,
                      color: active
                          ? AppColors.PrimaryBlue
                          : AppColors.DisabledText)),
            ),
          ),
          Text(
            widget.text,
            style: TextStyle(
                fontSize: size * 0.8,
                color: active ? AppColors.PrimaryBlue : AppColors.DisabledText,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
