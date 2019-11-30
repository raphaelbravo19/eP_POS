import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_for_dropdown.dart';
import 'package:flutter/material.dart';

class TextfieldDropdownWithField extends StatefulWidget {
  final String labelText;
  final double fontSize;
  final double paddingBottomInput;
  final bool leftBorder;
  final bool showBlueDropdownColor;
  final List<String> items;
  final TextStyle customStyle;
  final Function itemBuilder;
  final double scaleDropdown;
  final bool alwaysBlue;
  TextfieldDropdownWithField({
    this.labelText = '',
    this.fontSize,
    this.paddingBottomInput = 0,
    this.leftBorder = false,
    this.items,
    this.customStyle,
    this.itemBuilder,
    this.scaleDropdown = 1,
    this.alwaysBlue = false,
    this.showBlueDropdownColor = false,
  });

  @override
  _TextfieldDropdownWithFieldState createState() =>
      _TextfieldDropdownWithFieldState();
}

class _TextfieldDropdownWithFieldState extends State<TextfieldDropdownWithField>
    with SingleTickerProviderStateMixin {
  GlobalKey _keyInput = GlobalKey();
  bool hasFocus = false;
  GlobalKey<DialogForDropdownState> _keyDropdown = GlobalKey();
  FocusNode myFocusNode;
  String value = 'Option1';
  Animation<double> animation;
  AnimationController controller;
  int selectedIndex;
  bool showModal;
  final myController = TextEditingController();
  _getPositions() {
    final RenderBox renderBoxRed = _keyInput.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    final sizeRed = renderBoxRed.size;

    print("POSITION of Red: ${positionRed.dx} ");
    setState(() {
      showModal = true;
    });
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return DialogForDropdown(
          key: _keyDropdown,
          items: widget.items != null ? widget.items : [],
          height: sizeRed.height * widget.scaleDropdown,
          width: sizeRed.width,
          fontSize: widget.fontSize,
          itemBuilder: widget.itemBuilder != null
              ? ({index, height}) {
                  return widget.itemBuilder(
                      option: widget.items[index],
                      index: index,
                      height: height);
                }
              : null,
          onTap: (index) {
            value = widget.items[selectedIndex];
            myController.text = value;
            setState(() {
              selectedIndex = index;
            });

            _keyDropdown.currentState.updateShow();
          },
          posx: positionRed.dx,
          posy: positionRed.dy + sizeRed.height - widget.fontSize * 0.2,
        );
      },
    ));
  }

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
    selectedIndex = 0;
    showModal = false;
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
    return GestureDetector(
      child: Container(
        key: _keyInput,
        child: Stack(overflow: Overflow.visible, children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: widget.fontSize * 0.2),
              padding: EdgeInsets.only(
                  bottom: widget.paddingBottomInput,
                  left:
                      widget.leftBorder ? widget.paddingBottomInput * 1.2 : 0),
              height: widget.labelText != ''
                  ? widget.fontSize * 3.3
                  : widget.fontSize * 2,
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(
                  width: widget.leftBorder
                      ? (widget.alwaysBlue ? 2 : hasFocus ? 2.8 : 2)
                      : 0,
                  color: widget.leftBorder
                      ? widget.alwaysBlue
                          ? AppColors.FocusText
                          : hasFocus
                              ? AppColors.FocusText.withOpacity(0.8)
                              : AppColors.DisabledText.withOpacity(0.2)
                      : AppColors.PrimaryWhite,
                ),
                bottom: BorderSide(
                  width: widget.alwaysBlue ? 2 : hasFocus ? 2.8 : 2,
                  color: widget.alwaysBlue
                      ? AppColors.FocusText
                      : hasFocus
                          ? AppColors.FocusText.withOpacity(0.8)
                          : AppColors.DisabledText.withOpacity(0.2),
                ),
              )),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: widget.fontSize * 2.5),
                    child: TextField(
                        controller: myController,
                        textAlign: TextAlign.center,
                        onChanged: (x) => value = x,
                        focusNode: myFocusNode,
                        style: TextStyle(
                            color: widget.alwaysBlue
                                ? AppColors.FocusText
                                : hasFocus
                                    ? AppColors.FocusText
                                    : AppColors.DisabledText.withOpacity(0.9),
                            fontSize: widget.fontSize,
                            fontWeight: FontWeight.w600),
                        showCursor: true,
                        decoration: InputDecoration.collapsed()),
                  ),
                  Positioned(
                    right: widget.fontSize * 0.1,
                    bottom: -widget.paddingBottomInput,
                    child: GestureDetector(
                      onTap: () {
                        _getPositions();
                      },
                      child: Container(
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.DisabledText,
                          size: widget.fontSize * 1.5,
                        ),
                      ),
                    ),
                  ),
                  widget.labelText != ''
                      ? AnimatedContainer(
                          alignment: Alignment.bottomLeft,
                          duration: Duration(milliseconds: 120),
                          margin: EdgeInsets.only(
                              bottom: hasFocus || value != ''
                                  ? widget.fontSize * 1.6
                                  : 0),
                          child: GestureDetector(
                              child: Text(
                                widget.labelText,
                                style: TextStyle(
                                    fontSize: widget.fontSize * 0.8,
                                    fontWeight: FontWeight.w600,
                                    color: hasFocus || value != ''
                                        ? AppColors.DisabledText
                                        : AppColors.DisabledText.withOpacity(
                                            0.9)),
                              ),
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(myFocusNode);
                              }),
                        )
                      : Container(),
                ],
              )),
        ]),
      ),
    );
  }
}
