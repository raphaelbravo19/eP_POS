import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpFields extends StatefulWidget {
  final String label;
  final int cant;
  OtpFields({this.label = "Insert OTP", this.cant = 4});
  @override
  _OtpFieldsState createState() => _OtpFieldsState();
}

class _OtpFieldsState extends State<OtpFields> {
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    Widget _field(bool left) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(wp(0.5), hp(0.3), 0, hp(0.3)),
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    width: left ? 1 : 0,
                    color: AppColors.PrimaryBlue.withOpacity(left ? 0.7 : 0)))),
        width: tablet ? wp(5) : wp(13),
        child: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            decoration: InputDecoration.collapsed(),
            style: TextStyle(
                fontSize: tablet ? hp(5) : hp(4.3),
                fontWeight: FontWeight.w600,
                color: AppColors.TermsGray.withOpacity(0.9))),
      );
    }

    Widget _fields(int cant) {
      List<Widget> fields = new List<Widget>();
      for (var i = 0; i < cant - 1; i++) {
        fields.add(_field(true));
      }
      return Row(
        children: <Widget>[_field(false), ...fields],
      );
    }

    return Column(
      children: <Widget>[
        Text(
          widget.label,
          style: TextStyle(
              color: AppColors.DarkGray,
              fontSize: tablet ? hp(2.4) : hp(2),
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: hp(1),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.PrimaryWhite,
                  borderRadius: BorderRadius.circular(hp(0.5)),
                  boxShadow: [
                    BoxShadow(
                        color:
                            AppColors.DarkGray.withOpacity(tablet ? 0.6 : 0.5),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 2.0),
                  ],
                  border: Border.all(
                      width: 1, color: AppColors.PrimaryBlue.withOpacity(0.7))),
              child: _fields(widget.cant),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        )
      ],
    );
  }
}
