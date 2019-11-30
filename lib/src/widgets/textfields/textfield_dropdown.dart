import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_for_dropdown.dart';
import 'package:flutter/material.dart';

class TextfieldDropdown extends StatefulWidget {
  final String labelText;
  final double fontSize;
  final double paddingBottomInput;
  final bool leftBorder;
  final bool showBlueDropdownColor;
  final List<Map<String, dynamic>> items;
  final TextStyle customStyle;
  final Function itemBuilder;
  final double scaleDropdown;
  final bool alwaysBlue;
  final double paddingLeft;
  final String defaultText;
  final Function onFocusChange;
  final Function onChanged;
  final Function onChangeIndex;
  final bool startValue;
  final double iconBottom;
  final String initValue;
  final bool multiselection;
  final List<int> initialMulti;
  final Function onTap;
  final bool resetOnUpdate;
  TextfieldDropdown(
      {Key key,
      this.labelText = '',
      this.fontSize,
      this.paddingBottomInput = 0,
      this.leftBorder = false,
      this.items,
      this.customStyle,
      this.itemBuilder,
      this.onChangeIndex,
      this.scaleDropdown = 1,
      this.alwaysBlue = false,
      this.showBlueDropdownColor = false,
      this.onFocusChange,
      this.paddingLeft = 0,
      this.defaultText = '',
      this.onChanged,
      this.resetOnUpdate = false,
      this.startValue = true,
      this.iconBottom = 0,
      this.initValue,
      this.multiselection = false,
      this.initialMulti,
      this.onTap})
      : super(key: key);

  @override
  TextfieldDropdownState createState() => TextfieldDropdownState();
}

class TextfieldDropdownState extends State<TextfieldDropdown>
    with SingleTickerProviderStateMixin {
  GlobalKey _keyInput = GlobalKey();
  List<int> selectedMulti = [0];
  bool hasFocus = false;
  GlobalKey<DialogForDropdownState> _keyDropdown = GlobalKey();
  FocusNode myFocusNode;
  String value = 'Option1';
  Animation<double> animation;
  AnimationController controller;
  int selectedIndex;
  bool showModal = false;

  _getPositions() {
    final RenderBox renderBoxRed = _keyInput.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    final sizeRed = renderBoxRed.size;

    if (widget.onFocusChange != null) widget.onFocusChange(true);

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
          multi: widget.multiselection,
          multiItems: selectedMulti,
          itemBuilder: widget.itemBuilder != null
              ? ({index, height}) {
                  return widget.itemBuilder(
                    option: widget.items[index]['name'],
                    index: index,
                    height: height,
                    selected: selectedIndex == index,
                  );
                }
              : null,
          updateMulti: (list) {
            if (widget.multiselection) {
              setState(() {
                selectedMulti = list;
              });
              print(selectedMulti);
              if (widget.onChanged != null) {
                widget.onChanged(selectedMulti);
              }
            }
          },
          onTap: (index) {
            if (widget.onFocusChange != null) widget.onFocusChange(false);
            if (widget.multiselection) {
              setState(() {
                selectedMulti.add(index);
              });

              if (widget.onChanged != null) {
                widget.onChanged(selectedMulti);
              }
            } else {
              setState(() {
                selectedIndex = index;
                if (widget.onChanged != null) {
                  widget.onChanged(widget.items[index]['value']);
                }
                if (widget.onChangeIndex != null) {
                  widget.onChangeIndex(index);
                }
                showModal = false;
              });
              if (!widget.startValue) {
                controller.forward();
              }
              _keyDropdown.currentState.updateShow();
            }
          },
          updateFocus: () {
            if (widget.onFocusChange != null) widget.onFocusChange(false);
            setState(() {
              showModal = false;
            });
          },
          posx: positionRed.dx,
          posy: positionRed.dy + sizeRed.height - widget.fontSize * 0.2,
        );
      },
      transitionsBuilder: (c, anim, a2, child) =>
          FadeTransition(opacity: anim, child: child),
      transitionDuration: Duration(milliseconds: 120),
    ));
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialMulti != null) {
      selectedMulti = widget.initialMulti;
    }
    myFocusNode = FocusNode();
    controller = AnimationController(
        duration: const Duration(milliseconds: 120), vsync: this);
    animation =
        Tween<double>(begin: widget.fontSize, end: widget.fontSize * 0.8)
            .animate(controller);
    animation.addListener(() => setState(() {}));

    selectedIndex = widget.startValue ? 0 : -1;

    if (widget.initValue != null) {
      print("mas${widget.items.length}");
      for (var i = 0; i < widget.items.length; i++) {
        print(widget.items[i]["value"]);
        if (widget.items[i]["value"] == widget.initValue) {
          selectedIndex = i;
          break;
        }
      }
    }
    if (widget.defaultText != '') {
      controller.forward();
    }
    showModal = false;
    myFocusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(TextfieldDropdown oldWidget) {
    if (widget.resetOnUpdate) {
      setState(() {
        selectedIndex = 0;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onFocusChange() {
    print("Focus: " + myFocusNode.hasFocus.toString());
    if (myFocusNode.hasFocus) {
      // controller.forward();
    } else if (value == '') {
      // controller.reverse();
    }
    setState(() {
      //hasFocus = myFocusNode.hasFocus;
    });
  }

  Map<String, dynamic> getValue() {
    return widget.items[selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    var textLarge = widget.items != null
        ? widget.items.length > 0
            ? selectedMulti.map((x) => widget.items[x]["name"]).toString()
            : ""
        : "";
    return GestureDetector(
      onTap: () {
        _getPositions();
      },
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
                  width: 2,
                  color: widget.leftBorder
                      ? widget.alwaysBlue
                          ? AppColors.FocusText
                          : hasFocus
                              ? AppColors.FocusText
                              : AppColors.DisabledText.withOpacity(0.2)
                      : AppColors.PrimaryWhite.withOpacity(0),
                ),
                bottom: BorderSide(
                  width: 2,
                  color: showModal
                      ? AppColors.FocusText
                      : widget.alwaysBlue
                          ? AppColors.FocusText
                          : hasFocus
                              ? AppColors.FocusText.withOpacity(0.8)
                              : AppColors.DisabledText.withOpacity(0.2),
                ),
              )),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: widget.paddingLeft),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      widget.items != null && selectedIndex != -1
                          ? widget.items.length > 0
                              ? widget.multiselection
                                  ? textLarge.substring(1, textLarge.length - 1)
                                  : widget.items[selectedIndex]['name']
                              : ""
                          : widget.defaultText,
                      maxLines: 1,
                      style: TextStyle(
                          color: showModal
                              ? AppColors.FocusText
                              : widget.showBlueDropdownColor
                                  ? AppColors.FocusText
                                  : AppColors.DisabledText.withOpacity(0.9),
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  widget.items == null
                      ? Container()
                      : Positioned(
                          right: widget.fontSize * 0.1,
                          bottom: widget.iconBottom +
                              (widget.labelText != ''
                                  ? -widget.paddingBottomInput
                                  : -widget.paddingBottomInput * 0.5),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.DisabledText,
                            size: widget.fontSize * 1.5,
                          ),
                        ),
                  widget.labelText != ''
                      ? Positioned(
                          bottom: 0,
                          child: AnimatedContainer(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(
                                bottom: selectedIndex != -1 ||
                                        widget.defaultText != ''
                                    ? widget.fontSize * 1.6
                                    : 0),
                            duration: Duration(milliseconds: 120),
                            child: Text(
                              widget.labelText,
                              style: TextStyle(
                                  fontSize: !widget.startValue
                                      ? animation.value
                                      : widget.fontSize * 0.8,
                                  fontWeight: FontWeight.w600,
                                  color: hasFocus || value != ''
                                      ? AppColors.DisabledText
                                      : AppColors.DisabledText.withOpacity(
                                          0.9)),
                            ),
                          ),
                        )
                      : Container(),
                  widget.onTap != null
                      ? GestureDetector(
                          onTap: widget.onTap,
                          child: Container(
                            color: Colors.transparent,
                          ),
                        )
                      : SizedBox()
                ],
              )),
        ]),
      ),
    );
  }
}
