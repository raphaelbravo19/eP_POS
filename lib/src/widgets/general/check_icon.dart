import 'package:flutter/material.dart';

class CheckIcon extends StatefulWidget {
  CheckIcon({this.size, this.value = false});
  final double size;
  final bool value;
  @override
  _CheckIconState createState() => _CheckIconState();
}

class _CheckIconState extends State<CheckIcon> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          active = !active;
        });
      },
      child: Image.asset(
        "assets/createaccount/${active ? "" : "dis"}agree.png",
        height: widget.size,
      ),
    );
  }
}

class CheckIconValue extends StatelessWidget {
  CheckIconValue({this.size, this.value = false});
  final double size;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        "assets/createaccount/${value ? "" : "dis"}agree.png",
        height: size,
      ),
    );
  }
}
