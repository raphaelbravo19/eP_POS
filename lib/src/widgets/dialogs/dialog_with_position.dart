import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class DialogWithPosition extends StatefulWidget {
  final Widget component;
  final double posx;
  final double posy;
  final bool right;
  DialogWithPosition({
    Key key,
    this.component,
    this.posx,
    this.posy,
    this.right = false,
  }) : super(key: key);

  @override
  DialogWithPositionState createState() => DialogWithPositionState();
}

class DialogWithPositionState extends State<DialogWithPosition> {
  bool showModal;
  @override
  void initState() {
    showModal = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Container(
        alignment: Alignment.center,
        width: wp(100),
        height: hp(100),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            GestureDetector(
              onTapDown: (TapDownDetails) {
                //print("works");
                setState(() {
                  showModal = false;
                });
                Navigator.of(context).pop();
              },
              /*onTap: () {
                Navigator.of(context).pop();
              },*/
              child: Container(
                width: wp(100),
                height: hp(100),
                color: Colors.black.withOpacity(0),
              ),
            ),
            Positioned(
              top: widget.posy,
              left: widget.right ? null : widget.posx,
              right: widget.right ? widget.posx : null,
              child: showModal ? widget.component : Container(),
            )
          ],
        ),
      ),
    );
  }

  void updateShow() {
    setState(() {
      showModal = false;
    });
  }
}
