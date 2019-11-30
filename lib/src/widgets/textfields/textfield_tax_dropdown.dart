import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_for_dropdown.dart';
import 'package:flutter/material.dart';

class TextfieldTaxDrowpdown extends StatefulWidget {
  final String labelText;
  final double fontSize;
  final double paddingBottomInput;
  final bool leftBorder;
  final List<Map<String, dynamic>> items;
  final double paddingTopInput;
  final bool alwaysBlue;
  final bool showArrow;
  TextfieldTaxDrowpdown(
      {this.labelText = '',
      this.fontSize,
      this.paddingBottomInput = 0,
      this.paddingTopInput = 0,
      this.leftBorder = false,
      this.items,
      this.alwaysBlue = false,
      this.showArrow = false});

  @override
  _TextfieldTaxDrowpdownState createState() => _TextfieldTaxDrowpdownState();
}

class _TextfieldTaxDrowpdownState extends State<TextfieldTaxDrowpdown>
    with SingleTickerProviderStateMixin {
  bool hasFocus = false;
  FocusNode myFocusNode;
  String value = '';
  Animation<double> animation;
  AnimationController controller;
  GlobalKey _keyInput = GlobalKey();
  int selectedIndex;
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
    selectedIndex = 0;
    myFocusNode.addListener(_onFocusChange);
  }

  _getPositions() {
    final RenderBox renderBoxRed = _keyInput.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    final sizeRed = renderBoxRed.size;

    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return DialogForDropdown(
          items: widget.items != null ? widget.items : [],
          height: sizeRed.height * 2,
          width: sizeRed.width,
          fontSize: widget.fontSize,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          posx: positionRed.dx,
          posy: positionRed.dy + sizeRed.height,
        );
      },
    ));
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
        padding: EdgeInsets.only(bottom: 0),
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
                              color: AppColors.DisabledText),
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
                      flex: 8,
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
                    flex: 10,
                    child: GestureDetector(
                      onTap: () {
                        _getPositions();
                      },
                      child: Container(
                        key: _keyInput,
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
                        child: Container(
                          padding: EdgeInsets.only(
                              right: hasFocus ? widget.fontSize * 1.35 : 0),
                          child: Text(
                            widget.items != null
                                ? widget.items.length > 0
                                    ? widget.items[selectedIndex]["name"]
                                    : ""
                                : "",
                            style: TextStyle(
                                color: widget.alwaysBlue
                                    ? AppColors.PrimaryBlue
                                    : hasFocus
                                        ? AppColors.FocusText.withOpacity(0.8)
                                        : AppColors.DisabledText.withOpacity(
                                            0.9),
                                fontSize: widget.fontSize,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            widget.showArrow
                ? Positioned(
                    right: widget.fontSize * 0.1,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.DisabledText,
                        size: widget.fontSize * 1.8,
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }
}
