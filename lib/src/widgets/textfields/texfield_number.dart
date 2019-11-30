import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/countries.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldNumber extends StatefulWidget {
  final String labelText;
  final double fontSize;
  final double paddingBottomInput;
  final bool leftBorder;
  final bool noClear;
  final bool alwaysFocus;
  final bool hasError;
  final String initialValue;
  final CountryData initialCountry;
  final TextInputType keyType;
  final Stream<String> stream;
  final Function onChangedCountry;
  final Function onSubmitted;
  final bool disable;
  ValueChanged<String> onChanged;
  Function onFocusChange;
  TextfieldNumber(
      {Key key,
      this.labelText = '',
      this.fontSize,
      this.paddingBottomInput = 0,
      this.leftBorder = false,
      this.noClear = false,
      this.alwaysFocus = false,
      this.onChanged,
      this.hasError = false,
      this.keyType = TextInputType.number,
      this.stream,
      this.initialCountry,
      this.initialValue,
      this.onFocusChange,
      this.onChangedCountry,
      this.disable = false,
      this.onSubmitted})
      : super(key: key);

  @override
  TextfieldNumberState createState() => TextfieldNumberState();
}

class TextfieldNumberState extends State<TextfieldNumber>
    with SingleTickerProviderStateMixin {
  CountryData country = CountryData(
    alpha2Code: 'IN',
    alpha3Code: 'IND',
    dialCode: 91,
    id: '5d8290ab2a641a01207efbad',
    name: 'India',
    numericCode: 356,
  );
  bool hasFocus = false;
  FocusNode myFocusNode;
  String value = '';
  Animation<double> animation;
  AnimationController controller;
  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      value = widget.initialValue;
      myController.text = widget.initialValue;
    }
    if (widget.initialCountry != null) {
      print("COUNTRY ${widget.initialCountry.toJsonString()}");
      country = widget.initialCountry;
    }
    myFocusNode = FocusNode();
    controller = AnimationController(
        duration: const Duration(milliseconds: 120), vsync: this);
    animation =
        Tween<double>(begin: widget.fontSize, end: widget.fontSize * 0.8)
            .animate(controller);
    animation.addListener(() => setState(() {}));

    myFocusNode.addListener(_onFocusChange);
  }

  void changeCountry(CountryData c) {
    country = c;
  }

  Map<String, dynamic> getNumber() {
    return {"code": country, "number": value};
  }

  String getNumberString() {
    return '+${country.dialCode}$value';
  }

  void _onFocusChange() {
    print("Focus: " + myFocusNode.hasFocus.toString());
    if (widget.onFocusChange != null)
      widget.onFocusChange(myFocusNode.hasFocus);
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

  @override
  Widget build(BuildContext context) {
    if (widget.stream != null) {
      return StreamBuilder(
          stream: widget.stream,
          builder: (context, snapshot) {
            //print(snapshot);
            bool hasError = snapshot.hasError;
            return Container(
                alignment: Alignment.topCenter,
                height: (widget.labelText != ''
                        ? widget.fontSize * 3.5
                        : widget.fontSize * 2.2) +
                    (hasError ? widget.fontSize * 1.2 : 0),
                child: Stack(overflow: Overflow.visible, children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(
                          bottom: hasFocus || value != '' || widget.alwaysFocus
                              ? 0
                              : widget.paddingBottomInput),
                      height: widget.labelText != ''
                          ? widget.fontSize * 3.3
                          : widget.fontSize * 2,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          width: hasFocus ? 2.4 : 2,
                          color: hasError
                              ? AppColors.ErrorText
                              : hasFocus
                                  ? AppColors.FocusText
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
                                  margin: EdgeInsets.only(
                                      bottom: hasFocus ||
                                              value != '' ||
                                              widget.alwaysFocus
                                          ? widget.fontSize * 2
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
                                        if (!widget.disable) {
                                          FocusScope.of(context)
                                              .requestFocus(myFocusNode);
                                        }
                                      }),
                                )
                              : Container(),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: <Widget>[
                                hasFocus || value != '' || widget.alwaysFocus
                                    ? GestureDetector(
                                        onTap: () {
                                          print("hola");
                                          _showDialog();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: widget.paddingBottomInput *
                                                  0.4,
                                              right: widget.paddingBottomInput,
                                              bottom:
                                                  widget.paddingBottomInput *
                                                      0.6),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right:
                                                      widget.paddingBottomInput,
                                                ),
                                                child: Image.asset(
                                                  'assets/flags/${country.alpha2Code}_64.png',
                                                  height:
                                                      widget.fontSize * 1.25,
                                                  width: widget.fontSize *
                                                      1.25 *
                                                      1.25,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Text("+${country.dialCode}",
                                                  style: TextStyle(
                                                      color: hasError
                                                          ? AppColors.ErrorText
                                                          : hasFocus
                                                              ? AppColors
                                                                  .FocusText
                                                              : AppColors
                                                                      .DisabledText
                                                                  .withOpacity(
                                                                      0.9),
                                                      fontSize: widget.fontSize,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ],
                                          ),
                                        ))
                                    : Container(),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      left: BorderSide(
                                        width: 1.5,
                                        color: hasFocus
                                            ? hasError
                                                ? AppColors.ErrorText
                                                : AppColors.FocusText
                                            : value != '' || widget.alwaysFocus
                                                ? AppColors.DisabledText
                                                    .withOpacity(0.2)
                                                : AppColors.PrimaryWhite,
                                      ),
                                    )),
                                    padding: EdgeInsets.only(
                                        top: widget.paddingBottomInput * 0.4,
                                        bottom: widget.paddingBottomInput * 0.6,
                                        left: widget.paddingBottomInput,
                                        right: hasFocus
                                            ? widget.fontSize * 1.35
                                            : 0),
                                    child: TextField(
                                        inputFormatters: [
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        onChanged: (x) {
                                          value = x;
                                          widget.onChanged(x);
                                        },
                                        onSubmitted: (str) {
                                          if (widget.onSubmitted != null) {
                                            widget.onSubmitted(
                                                getNumberString(),
                                                !snapshot.hasError);
                                          }
                                        },
                                        controller: myController,
                                        keyboardType: TextInputType.number,
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
                                            hintText: '')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hasFocus
                              ? widget.noClear
                                  ? Container()
                                  : Positioned(
                                      right: widget.fontSize * 0.1,
                                      bottom: hasFocus || value != ''
                                          ? widget.paddingBottomInput
                                          : 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          changeText("");
                                          value = "";
                                          widget.onChanged("");
                                        },
                                        child: Icon(
                                          Icons.cancel,
                                          color: AppColors.DisabledText,
                                          size: widget.fontSize * 1.15,
                                        ),
                                      ),
                                    )
                              : Container(),
                          if (!hasFocus && value == '')
                            GestureDetector(
                                child: Container(
                                  color: Colors.white.withOpacity(0),
                                ),
                                onTap: () {
                                  if (!widget.disable) {
                                    FocusScope.of(context)
                                        .requestFocus(myFocusNode);
                                  }
                                })
                        ],
                      )),
                  Positioned(
                      bottom: widget.fontSize * -0.9,
                      child: Text(
                        snapshot.error ?? '',
                        style: TextStyle(
                            color: AppColors.ErrorText,
                            fontSize: widget.fontSize * 0.70,
                            fontWeight: FontWeight.w600),
                      ))
                ]));
          });
    } else {
      return Container(
          padding: EdgeInsets.only(
              bottom: hasFocus || value != '' || widget.alwaysFocus
                  ? 0
                  : widget.paddingBottomInput),
          height: widget.labelText != ''
              ? widget.fontSize * 3.3
              : widget.fontSize * 2,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: hasFocus ? 2.4 : 2,
                color: hasFocus
                    ? widget.hasError
                        ? AppColors.ErrorText
                        : AppColors.FocusText
                    : AppColors.DisabledText.withOpacity(0.2),
              ),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              widget.labelText != ''
                  ? AnimatedContainer(
                      alignment: Alignment.bottomLeft,
                      duration: Duration(milliseconds: 120),
                      margin: EdgeInsets.only(
                          bottom: hasFocus || value != '' || widget.alwaysFocus
                              ? widget.fontSize * 2
                              : 0),
                      child: GestureDetector(
                          child: Text(
                            widget.labelText,
                            style: TextStyle(
                                fontSize: widget.alwaysFocus
                                    ? widget.fontSize * 0.8
                                    : animation.value,
                                fontWeight: FontWeight.w600,
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
                    hasFocus || value != '' || widget.alwaysFocus
                        ? GestureDetector(
                            onTap: () {
                              _showDialog();
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: widget.paddingBottomInput * 0.4,
                                  right: widget.paddingBottomInput,
                                  bottom: widget.paddingBottomInput * 0.6),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: widget.paddingBottomInput,
                                    ),
                                    child: Image.asset(
                                      'assets/flags/${country.alpha2Code}_64.png',
                                      height: widget.fontSize * 1.25,
                                      width: widget.fontSize * 1.25 * 1.25,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text("+${country.dialCode}",
                                      style: TextStyle(
                                          color: hasFocus
                                              ? widget.hasError
                                                  ? AppColors.ErrorText
                                                  : AppColors.FocusText
                                              : AppColors.DisabledText
                                                  .withOpacity(0.9),
                                          fontSize: widget.fontSize,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ))
                        : Container(),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          left: BorderSide(
                            width: 1.5,
                            color: hasFocus
                                ? widget.hasError
                                    ? AppColors.ErrorText
                                    : AppColors.FocusText
                                : value != '' || widget.alwaysFocus
                                    ? AppColors.DisabledText.withOpacity(0.2)
                                    : AppColors.PrimaryWhite.withOpacity(0),
                          ),
                        )),
                        padding: EdgeInsets.only(
                            top: widget.paddingBottomInput * 0.4,
                            bottom: widget.paddingBottomInput * 0.6,
                            left: widget.paddingBottomInput,
                            right: hasFocus ? widget.fontSize * 1.35 : 0),
                        child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            onChanged: (x) {
                              value = x;
                              if (widget.onChanged != null) {
                                widget.onChanged("+${country.dialCode}$x");
                              }
                            },
                            controller: myController,
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
                            decoration:
                                InputDecoration.collapsed(hintText: '')),
                      ),
                    ),
                  ],
                ),
              ),
              hasFocus
                  ? widget.noClear
                      ? Container()
                      : Positioned(
                          right: widget.fontSize * 0.1,
                          bottom: hasFocus || value != ''
                              ? widget.paddingBottomInput
                              : 0,
                          child: GestureDetector(
                            onTap: () {
                              changeText("");
                              value = "";
                              widget.onChanged("");
                            },
                            child: Icon(
                              Icons.cancel,
                              color: AppColors.DisabledText,
                              size: widget.fontSize * 1.28,
                            ),
                          ),
                        )
                  : Container(),
              if (!hasFocus && value == '')
                GestureDetector(
                    child: Container(
                      color: Colors.white.withOpacity(0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(myFocusNode);
                    })
            ],
          ));
    }
  }

  void _showDialog() {
    // flutter defined function
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return DialogCountry(
              countrySelected: country,
              onClick: (CountryObj val) {
                //print("XXX");
                setState(() {
                  country = CountryData(
                    alpha2Code: val.alpha2Code,
                    dialCode: int.parse(val.callingCodes[0]),
                    name: val.name,
                    id: 'selected',
                    numericCode: 0,
                    alpha3Code: "AAA",
                  );
                });
                if (widget.onChangedCountry != null) {
                  widget.onChangedCountry(int.parse(val.callingCodes[0]));
                }
              },
              onClose: () {
                if (widget.onChangedCountry != null) {
                  widget.onChangedCountry(country.dialCode);
                }
              });
        }));
  }
}
