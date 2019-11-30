import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class TextfieldTaxClassic extends StatefulWidget {
  final String labelText;
  final double fontSize;
  final double paddingBottomInput;
  final bool leftBorder;
  final int flexLeft;
  final int flexRight;
  final double paddingTopInput;
  final bool alwaysBlue;
  TextfieldTaxClassic(
      {this.labelText = '',
      this.fontSize,
      this.paddingBottomInput = 0,
      this.paddingTopInput = 0,
      this.leftBorder = false,
      this.flexLeft: 8,
      this.flexRight: 10,
      this.alwaysBlue = false});

  @override
  _TextfieldTaxClassicState createState() => _TextfieldTaxClassicState();
}

class _TextfieldTaxClassicState extends State<TextfieldTaxClassic>
    with SingleTickerProviderStateMixin {
  bool hasFocus = false;
  FocusNode myFocusNode;
  String value = '';
  Animation<double> animation;
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    controller = AnimationController(
        duration: const Duration(milliseconds: 120), vsync: this);
    animation =
        Tween<double>(begin: widget.fontSize * 0.9, end: widget.fontSize * 0.7)
            .animate(controller);
    animation.addListener(() => setState(() {}));

    myFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    print("Focus: " + myFocusNode.hasFocus.toString());
    if (myFocusNode.hasFocus)
      controller.forward();
    else if (value == '') {
      controller.reverse();
    }
    setState(() {
      hasFocus = myFocusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.labelText != ''
            ? widget.fontSize * 3.5
            : widget.fontSize * 2,
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: hasFocus ? 2.8 : 2,
            color: widget.alwaysBlue
                ? AppColors.PrimaryBlue
                : hasFocus
                    ? AppColors.FocusText.withOpacity(0.8)
                    : AppColors.DisabledText.withOpacity(0.2),
          ),
        )),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            widget.labelText != ''
                ? AnimatedContainer(
                    alignment: Alignment.bottomLeft,
                    duration: Duration(milliseconds: 120),
                    margin: EdgeInsets.only(bottom: widget.fontSize * 2.4),
                    child: GestureDetector(
                        child: Text(
                          widget.labelText,
                          style: TextStyle(
                              fontSize: widget.fontSize * 0.75,
                              fontWeight: FontWeight.w700,
                              color: hasFocus || value != ''
                                  ? AppColors.DisabledText
                                  : AppColors.DisabledText.withOpacity(0.8)),
                        ),
                        onTap: () {
                          FocusScope.of(context).requestFocus(myFocusNode);
                        }),
                  )
                : Container(),
            Container(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: widget.flexLeft,
                      child: Container(
                        padding: EdgeInsets.only(
                            top: widget.paddingTopInput,
                            left: widget.paddingBottomInput,
                            right: widget.paddingBottomInput,
                            bottom: widget.paddingBottomInput * 0.6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("%",
                                style: TextStyle(
                                    color: widget.alwaysBlue
                                        ? AppColors.PrimaryBlue
                                        : hasFocus
                                            ? AppColors.FocusText.withOpacity(
                                                0.8)
                                            : AppColors.DisabledText
                                                .withOpacity(0.9),
                                    fontSize: widget.fontSize,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      )),
                  Expanded(
                    flex: widget.flexRight,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        left: BorderSide(
                          width: hasFocus ? 2 : 2,
                          color: widget.alwaysBlue
                              ? AppColors.PrimaryBlue
                              : hasFocus
                                  ? AppColors.FocusText.withOpacity(0.8)
                                  : AppColors.DisabledText.withOpacity(0.2),
                        ),
                      )),
                      padding: EdgeInsets.only(
                          top: widget.paddingTopInput,
                          bottom: widget.paddingBottomInput * 0.6,
                          left: widget.paddingBottomInput * 1.3,
                          right: hasFocus ? widget.fontSize * 1.35 : 0),
                      child: TextField(
                          onChanged: (x) => value = x,
                          focusNode: myFocusNode,
                          style: TextStyle(
                              color: widget.alwaysBlue
                                  ? AppColors.PrimaryBlue
                                  : hasFocus
                                      ? AppColors.FocusText.withOpacity(0.8)
                                      : AppColors.DisabledText.withOpacity(0.9),
                              fontSize: widget.fontSize,
                              fontWeight: FontWeight.w700),
                          showCursor: true,
                          decoration: InputDecoration.collapsed(hintText: '')),
                    ),
                  ),
                ],
              ),
            ),
            hasFocus
                ? Positioned(
                    right: widget.fontSize * 0.1,
                    bottom: hasFocus || value != ''
                        ? widget.paddingBottomInput - widget.paddingTopInput
                        : 0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.cancel,
                        color: AppColors.DisabledText,
                        size: widget.fontSize * 1.15,
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }
}
