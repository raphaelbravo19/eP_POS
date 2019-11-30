import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/check_field.dart';
import 'package:epaisa_pos/src/views/transactions/transactions_screen.dart';
import 'package:epaisa_pos/src/widgets/general/check_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextfieldPassword extends StatefulWidget {
  final String labelText;
  final double fontSize;
  final double paddingBottomInput;
  final bool leftBorder;
  final bool alwaysFocus;
  final Widget customIcon;
  final bool noClear;
  final bool center;
  final bool showValidations;
  final Map validations;
  final Function onSubmit;
  final bool hasError;
  final bool alwaysValidations;
  final Stream<String> stream;
  ValueChanged<String> onChanged;
  TextfieldPassword(
      {Key key,
      this.labelText = '',
      this.fontSize,
      this.paddingBottomInput = 0,
      this.leftBorder = false,
      this.customIcon,
      this.alwaysFocus = false,
      this.noClear = false,
      this.center = false,
      this.onChanged,
      this.alwaysValidations = false,
      this.showValidations = false,
      this.stream,
      this.onSubmit,
      this.hasError = false,
      this.validations = const {
        "length": false,
        "number": false,
        "special": false,
      }})
      : super(key: key);

  @override
  TextfieldPasswordState createState() => TextfieldPasswordState();

  static withDatePicker({
    labelText,
    @required fontSize,
    @required paddingBottomInput,
    leftBorder,
    customIcon,
    alwaysFocus,
    noClear,
    center,
    @required BuildContext ctx,
    @required int firstDate,
    @required int lastDate,
  }) {
    GlobalKey<TextfieldPasswordState> _controller = GlobalKey();
    //
    return TextfieldPassword(
      key: _controller,
      customIcon: GestureDetector(
        onTap: () async {
          final DateTime picked = await showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(firstDate),
            lastDate: DateTime(lastDate),
            footerBuilder: datePickerHeader,
            width: tablet ? wp(45) : wp(80),
            headerBuilder: datePickerHeader,
          );
          if (picked != null) {
            _controller.currentState
                .changeText(DateFormat.yMd().format(picked));
          }
        },
        child: Icon(
          Icons.date_range,
          size: 30,
        ),
      ),
      fontSize: fontSize,
      paddingBottomInput: paddingBottomInput,
      labelText: labelText,
      alwaysFocus: true,
    );
  }
}

class TextfieldPasswordState extends State<TextfieldPassword>
    with SingleTickerProviderStateMixin {
  bool hasFocus = false;
  bool visible = false;
  FocusNode myFocusNode;
  String value = '';
  Animation<double> animation;
  AnimationController controller;
  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    controller = AnimationController(
        duration: const Duration(milliseconds: 120), vsync: this);
    animation =
        Tween<double>(begin: widget.fontSize, end: widget.fontSize * 0.8)
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

  void changeText(String text) {
    myController.text = text;
    value = text;
    if (text != '') {
      setState(() {
        //hasFocus = true;
      });
      controller.forward();
    }
  }

  void changeTextOut(String text) {
    myController.text = text;
    value = text;
    if (text == '') {
      setState(() {
        hasFocus = false;
      });
      controller.reverse();
    }
  }

  void changeFocus() {
    FocusScope.of(context).requestFocus(myFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.stream != null) {
      return StreamBuilder(
          stream: widget.stream,
          builder: (context, snapshot) {
            //print(snapshot);
            bool hasError = snapshot.hasError;
            bool hasData = snapshot.hasData;
            return Container(
                alignment: Alignment.topCenter,
                height: (widget.labelText != ''
                        ? widget.fontSize * 3.5
                        : widget.fontSize * 2.2) +
                    ((hasFocus || widget.alwaysValidations) &&
                            widget.showValidations
                        ? widget.fontSize * 3
                        : 0),
                //(hasError ? widget.fontSize * 1.2 : 0),
                child: Stack(overflow: Overflow.visible, children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: widget.fontSize * 0.2),
                      height: widget.labelText != ''
                          ? widget.fontSize * 3.3
                          : widget.fontSize * 2,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: <Widget>[
                          widget.labelText != ''
                              ? AnimatedContainer(
                                  alignment: Alignment.bottomLeft,
                                  duration: Duration(milliseconds: 120),
                                  margin: EdgeInsets.only(
                                      bottom: widget.alwaysFocus ||
                                              hasFocus ||
                                              value != ''
                                          ? widget.fontSize * 1.8
                                          : 0),
                                  padding: EdgeInsets.only(
                                      bottom: widget.paddingBottomInput,
                                      left: widget.leftBorder
                                          ? widget.paddingBottomInput * 1.2
                                          : 0,
                                      right: hasFocus
                                          ? widget.fontSize * 1.35
                                          : 0),
                                  child: GestureDetector(
                                      child: Row(
                                        crossAxisAlignment:
                                            hasFocus || value != ''
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            widget.labelText,
                                            style: TextStyle(
                                              fontSize: widget.alwaysFocus
                                                  ? widget.fontSize * 0.8
                                                  : animation.value,
                                              fontWeight: FontWeight.w600,
                                              color: hasFocus || value != ''
                                                  ? AppColors.DisabledText
                                                  : AppColors.DisabledText
                                                      .withOpacity(0.9),
                                            ),
                                          ),
                                          if (hasError)
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left:
                                                        widget.fontSize * 0.2),
                                                child: Image.asset(
                                                  'assets/general_icons/alert.png',
                                                  height: widget.fontSize * 0.8,
                                                ))
                                        ],
                                      ),
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(myFocusNode);
                                      }),
                                )
                              : Container(),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                              left: BorderSide(
                                width: widget.leftBorder
                                    ? (hasFocus ? 2.8 : 2)
                                    : 0,
                                color: widget.leftBorder
                                    ? hasError
                                        ? AppColors.ErrorText
                                        : hasFocus
                                            ? AppColors.FocusText
                                            : AppColors.DisabledText
                                                .withOpacity(0.2)
                                    : AppColors.PrimaryWhite,
                              ),
                              bottom: BorderSide(
                                width: hasFocus ? 2.8 : 2,
                                color: hasError
                                    ? AppColors.ErrorText
                                    : hasFocus
                                        ? AppColors.FocusText
                                        : AppColors.DisabledText.withOpacity(
                                            0.2),
                              ),
                            )),
                            padding: EdgeInsets.only(
                                bottom: widget.paddingBottomInput,
                                left: widget.leftBorder
                                    ? widget.paddingBottomInput * 1.2
                                    : 0,
                                right: hasFocus && !widget.noClear
                                    ? widget.fontSize * 1.35
                                    : 0),
                            child: TextField(
                                controller: myController,
                                textAlign: widget.center
                                    ? TextAlign.center
                                    : TextAlign.start,
                                onSubmitted: (str) {
                                  if (widget.onSubmit != null) {
                                    widget.onSubmit();
                                  }
                                },
                                onChanged: (x) {
                                  value = x;
                                  widget.onChanged(x);
                                },
                                obscureText: !visible,
                                focusNode: myFocusNode,
                                style: TextStyle(
                                    color: hasError
                                        ? AppColors.ErrorText
                                        : hasFocus
                                            ? AppColors.FocusText
                                            : AppColors.DisabledText
                                                .withOpacity(0.9),
                                    fontSize: widget.fontSize,
                                    fontWeight: FontWeight.w600),
                                showCursor: true,
                                decoration:
                                    InputDecoration.collapsed(hintText: '')),
                          ),
                          (hasFocus || widget.alwaysFocus) && !widget.noClear
                              ? Positioned(
                                  right: widget.fontSize * 0.1,
                                  bottom: widget.paddingBottomInput * 1.2,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        visible = !visible;
                                      });
                                    },
                                    child: widget.customIcon != null
                                        ? widget.customIcon
                                        : Icon(
                                            visible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: AppColors.DisabledText,
                                            size: widget.fontSize * 1.3,
                                          ),
                                  ),
                                )
                              : Container(),
                          if (!hasFocus && !widget.alwaysFocus && value == '')
                            GestureDetector(
                                child: Container(
                                  color: Colors.white.withOpacity(0),
                                ),
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(myFocusNode);
                                })
                        ],
                      )),
                  widget.showValidations &&
                          (hasFocus || widget.alwaysValidations)
                      ? Positioned(
                          bottom: widget.fontSize * -4,
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: widget.fontSize * 4,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Password must contain -  ",
                                  style: TextStyle(
                                      fontSize: widget.fontSize * 0.65),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        CheckIconValue(
                                          value: (hasData ||
                                                  snapshot.error
                                                          .toString()[0] ==
                                                      '1') &&
                                              snapshot.data != '',
                                          size: widget.fontSize * 0.65,
                                        ),
                                        Text(
                                          " 8 Characters",
                                          style: TextStyle(
                                              fontSize: widget.fontSize * 0.65),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: widget.fontSize * 0.07,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CheckIconValue(
                                          value: (hasData ||
                                                  snapshot.error
                                                          .toString()[1] ==
                                                      '1') &&
                                              snapshot.data != '',
                                          size: widget.fontSize * 0.65,
                                        ),
                                        Text(
                                          " 1 Number",
                                          style: TextStyle(
                                              fontSize: widget.fontSize * 0.65),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: widget.fontSize * 0.07,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CheckIconValue(
                                          value: (hasData ||
                                                  snapshot.error
                                                          .toString()[2] ==
                                                      '1') &&
                                              snapshot.data != '',
                                          size: widget.fontSize * 0.65,
                                        ),
                                        Text(
                                          " 1 Special Character",
                                          style: TextStyle(
                                              fontSize: widget.fontSize * 0.65),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ))
                      : SizedBox()
                ]));
          });
    } else {
      return Container(
          margin: EdgeInsets.only(
              bottom: (widget.fontSize * 0.2) +
                  (widget.showValidations && hasFocus
                      ? widget.fontSize * 3
                      : 0)),
          /*padding: EdgeInsets.only(
            bottom: widget.paddingBottomInput,
            left: widget.leftBorder ? widget.paddingBottomInput * 1.2 : 0),*/
          height: widget.labelText != ''
              ? widget.fontSize * 3.3
              : widget.fontSize * 2,
          /*decoration: BoxDecoration(
            border: Border(
          left: BorderSide(
            width: widget.leftBorder ? (hasFocus ? 2.8 : 2) : 0,
            color: widget.leftBorder
                ? hasFocus
                    ? AppColors.FocusText.withOpacity(0.8)
                    : AppColors.DisabledText.withOpacity(0.2)
                : AppColors.PrimaryWhite,
          ),
          bottom: BorderSide(
            width: hasFocus ? 2.8 : 2,
            color: hasFocus
                ? AppColors.FocusText.withOpacity(0.8)
                : AppColors.DisabledText.withOpacity(0.2),
          ),
        )),*/
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              widget.labelText != ''
                  ? AnimatedContainer(
                      alignment: Alignment.bottomLeft,
                      duration: Duration(milliseconds: 120),
                      margin: EdgeInsets.only(
                          bottom: widget.alwaysFocus || hasFocus || value != ''
                              ? widget.fontSize * 1.8
                              : 0),
                      padding: EdgeInsets.only(
                          bottom: widget.paddingBottomInput,
                          left: widget.leftBorder
                              ? widget.paddingBottomInput * 1.2
                              : 0,
                          right: hasFocus ? widget.fontSize * 1.35 : 0),
                      child: GestureDetector(
                          child: Text(
                            widget.labelText,
                            style: TextStyle(
                              fontSize: widget.alwaysFocus
                                  ? widget.fontSize * 0.7
                                  : animation.value,
                              fontWeight: FontWeight.w600,
                              color: hasFocus || value != ''
                                  ? AppColors.DisabledText
                                  : AppColors.DisabledText.withOpacity(0.9),
                            ),
                          ),
                          onTap: () {
                            FocusScope.of(context).requestFocus(myFocusNode);
                          }),
                    )
                  : Container(),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    width: widget.leftBorder ? (hasFocus ? 2.8 : 2) : 0,
                    color: widget.leftBorder
                        ? hasFocus
                            ? widget.hasError
                                ? AppColors.ErrorText
                                : AppColors.FocusText
                            : AppColors.DisabledText.withOpacity(0.2)
                        : AppColors.PrimaryWhite,
                  ),
                  bottom: BorderSide(
                    width: hasFocus ? 2.8 : 2,
                    color: hasFocus
                        ? widget.hasError
                            ? AppColors.ErrorText
                            : AppColors.FocusText
                        : AppColors.DisabledText.withOpacity(0.2),
                  ),
                )),
                padding: EdgeInsets.only(
                    bottom: widget.paddingBottomInput,
                    left:
                        widget.leftBorder ? widget.paddingBottomInput * 1.2 : 0,
                    right: hasFocus && !widget.noClear
                        ? widget.fontSize * 1.35
                        : 0),
                child: TextField(
                    controller: myController,
                    textAlign:
                        widget.center ? TextAlign.center : TextAlign.start,
                    onChanged: (x) {
                      value = x;
                      if (widget.onChanged != null) {
                        widget.onChanged(x);
                      }
                    },
                    obscureText: !visible,
                    focusNode: myFocusNode,
                    style: TextStyle(
                        color: hasFocus
                            ? widget.hasError
                                ? AppColors.ErrorText
                                : AppColors.FocusText
                            : AppColors.DisabledText.withOpacity(0.9),
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.w600),
                    showCursor: true,
                    decoration: InputDecoration.collapsed(hintText: '')),
              ),
              (hasFocus || widget.alwaysFocus) && !widget.noClear
                  ? Positioned(
                      right: widget.fontSize * 0.1,
                      bottom: widget.paddingBottomInput * 1.2,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                        child: widget.customIcon != null
                            ? widget.customIcon
                            : Icon(
                                visible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.DisabledText,
                                size: widget.fontSize * 1.3,
                              ),
                      ),
                    )
                  : Container(),
              if (!hasFocus && !widget.alwaysFocus && value == '')
                GestureDetector(
                    child: Container(
                      color: Colors.white.withOpacity(0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(myFocusNode);
                    }),
              if (widget.showValidations && hasFocus)
                Positioned(
                    bottom: widget.fontSize * -4.3,
                    child: Container(
                      alignment: Alignment.topLeft,
                      height: widget.fontSize * 4,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Password must contain -  ",
                            style: TextStyle(fontSize: widget.fontSize * 0.65),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CheckIconValue(
                                    value: widget.validations['length'],
                                    size: widget.fontSize * 0.65,
                                  ),
                                  Text(
                                    " 8 Characters",
                                    style: TextStyle(
                                        fontSize: widget.fontSize * 0.65),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: widget.fontSize * 0.07,
                              ),
                              Row(
                                children: <Widget>[
                                  CheckIconValue(
                                    value: widget.validations['number'],
                                    size: widget.fontSize * 0.65,
                                  ),
                                  Text(
                                    " 1 Number",
                                    style: TextStyle(
                                        fontSize: widget.fontSize * 0.65),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: widget.fontSize * 0.07,
                              ),
                              Row(
                                children: <Widget>[
                                  CheckIconValue(
                                    value: widget.validations['special'],
                                    size: widget.fontSize * 0.65,
                                  ),
                                  Text(
                                    " 1 Special Character",
                                    style: TextStyle(
                                      fontSize: widget.fontSize * 0.65,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
            ],
          ));
    }
  }
}
