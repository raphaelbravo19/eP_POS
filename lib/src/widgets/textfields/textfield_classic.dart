import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/views/transactions/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class TextfieldClassic extends StatefulWidget {
  final String labelText;
  final double fontSize;
  final String prefixIcon;
  final Function onFocusChange;
  ValueChanged<String> onChanged;
  final double paddingBottomInput;
  final bool leftBorder;
  final bool alwaysFocus;
  final Widget customIcon;
  final Function customIconBuilder;
  final Function onTap;
  final bool noClear;
  final bool center;
  final String hintText;
  final String initialValue;
  final bool showClearButton;
  final bool optional;
  final bool disabled;
  final Stream<String> stream;
  final bool alwaysBlue;
  final double paddingLeft;
  final Function iconLeft;
  final Function onSubmitted;
  final Function animatedItem;
  final bool hasError;
  final bool calendar;
  final bool timer;
  final int firstDate;
  final int lastDate;
  final TextInputType keyType;
  final TextCapitalization toUpperCase;
  TextfieldClassic({
    Key key,
    this.labelText = '',
    this.fontSize,
    this.paddingBottomInput = 0,
    this.leftBorder = false,
    this.customIcon,
    this.customIconBuilder,
    this.hintText = '',
    this.onTap,
    this.disabled = false,
    this.showClearButton = true,
    this.alwaysFocus = false,
    this.noClear = false,
    this.center = false,
    this.optional = false,
    this.onChanged,
    this.onSubmitted,
    this.stream,
    this.paddingLeft,
    this.iconLeft,
    this.alwaysBlue = false,
    this.onFocusChange,
    this.prefixIcon = "",
    this.initialValue,
    this.animatedItem,
    this.timer = false,
    this.calendar = false,
    this.firstDate,
    this.lastDate,
    this.hasError = false,
    this.keyType = TextInputType.text,
    this.toUpperCase = TextCapitalization.words,
  }) : super(key: key);

  @override
  TextfieldClassicState createState() => TextfieldClassicState();
//
  static withDatePicker({
    labelText,
    @required fontSize,
    @required paddingBottomInput,
    leftBorder,
    customIcon,
    alwaysFocus = true,
    alwaysBlue = true,
    noClear,
    center,
    isIcon = false,
    optional = false,
    disable = false,
    @required BuildContext ctx,
    @required int firstDate,
    @required int lastDate,
  }) {
    GlobalKey<TextfieldClassicState> _controller = GlobalKey();
    //
    return GestureDetector(
      onTap: () {},
      child: TextfieldClassic(
        disabled: false,
        key: _controller,
        optional: optional,
        calendar: true,
        firstDate: firstDate,
        lastDate: lastDate,
        customIconBuilder: (hasFocus, empty) {
          return GestureDetector(
            onTap: () async {
              final DateTime picked = await showDatePicker(
                  context: ctx,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(firstDate),
                  lastDate: DateTime(lastDate),
                  footerBuilder: datePickerFooter,
                  width: tablet ? wp(45) : wp(80),
                  headerBuilder: datePickerHeader,
                  builder: (ct, child) {
                    return child;
                  });
              if (picked != null) {
                print("caca");
                _controller.currentState
                    .changeText(DateFormat.yMd().format(picked));
              }
            },
            child: isIcon
                ? Image.asset(
                    'assets/general_icons/calendar.png',
                    height: fontSize * 1.4,
                    colorBlendMode: BlendMode.srcIn,
                    color: !empty
                        ? AppColors.PrimaryBlue
                        : AppColors.BackPrimaryGray,
                  )
                : Container(),
          );
        },
        noClear: true,
        fontSize: fontSize,
        paddingBottomInput: paddingBottomInput,
        labelText: labelText,
        alwaysFocus: alwaysFocus,
        alwaysBlue: alwaysBlue,
      ),
    );
  }

  static withTimePicker({
    labelText,
    @required fontSize,
    @required paddingBottomInput,
    leftBorder,
    customIcon,
    alwaysFocus = true,
    noClear,
    center,
    optional = false,
    disable = false,
    isIcon = true,
    @required BuildContext ctx,
    @required int firstDate,
    @required int lastDate,
  }) {
    GlobalKey<TextfieldClassicState> _controller = GlobalKey();
    //
    return TextfieldClassic(
      key: _controller,
      optional: optional,
      alwaysBlue: true,
      timer: true,
      disabled: disable,
      customIconBuilder: (hasFocus, empty) {
        return GestureDetector(
          onTap: () async {
            DatePicker.showTimePicker(
              ctx,
              showTitleActions: true,
              onChanged: (date) {
                print('change $date');
              },
              onConfirm: (date) {
                _controller.currentState
                    .changeText(DateFormat.Hms().format(date));
              },
              currentTime: DateTime.now(),
              locale: LocaleType.en,
            );
          },
          child: isIcon
              ? Image.asset(
                  'assets/customers/clock.png',
                  height: fontSize * 1.4,
                  colorBlendMode: BlendMode.srcIn,
                  color: !empty
                      ? AppColors.PrimaryBlue
                      : AppColors.BackPrimaryGray,
                )
              : Container(),
        );
      },
      noClear: true,
      fontSize: fontSize,
      paddingBottomInput: paddingBottomInput,
      labelText: labelText,
      alwaysFocus: alwaysFocus,
    );
  }
}

class TextfieldClassicState extends State<TextfieldClassic>
    with SingleTickerProviderStateMixin {
  bool hasFocus = false;
  bool isEmail = false;
  FocusNode myFocusNode;
  String value = '';
  Animation<double> animation;
  AnimationController controller;
  final myController = TextEditingController();
  final scrollController = ScrollController();
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
    if (widget.initialValue != null && widget.initialValue != "") {
      print("${widget.labelText}- ${widget.initialValue}");
      value = widget.initialValue;
      myController.text = widget.initialValue;
      controller.forward();
    }
  }

  void _onFocusChange() {
    print("Focus: " + myFocusNode.hasFocus.toString());
    if (widget.onFocusChange != null)
      widget.onFocusChange(myFocusNode.hasFocus);
    if (myFocusNode.hasFocus) {
      controller.forward();
    } else if (value == '') {
      controller.reverse();
    } else {
      scrollController.jumpTo(0.0);
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

  void openDate(firstDate, lastDate) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(firstDate),
      lastDate: DateTime(lastDate),
      footerBuilder: datePickerFooter,
      width: tablet ? wp(45) : wp(80),
      headerBuilder: datePickerHeader,
    );
    if (picked != null) {
      changeText(DateFormat.yMd().format(picked));
    }
  }

  @override
  void didUpdateWidget(TextfieldClassic oldWidget) {
    // TODO: implement didUpdateWidget
    if (widget.initialValue != oldWidget.initialValue) {
      this.changeText(widget.initialValue);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.labelText == "E-mail" ||
        widget.labelText == "Business E-mail" ||
        widget.labelText == "E-mail Address") {
      isEmail = true;
    }
    if (widget.stream != null) {
      return StreamBuilder(
          stream: widget.stream,
          builder: (context, snapshot) {
            //print(snapshot);
            bool hasError = snapshot.hasError;
            /*if (snapshot.hasData) {
              myController.text = snapshot.data;
              hasFocus = true;
            }*/
            return Container(
              alignment: Alignment.topCenter,
              height: (widget.labelText != ''
                      ? widget.fontSize * 3.5
                      : widget.fontSize * 2.2) +
                  (hasError ? widget.fontSize * 1.2 : 0),
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
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
                                          if (widget.optional)
                                            Text(
                                              " (${eptxt('optional')})",
                                              style: TextStyle(
                                                fontSize: widget.alwaysFocus
                                                    ? widget.fontSize *
                                                        0.8 *
                                                        0.8
                                                    : animation.value * 0.8,
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
                                        if (!widget.disabled) {
                                          FocusScope.of(context)
                                              .requestFocus(myFocusNode);
                                        }
                                      }),
                                )
                              : Container(),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                              left: BorderSide(
                                width:
                                    widget.leftBorder ? (hasFocus ? 2 : 2) : 0,
                                color: widget.leftBorder
                                    ? hasError
                                        ? AppColors.ErrorText
                                        : hasFocus
                                            ? AppColors.FocusText
                                            : AppColors.DisabledText
                                                .withOpacity(0.2)
                                    : AppColors.PrimaryWhite.withOpacity(0),
                              ),
                              bottom: BorderSide(
                                width: hasFocus ? 2 : 2,
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
                            child: widget.keyType == TextInputType.number
                                ? TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(
                                          RegExp(r"[\d.]"))
                                    ],
                                    textCapitalization: widget.toUpperCase,
                                    controller: myController,
                                    textAlign: widget.center
                                        ? TextAlign.center
                                        : TextAlign.start,
                                    onChanged: (x) {
                                      value = x;
                                      widget.onChanged(x);
                                    },
                                    onSubmitted: (str) {
                                      print("HERE");
                                      if (widget.onSubmitted != null) {
                                        print("HERE$str");
                                        widget.onSubmitted(str);
                                      }
                                    },
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
                                    decoration: InputDecoration.collapsed(
                                        hintText: widget.hintText),
                                  )
                                : TextField(
                                    scrollController: scrollController,
                                    textCapitalization: widget.toUpperCase,
                                    keyboardType: isEmail
                                        ? TextInputType.emailAddress
                                        : widget.keyType,
                                    controller: myController,
                                    textAlign: widget.center
                                        ? TextAlign.center
                                        : TextAlign.start,
                                    onChanged: (x) {
                                      value = x;
                                      widget.onChanged(x);
                                    },
                                    onSubmitted: (str) {
                                      if (widget.onSubmitted != null) {
                                        widget.onSubmitted(
                                            str, !snapshot.hasError);
                                      }
                                    },
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
                                    decoration: InputDecoration.collapsed(
                                      hintText: widget.hintText,
                                      hintStyle: TextStyle(
                                          color: AppColors.DisabledText
                                              .withOpacity(0.7),
                                          fontSize: widget.fontSize,
                                          fontWeight: FontWeight.w600),
                                    )),
                          ),
                          widget.customIcon != null
                              ? Positioned(
                                  right: widget.fontSize * 0.1,
                                  bottom: widget.paddingBottomInput * 1.2,
                                  child: GestureDetector(
                                      onTap: () {
                                        changeText("");
                                        value = "";
                                        widget.onChanged("");
                                      },
                                      child: widget.customIcon),
                                )
                              : (hasFocus) && !widget.noClear
                                  ? Positioned(
                                      right: widget.fontSize * 0.1,
                                      bottom: widget.paddingBottomInput * 1.2,
                                      child: GestureDetector(
                                        onTap: () {
                                          changeText("");
                                          value = "";
                                          widget.onChanged("");
                                        },
                                        child: Icon(
                                          Icons.cancel,
                                          color: AppColors.DisabledText,
                                          size: widget.fontSize * 1.2,
                                        ),
                                      ),
                                    )
                                  : Container(),
                          if (!hasFocus &&
                              !widget.alwaysFocus &&
                              value == '' &&
                              widget.customIcon == null)
                            GestureDetector(
                                child: Container(
                                  color: Colors.white.withOpacity(0),
                                ),
                                onTap: () {
                                  if (!widget.disabled) {
                                    FocusScope.of(context)
                                        .requestFocus(myFocusNode);
                                  }
                                }),
                        ],
                      )),
                  Positioned(
                      bottom: widget.fontSize * -0.8,
                      child: Text(
                        snapshot.error ?? '',
                        style: TextStyle(
                            color: AppColors.ErrorText,
                            fontSize: widget.fontSize * 0.70,
                            fontWeight: FontWeight.w600),
                      ))
                ],
              ),
            );
          });
    } else {
      return Container(
          margin: EdgeInsets.only(bottom: widget.fontSize * 0.2),
          height: widget.labelText != ''
              ? widget.fontSize * 3.3
              : widget.fontSize * 2,
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              if (widget.labelText != '')
                AnimatedContainer(
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
                      right: widget.noClear || !widget.showClearButton
                          ? 0
                          : hasFocus ? widget.fontSize * 1.35 : 0),
                  child: GestureDetector(
                      child: Row(
                        crossAxisAlignment: hasFocus || value != ''
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.labelText,
                            style: TextStyle(
                              fontSize: widget.alwaysFocus
                                  ? tablet
                                      ? widget.fontSize * 0.71
                                      : widget.fontSize * 0.8
                                  : animation.value,
                              fontWeight: FontWeight.w600,
                              color: hasFocus || value != ''
                                  ? AppColors.DisabledText
                                  : AppColors.DisabledText.withOpacity(0.8),
                            ),
                          ),
                          if (widget.optional)
                            Text(
                              " (Optional)",
                              style: TextStyle(
                                fontSize: widget.alwaysFocus
                                    ? widget.fontSize * 0.8 * 0.8
                                    : animation.value * 0.8,
                                fontWeight: FontWeight.w600,
                                color: hasFocus || value != ''
                                    ? AppColors.DisabledText
                                    : AppColors.DisabledText.withOpacity(0.9),
                              ),
                            ),
                        ],
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(myFocusNode);
                      }),
                ),
              if ((widget.iconLeft != null))
                Positioned(
                  left: widget.fontSize * 0.1,
                  bottom: widget.paddingBottomInput * 1.2,
                  child: widget.iconLeft(hasFocus, value),
                ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                  left: BorderSide(
                    width: widget.leftBorder
                        ? (widget.alwaysBlue ? 2 : hasFocus ? 2 : 2)
                        : 0,
                    color: widget.leftBorder
                        ? widget.alwaysBlue
                            ? widget.hasError
                                ? AppColors.ErrorText
                                : AppColors.FocusText
                            : hasFocus
                                ? widget.hasError
                                    ? AppColors.ErrorText
                                    : AppColors.FocusText
                                : AppColors.DisabledText.withOpacity(0.2)
                        : AppColors.PrimaryWhite.withOpacity(0),
                  ),
                  bottom: BorderSide(
                    width: widget.alwaysBlue ? 2 : hasFocus ? 2 : 2,
                    color: widget.alwaysBlue
                        ? widget.hasError
                            ? AppColors.ErrorText
                            : AppColors.FocusText
                        : hasFocus
                            ? widget.hasError
                                ? AppColors.ErrorText
                                : AppColors.FocusText
                            : AppColors.DisabledText.withOpacity(0.2),
                  ),
                )),
                padding: EdgeInsets.only(
                    bottom: widget.paddingBottomInput,
                    left: widget.paddingLeft != null
                        ? widget.paddingLeft
                        : (widget.leftBorder
                            ? widget.paddingBottomInput * 1.2
                            : 0),
                    right:
                        hasFocus && (!widget.noClear && widget.showClearButton)
                            ? widget.fontSize * 1.35
                            : 0),
                child: Row(
                  children: <Widget>[
                    if (widget.prefixIcon != '')
                      Text(
                        "${widget.prefixIcon} ",
                        style: TextStyle(
                          color: widget.alwaysBlue
                              ? AppColors.FocusText
                              : hasFocus
                                  ? AppColors.FocusText
                                  : AppColors.DisabledText.withOpacity(0.9),
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    Expanded(
                      child: widget.keyType == TextInputType.number
                          ? TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                WhitelistingTextInputFormatter(RegExp(r"[\d.]"))
                              ],
                              textCapitalization: widget.toUpperCase,
                              controller: myController,
                              textAlign: widget.center
                                  ? TextAlign.center
                                  : TextAlign.start,
                              onSubmitted: (str) {
                                if (widget.onSubmitted != null) {
                                  widget.onSubmitted(str);
                                }
                              },
                              onChanged: (x) {
                                value = x;
                                widget.onChanged(x);
                              },
                              focusNode: myFocusNode,
                              style: TextStyle(
                                  color: widget.hasError
                                      ? AppColors.ErrorText
                                      : hasFocus
                                          ? AppColors.FocusText
                                          : AppColors.DisabledText.withOpacity(
                                              0.9),
                                  fontSize: widget.fontSize,
                                  fontWeight: FontWeight.w600),
                              showCursor: true,
                              decoration: InputDecoration.collapsed(
                                  hintText: widget.hintText),
                            )
                          : TextField(
                              textCapitalization: widget.toUpperCase,
                              keyboardType: isEmail
                                  ? TextInputType.emailAddress
                                  : widget.keyType,
                              controller: myController,
                              textAlign: widget.center
                                  ? TextAlign.center
                                  : TextAlign.start,
                              onChanged: (x) {
                                value = x;
                                widget.onChanged(x);
                              },
                              onSubmitted: (str) {
                                if (widget.onSubmitted != null) {
                                  widget.onSubmitted(str);
                                }
                              },
                              focusNode: myFocusNode,
                              style: TextStyle(
                                  color: widget.hasError
                                      ? AppColors.ErrorText
                                      : hasFocus
                                          ? AppColors.FocusText
                                          : AppColors.DisabledText.withOpacity(
                                              0.9),
                                  fontSize: widget.fontSize,
                                  fontWeight: FontWeight.w600),
                              showCursor: true,
                              decoration: InputDecoration.collapsed(
                                hintText: widget.hintText,
                                hintStyle: TextStyle(
                                    color:
                                        AppColors.DisabledText.withOpacity(0.7),
                                    fontSize: widget.fontSize,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              if (widget.disabled ||
                  (!hasFocus &&
                      !widget.alwaysFocus &&
                      value == '' &&
                      widget.customIcon == null))
                widget.calendar
                    ? GestureDetector(
                        child: Container(
                          color: Colors.white.withOpacity(0),
                        ),
                        onTap: () async {
                          final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(widget.firstDate),
                              lastDate: DateTime(widget.lastDate),
                              footerBuilder: datePickerFooter,
                              width: tablet ? wp(45) : wp(80),
                              headerBuilder: datePickerHeader,
                              builder: (ct, child) {
                                return child;
                              });
                          if (picked != null) {
                            changeText(DateFormat.yMd().format(picked));
                          }
                        })
                    : widget.timer
                        ? GestureDetector(
                            onTap: () async {
                              DatePicker.showTimePicker(
                                context,
                                showTitleActions: true,
                                onChanged: (date) {
                                  print('change $date');
                                },
                                onConfirm: (date) {
                                  changeText(DateFormat.Hms().format(date));
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en,
                              );
                            },
                            child: Container(
                              color: Colors.white.withOpacity(0),
                            ))
                        : GestureDetector(
                            child: Container(
                              color: Colors.white.withOpacity(0),
                            ),
                            onTap: () {
                              print('hello');

                              if (widget.onTap != null) {
                                widget.onTap();
                              } else {
                                if (!widget.disabled) {
                                  FocusScope.of(context)
                                      .requestFocus(myFocusNode);
                                }
                              }
                            }),
              if (widget.customIconBuilder != null)
                Positioned(
                  right: widget.fontSize * 0.1,
                  bottom: widget.paddingBottomInput * 1.2,
                  child: widget.customIconBuilder(hasFocus, value == ''),
                ),
              widget.customIcon != null
                  ? Positioned(
                      right: widget.fontSize * 0.1,
                      bottom: widget.paddingBottomInput * 1.2,
                      child: GestureDetector(
                          onTap: () {
                            changeText("");
                            value = "";
                          },
                          child: widget.customIcon),
                    )
                  : (hasFocus) && !widget.noClear && widget.showClearButton
                      ? Positioned(
                          right: widget.fontSize * 0.1,
                          bottom: widget.paddingBottomInput * 1.2,
                          child: GestureDetector(
                            onTap: () {
                              changeText("");
                              value = "";
                            },
                            child: Icon(
                              Icons.cancel,
                              color: AppColors.DisabledText,
                              size: widget.fontSize * 1.28,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 0,
                          width: 0,
                        ),
              if (widget.animatedItem != null)
                Positioned(
                    right: 0,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 120),
                      padding:
                          EdgeInsets.only(bottom: widget.paddingBottomInput),
                      height: widget.labelText != ''
                          ? widget.fontSize * 3.3
                          : widget.fontSize * 2,
                      alignment: hasFocus || value != ''
                          ? Alignment.topCenter
                          : Alignment.bottomCenter,
                      child: widget.animatedItem((str) {
                        changeText(str);
                      }),
                    ))
            ],
          ));
    }
  }
}
