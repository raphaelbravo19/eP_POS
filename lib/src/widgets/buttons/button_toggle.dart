import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_classic.dart';
import 'package:flutter/material.dart';

class ButtonToggle extends StatefulWidget {
  final double size;
  final Function onChanged;
  final double paddingRight;
  final bool confirmDialog;
  final bool initial;
  ButtonToggle(
      {Key key,
      this.size = 10,
      this.onChanged,
      this.paddingRight = 0,
      this.initial = false,
      this.confirmDialog = false})
      : super(key: key);
  @override
  ButtonToggleState createState() => ButtonToggleState();
}

class ButtonToggleState extends State<ButtonToggle> {
  bool active;
  bool middle;
  @override
  void initState() {
    // TODO: implement initState

    active = widget.initial;
    middle = false;
    super.initState();
  }

  toggleButton(bool value) {
    setState(() {
      active = value;
      middle = false;
    });
  }

  showConfirm() {
    setState(() {
      middle = true;
    });
    GlobalKey<DialogClassicState> dialog = new GlobalKey<DialogClassicState>();
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return DialogClassic(
            key: dialog,
            content: () {
              return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: tablet ? hp(2.5) : hp(2.2),
                      horizontal: tablet ? hp(3) : wp(5)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(hp(1)),
                      border: Border.all(color: AppColors.PrimaryWhite),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.Black.withOpacity(0.4),
                          offset: new Offset(3, 3),
                          blurRadius: 6,
                        )
                      ],
                      color: AppColors.PrimaryWhite),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Confirm",
                        style: TextStyle(
                            fontSize: tablet ? hp(3.6) : wp(5.5),
                            color: AppColors.DarkGray,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: hp(.5),
                      ),
                      Text(
                        "Are you sure you want to\nenable this settings?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: tablet ? hp(2.6) : wp(3.5),
                            color: AppColors.DarkGray,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: hp(3.5),
                      ),
                      Container(
                        width: tablet ? hp(45) : wp(55),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: ButtonGradient(
                              callback: () {
                                toggle();
                                dialog.currentState.closeModal();
                              },
                              shadowLevel: 1.5,
                              title: "YES",
                              borderRadius: hp(3),
                              paddingVertical: hp(1.7),
                              fontSize: tablet ? hp(3) : wp(3.5),
                            )),
                            SizedBox(
                              width: wp(2),
                            ),
                            Expanded(
                                child: ButtonGradient(
                              callback: () {
                                setState(() {
                                  middle = false;
                                });
                                dialog.currentState.closeModal();
                              },
                              shadowLevel: 1.5,
                              title: "NO",
                              borderRadius: hp(3),
                              paddingVertical: hp(1.7),
                              fontSize: tablet ? hp(3) : wp(3.5),
                            ))
                          ],
                        ),
                      )
                    ],
                  ));
            });
      },
    ));
  }

  toggle() {
    if (widget.onChanged != null) widget.onChanged(!active);
    setState(() {
      active = !active;
      middle = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: widget.paddingRight),
      child: GestureDetector(
        onTap: widget.confirmDialog ? showConfirm : toggle,
        child: AnimatedContainer(
          alignment: middle
              ? Alignment.center
              : active ? Alignment.centerRight : Alignment.centerLeft,
          duration: Duration(milliseconds: 100),
          width: widget.size * 3.8,
          height: widget.size * 2.5,
          padding: EdgeInsets.symmetric(horizontal: widget.size * 0.2),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  colors: [
                    // Colors are easy thanks to Flutter's Colors class.
                    active ? AppColors.PrimaryBlue : AppColors.PrimaryWhite,
                    active ? AppColors.SecondBlue : AppColors.PrimaryWhite,
                  ],
                ),
                borderRadius: BorderRadius.circular(widget.size * 1.3)
                //shape: BoxShape.circle,
                ), //*/
            //Colors.red,
            width: widget.size * 2.2,
            height: widget.size * 2.2,
          ),
          decoration: BoxDecoration(
              color: AppColors.LightGray.withOpacity(0.5),
              borderRadius: BorderRadius.circular(widget.size * 2)),
        ),
      ),
    );
  }
}
