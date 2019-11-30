import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class TextfieldBox extends StatefulWidget {
  final String labelText;
  final double fontSize;
  final double paddingBottomInput;
  final bool leftBorder;
  final Function onChanged;
  final String initialValue;
  final Stream<String> stream;
  TextfieldBox(
      {this.labelText = '',
      this.fontSize,
      this.paddingBottomInput = 0,
      this.leftBorder = false,
      this.initialValue,
      this.onChanged,
      this.stream});

  @override
  _TextfieldBoxState createState() => _TextfieldBoxState();
}

class _TextfieldBoxState extends State<TextfieldBox>
    with SingleTickerProviderStateMixin {
  bool hasFocus = false;
  FocusNode myFocusNode;
  String value = '';
  Animation<double> animation;
  AnimationController controller;
  TextEditingController myController = new TextEditingController();
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
    if (widget.initialValue != null && widget.initialValue != "") {
      print("${widget.labelText}- ${widget.initialValue}");
      value = widget.initialValue;
      myController.text = widget.initialValue;

      //controller.forward();
    }
  }

  void changeText(String text) {
    myController.text = text;
    value = text;
    if (text != '') {
      setState(() {
        //hasFocus = true;
      });
    }
  }

  void _onFocusChange() {
    print("Focus: " + myFocusNode.hasFocus.toString());
    /*if (myFocusNode.hasFocus)
      controller.forward();
    else if (value == '') {
      controller.reverse();
    }*/
    setState(() {
      hasFocus = myFocusNode.hasFocus;
    });
  }

  @override
  void didUpdateWidget(TextfieldBox oldWidget) {
    // TODO: implement didUpdateWidget
    if (widget.initialValue != oldWidget.initialValue) {
      this.changeText(widget.initialValue);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.stream != null) {
      return StreamBuilder<String>(
          stream: widget.stream,
          builder: (context, snapshot) {
            return Container(
                margin: EdgeInsets.only(bottom: widget.fontSize * 0.2),
                padding: EdgeInsets.only(
                  left: widget.paddingBottomInput * 1.2,
                  right: widget.paddingBottomInput * 1.2,
                  top: widget.paddingBottomInput * 1.2,
                ),
                height: widget.labelText != ''
                    ? widget.fontSize * 5
                    : widget.fontSize * 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.fontSize * 0.4),
                  border: Border.all(
                      width: (hasFocus ? 2 : 1.5),
                      color: hasFocus
                          ? AppColors.FocusText.withOpacity(0.9)
                          : AppColors.DisabledText.withOpacity(0.3)),
                ),
                child: Stack(
                  alignment:
                      hasFocus ? Alignment.topLeft : Alignment.bottomLeft,
                  children: <Widget>[
                    widget.labelText != '' && !hasFocus
                        ? AnimatedContainer(
                            alignment: Alignment.bottomLeft,
                            duration: Duration(milliseconds: 120),
                            margin:
                                EdgeInsets.only(bottom: widget.fontSize * 2.7),
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
                                    fontSize: widget.fontSize * 0.7,
                                    fontWeight: FontWeight.w700,
                                    color: hasFocus || value != ''
                                        ? AppColors.DisabledText
                                        : AppColors.DisabledText.withOpacity(
                                            0.8),
                                  ),
                                ),
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(myFocusNode);
                                }),
                          )
                        : Container(),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: widget.paddingBottomInput,
                        left: widget.leftBorder
                            ? widget.paddingBottomInput * 1.2
                            : 0,
                        /*right: hasFocus ? widget.fontSize * 1.35 : 0*/
                      ),
                      child: TextField(
                          controller: myController,
                          keyboardType: TextInputType.multiline,
                          maxLines: hasFocus ? 3 : 2,
                          onChanged: (x) {
                            value = x;
                            if (widget.onChanged != null) widget.onChanged(x);
                          },
                          focusNode: myFocusNode,
                          style: TextStyle(
                              color: hasFocus
                                  ? AppColors.FocusText
                                  : AppColors.DisabledText.withOpacity(0.9),
                              fontSize: widget.fontSize,
                              fontWeight: FontWeight.w700),
                          showCursor: true,
                          decoration: InputDecoration.collapsed(hintText: '')),
                    ),
                  ],
                ));
          });
    } else {
      return Container(
          margin: EdgeInsets.only(bottom: widget.fontSize * 0.2),
          padding: EdgeInsets.only(
            left: widget.paddingBottomInput * 1.2,
            right: widget.paddingBottomInput * 1.2,
            top: widget.paddingBottomInput * 1.2,
          ),
          height: widget.labelText != ''
              ? widget.fontSize * 5
              : widget.fontSize * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.fontSize * 0.4),
            border: Border.all(
                width: (hasFocus ? 2 : 1.5),
                color: hasFocus
                    ? AppColors.FocusText.withOpacity(0.9)
                    : AppColors.DisabledText.withOpacity(0.3)),
          ),
          child: Stack(
            alignment: hasFocus ? Alignment.topLeft : Alignment.bottomLeft,
            children: <Widget>[
              widget.labelText != '' && !hasFocus
                  ? AnimatedContainer(
                      alignment: Alignment.bottomLeft,
                      duration: Duration(milliseconds: 120),
                      margin: EdgeInsets.only(bottom: widget.fontSize * 2.7),
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
                              fontSize: widget.fontSize * 0.7,
                              fontWeight: FontWeight.w700,
                              color: hasFocus || value != ''
                                  ? AppColors.DisabledText
                                  : AppColors.DisabledText.withOpacity(0.8),
                            ),
                          ),
                          onTap: () {
                            FocusScope.of(context).requestFocus(myFocusNode);
                          }),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.only(
                  bottom: widget.paddingBottomInput,
                  left: widget.leftBorder ? widget.paddingBottomInput * 1.2 : 0,
                  /*right: hasFocus ? widget.fontSize * 1.35 : 0*/
                ),
                child: TextField(
                    controller: myController,
                    keyboardType: TextInputType.multiline,
                    maxLines: hasFocus ? 3 : 2,
                    onChanged: (x) {
                      value = x;
                      if (widget.onChanged != null) widget.onChanged(x);
                    },
                    focusNode: myFocusNode,
                    style: TextStyle(
                        color: hasFocus
                            ? AppColors.FocusText
                            : AppColors.DisabledText.withOpacity(0.9),
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.w700),
                    showCursor: true,
                    decoration: InputDecoration.collapsed(hintText: '')),
              ),
            ],
          ));
    }
  }
}
