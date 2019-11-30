import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:flutter/material.dart';

class EpaisaCheckBox extends StatefulWidget {
  const EpaisaCheckBox({
    Key key,
    @required this.hp,
    this.tablet = false,
    this.checked = false,
    @required this.size,
  }) : super(key: key);

  final Function hp;
  final bool tablet;
  final bool checked;
  final double size;

  @override
  _EpaisaCheckBoxState createState() => _EpaisaCheckBoxState();
}

class _EpaisaCheckBoxState extends State<EpaisaCheckBox> {
  var _checked;
  @override
  void initState() {
    _checked = widget.checked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _checked = !_checked;
        });
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: !_checked
            ? BoxDecoration(
                border: Border.all(
                  width: widget.hp(0.25),
                  color: AppColors.TextGray,
                ),
                borderRadius: BorderRadius.circular(
                  widget.hp(0.2),
                ),
              )
            : BoxDecoration(),
        child: _checked
            ? Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.PrimaryBlue,
                      borderRadius: BorderRadius.circular(
                        widget.hp(0.2),
                      ),
                    ),
                    height: widget.hp(2.8),
                    width: widget.hp(2.8),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.check,
                      size: widget.size,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            : Container(),
      ),
    );
  }
}

class EpaisaRadioBox extends StatefulWidget {
  const EpaisaRadioBox({
    Key key,
    @required this.hp,
    this.tablet = false,
    this.checked = false,
    @required this.size,
  }) : super(key: key);

  final Function hp;
  final bool tablet;
  final bool checked;
  final double size;

  @override
  _EpaisaRadioBoxState createState() => _EpaisaRadioBoxState();
}

class _EpaisaRadioBoxState extends State<EpaisaRadioBox> {
  var _checked;
  @override
  void initState() {
    _checked = widget.checked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _checked = !_checked;
        });
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: !_checked
            ? BoxDecoration(
          border: Border.all(
            width: widget.hp(0.25),
            color: AppColors.TextGray,
          ),
          borderRadius: BorderRadius.circular(
            widget.hp(2),
          ),
        )
            : BoxDecoration(),
        child: _checked
            ? Container(
          padding: EdgeInsets.all(2.8),
          decoration: BoxDecoration(
            border: Border.all(
              width: widget.hp(0.25),
              color: AppColors.PrimaryBlue,
            ),
            borderRadius: BorderRadius.circular(
              widget.hp(2),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.PrimaryBlue,
              borderRadius: BorderRadius.circular(
                widget.hp(2),
              ),
            ),
            child: Container(),
          ),
        )
            : Container(),
      ),
    );
  }
}


class EpaisaButtonBox extends StatefulWidget {
  const EpaisaButtonBox({
    Key key,
    @required this.hp,
    this.tablet = false,
    this.checked = false,
    @required this.size,
    @required this.icon,
  }) : super(key: key);

  final Function hp;
  final bool tablet;
  final bool checked;
  final double size;
  final IconData icon;

  @override
  _EpaisaButtonBoxState createState() => _EpaisaButtonBoxState();
}

class _EpaisaButtonBoxState extends State<EpaisaButtonBox> {
  var _checked;
  @override
  void initState() {
    _checked = widget.checked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _checked = !_checked;
        });
      },
      child: Container(
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(
            border: Border.all(
              width: widget.hp(0.15),
              color: AppColors.TextGray,
            ),
            borderRadius: BorderRadius.circular(
              widget.hp(0.2),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                height: widget.size,
                width: widget.size,
              ),
              Positioned(
                top: -1,
                left: -1,
                child: Icon(
                  widget.icon,
                  size: widget.size,
                  color: AppColors.PrimaryBlue,
                ),
              )
            ],
          )),
    );
  }
}
