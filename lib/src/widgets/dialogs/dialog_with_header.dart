import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class DialogWithHeader extends StatefulWidget {
  final String message;
  final Widget content;
  final Widget secondContent;
  final double width;
  final double height;
  final double marginContent;

  DialogWithHeader({
    Key key,
    this.message,
    this.width,
    this.height,
    this.content,
    this.secondContent,
    this.marginContent,
  }) : super(key: key);

  @override
  DialogWithHeaderState createState() => DialogWithHeaderState();
}

class DialogWithHeaderState extends State<DialogWithHeader> {
  bool showModal = true;
  Widget content;
  String title;
  @override
  void initState() {
    // TODO: implement initState
    title = widget.message;
    content = widget.content;
    super.initState();
  }

  void changeTitle(String newtitle) {
    setState(() {
      title = newtitle;
    });
  }

  void changeContent(Widget scontent) {
    setState(() {
      content = scontent;
    });
  }

  void closeModal() {
    Navigator.of(context).pop();
    setState(() {
      showModal = false;
    });
  }
  //Navigator.of(context).pop();

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
        child: !showModal
            ? Container()
            : Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showModal = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: wp(100),
                      height: hp(100),
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          width: widget.width,
                          height: widget.height,
                          decoration: BoxDecoration(
                              color: AppColors.PrimaryWhite,
                              borderRadius: BorderRadius.circular(hp(2))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: widget.width,
                                      padding: EdgeInsets.only(
                                          top: hp(2.4), bottom: hp(1.7)),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 2,
                                            color: AppColors.DisabledText,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: tablet ? wp(2.4) : hp(2.3),
                                          color: AppColors.DarkGray,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: wp(2),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showModal = false;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Image.asset(
                                          "assets/general_icons/xbutton.png",
                                          height: tablet ? hp(3) : hp(2),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    padding:
                                        EdgeInsets.all(widget.marginContent),
                                    child: Column(
                                      children: <Widget>[
                                        content,
                                      ],
                                    )),
                              ),
                            ],
                          )),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
