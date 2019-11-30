import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/grid_list.dart';
import 'package:epaisa_pos/src/views/point_of_sale/widgets/horizontal_list.dart';
import 'package:flutter/material.dart';

class ModalGrid extends StatefulWidget {
  final String message;
  final dynamic lw;
  final Widget secondContent;
  final double width;
  final double height;
  final double marginContent;

  ModalGrid(
      {Key key,
      this.message,
      this.width,
      this.height,
      this.lw,
      this.secondContent,
      this.marginContent})
      : super(key: key);

  @override
  ModalGridState createState() => ModalGridState();
}

class ModalGridState extends State<ModalGrid> {
  bool showModal = true;

  String title;
  int stateView = -1;
  @override
  void initState() {
    title = widget.message;

    super.initState();
  }

  void changeTitle(String newtitle) {
    setState(() {
      title = newtitle;
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
                                          top: hp(1.8), bottom: hp(1.2)),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 2,
                                                  color:
                                                      AppColors.DisabledText))),
                                      child: Text(
                                        title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize:
                                                tablet ? wp(1.85) : hp(2.3),
                                            color: AppColors.DarkGray,
                                            fontWeight: FontWeight.w700),
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
                                        child: Icon(Icons.close),
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
                                        stateView != -1
                                            ? Expanded(
                                                child: Column(
                                                  children: <Widget>[
                                                    HorizontalLists(
                                                      lw: widget.lw,
                                                      selected: stateView,
                                                    ),
                                                    GestureDetector(
                                                      child: Text("Press"),
                                                      onTap: closeModal,
                                                    ),
                                                    GridList(
                                                        children: widget.lw,
                                                        totalWidth: wp(88),
                                                        marginH: wp(1),
                                                        gridLength: 3,
                                                        height: hp(11),
                                                        onTapGeneral: (_sel) =>
                                                            closeModal())
                                                  ],
                                                ),
                                              )
                                            : GridList(
                                                children: widget.lw,
                                                totalWidth: wp(88),
                                                marginH: wp(1),
                                                gridLength: 3,
                                                height: hp(11),
                                                onTapGeneral: (_sel) {
                                                  changeTitle("Sub Categories");
                                                  setState(() {
                                                    stateView = _sel;
                                                  });
                                                }),
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
