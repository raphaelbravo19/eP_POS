import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:flutter/material.dart';

class DialogPositioned extends StatefulWidget {
  final List<String> items;
  final double posx;
  final double posy;
  final double height;
  final double width;
  final double fontSize;
  final Function onTap;
  final Widget child;
  DialogPositioned({
    Key key,
    this.items,
    this.posx,
    this.posy,
    this.onTap,
    this.height,
    this.width,
    this.fontSize,
    this.child,
  }) : super(key: key);

  @override
  DialogPositionedState createState() => DialogPositionedState();
}

class DialogPositionedState extends State<DialogPositioned> {
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
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: !showModal
          ? Container()
          : Container(
              alignment: Alignment.center,
              width: wp(100),
              height: hp(100),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTapDown: (tapDownDetails) {
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
                    left: widget.posx,
                    child: showModal ? widget.child : Container(),
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
    Navigator.pop(context);
  }

  void closeDialog() {
    setState(() {
      showModal = false;
    });
    Navigator.pop(context);
  }
}
