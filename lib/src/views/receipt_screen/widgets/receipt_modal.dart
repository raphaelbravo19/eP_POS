import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:flutter/material.dart';

class ReceiptModal extends StatefulWidget {
  ReceiptModal({
    Key key,
  }) : super(key: key);

  @override
  ReceiptModalState createState() => ReceiptModalState();
}

class ReceiptModalState extends State<ReceiptModal> {
  bool showModal = true;

  @override
  void initState() {
    super.initState();
  }

  void closeModal() {
    Navigator.of(context).pop();
    setState(() {
      showModal = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    Widget header() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: hp(1)),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1), top: BorderSide(width: 1))),
        width: wp(82),
        child: Column(
          children: <Widget>[
            Text(
              "OM GENERAL STORE",
              style: TextStyle(
                  fontSize: tablet ? hp(2.8) : hp(2),
                  fontWeight: FontWeight.w700,
                  color: AppColors.DarkGray),
            ),
            Text(
              "B/103 Mahatma Gandhi Road,",
              style: TextStyle(
                  fontSize: tablet ? hp(1.6) : hp(1.15),
                  fontWeight: FontWeight.w600,
                  color: AppColors.DarkGray),
            ),
            Text(
              "Andheri West, Mumbai - 400093",
              style: TextStyle(
                  fontSize: tablet ? hp(1.6) : hp(1.15),
                  fontWeight: FontWeight.w600,
                  color: AppColors.DarkGray),
            ),
            Text(
              "Mob +91 98765 43210",
              style: TextStyle(
                  fontSize: tablet ? hp(1.6) : hp(1.15),
                  fontWeight: FontWeight.w600,
                  color: AppColors.DarkGray),
            )
          ],
        ),
      );
    }

    Widget data() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
        width: wp(82),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "***",
                  style: TextStyle(
                      height: 1.5,
                      fontSize: tablet ? hp(4) : hp(3.6),
                      fontWeight: FontWeight.w900,
                      color: AppColors.DarkGray),
                ),
                SizedBox(
                  width: tablet ? wp(2) : wp(3),
                ),
                Text(
                  "RECEIPT",
                  style: TextStyle(
                      fontSize: tablet ? hp(4.5) : hp(3.6),
                      fontWeight: FontWeight.w700,
                      color: AppColors.DarkGray),
                ),
                SizedBox(
                  width: tablet ? wp(2) : wp(3),
                ),
                Text(
                  "***",
                  style: TextStyle(
                      height: 1.5,
                      fontSize: tablet ? hp(4) : hp(3.6),
                      fontWeight: FontWeight.w900,
                      color: AppColors.DarkGray),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Sachin Kambli",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : hp(1.8),
                      fontWeight: FontWeight.w700,
                      color: AppColors.DarkGray),
                ),
                Text(
                  "10 April 2019",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : hp(1.8),
                      fontWeight: FontWeight.w700,
                      color: AppColors.DarkGray),
                ),
              ],
            ),
            SizedBox(
              height: hp(0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Payment ID : 24410",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : hp(1.8),
                      fontWeight: FontWeight.w700,
                      color: AppColors.DarkGray),
                ),
                Text(
                  "04:22 PM",
                  style: TextStyle(
                      fontSize: tablet ? hp(2.2) : hp(1.8),
                      fontWeight: FontWeight.w700,
                      color: AppColors.DarkGray),
                ),
              ],
            ),
            SizedBox(
              height: hp(2),
            ),
          ],
        ),
      );
    }

    Widget _table() {
      List<Map<String, dynamic>> products = [
        {
          "id": "1.",
          "description": "Heinz Ketchup",
          "Qty": "1",
          "Price": "145.00"
        },
        {
          "id": "2.",
          "description": "Custom Product 2",
          "Qty": "1",
          "Price": "125.00"
        },
        {
          "id": "3.",
          "description": "Custom Product 3",
          "Qty": "3",
          "Price": "275.50"
        },
      ];
      return Container(
        padding: EdgeInsets.only(bottom: hp(0.5)),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
        width: wp(82),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text("Qty",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: tablet ? hp(2.1) : hp(1.8),
                          fontWeight: FontWeight.w700,
                          color: AppColors.BackPrimaryGray.withOpacity(0.9))),
                ),
                SizedBox(
                  width: tablet ? wp(1.5) : wp(4),
                ),
                Expanded(
                  flex: 5,
                  child: Text("Description",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: tablet ? hp(2.1) : hp(1.8),
                          fontWeight: FontWeight.w700,
                          color: AppColors.BackPrimaryGray.withOpacity(0.9))),
                ),
                Expanded(
                  flex: 3,
                  child: Text("Price",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: tablet ? hp(2.1) : hp(1.8),
                          fontWeight: FontWeight.w700,
                          color: AppColors.BackPrimaryGray.withOpacity(0.9))),
                ),
              ],
            ),
            SizedBox(
              height: hp(1),
            ),
            Container(
              height: tablet ? hp(11.2) : hp(10),
              child: ScrollConfiguration(
                behavior: RemoveOverScrollGlow(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: products
                        .asMap()
                        .map((i, value) => MapEntry(
                            i,
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: hp(0.45)),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Text("${products[i]["Qty"]}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize:
                                                tablet ? hp(2.3) : hp(1.9),
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.BackPrimaryGray)),
                                  ),
                                  SizedBox(width: tablet ? wp(1.5) : wp(4)),
                                  Expanded(
                                    flex: 5,
                                    child: Text("${products[i]["description"]}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize:
                                                tablet ? hp(2.3) : hp(1.9),
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.BackPrimaryGray)),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text("₹ ${products[i]["Price"]}",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize:
                                                tablet ? hp(2.3) : hp(1.88),
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.PrimaryBlue)),
                                  ),
                                ],
                              ),
                            )))
                        .values
                        .toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _total() {
      List<Map<String, dynamic>> taxes = [
        {"description": "CGST", "value": "9", "total": "55.00"},
      ];
      List<Widget> widgets = List<Widget>();
      for (var i = 0; i < taxes.length; i++) {
        widgets.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("${taxes[i]["description"]} @ ${taxes[i]["value"]}%",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: tablet ? hp(2.4) : hp(1.9),
                      fontWeight: FontWeight.w600,
                      color: AppColors.BackPrimaryGray.withOpacity(0.9))),
              Text("₹ ${taxes[i]["total"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: tablet ? hp(2.4) : hp(1.9),
                      fontWeight: FontWeight.w600,
                      color: AppColors.PrimaryBlue))
            ],
          ),
        );
        widgets.add(SizedBox(
          height: hp(0.3),
        ));
      }
      return Container(
        padding: EdgeInsets.only(bottom: hp(0.5)),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
        width: wp(82),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(eptxt('sub_total'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: tablet ? hp(2.4) : hp(1.9),
                        fontWeight: FontWeight.w700,
                        color: AppColors.BackPrimaryGray.withOpacity(0.9))),
                Text("₹ 548.50",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: tablet ? hp(2.4) : hp(1.9),
                        fontWeight: FontWeight.w600,
                        color: AppColors.PrimaryBlue)),
              ],
            ),
            SizedBox(
              height: hp(0.3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Discount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: tablet ? hp(2.4) : hp(1.9),
                        fontWeight: FontWeight.w600,
                        color: AppColors.DiscountText)),
                Text("₹ 12.50",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: tablet ? hp(2.4) : hp(1.9),
                        fontWeight: FontWeight.w600,
                        color: AppColors.DiscountText))
              ],
            ),
            SizedBox(
              height: hp(0.3),
            ),
            ...widgets,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(eptxt('total_amount'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: tablet ? hp(2.7) : hp(2.3),
                        fontWeight: FontWeight.w700,
                        color: AppColors.BackPrimaryGray.withOpacity(0.9))),
                Text("₹ 570.00",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: tablet ? hp(2.7) : hp(2.3),
                        fontWeight: FontWeight.w700,
                        color: AppColors.PrimaryBlue))
              ],
            ),
            SizedBox(
              height: hp(0.3),
            ),
          ],
        ),
      );
    }

    Widget _thanks() {
      return Container(
          padding: EdgeInsets.symmetric(vertical: tablet ? hp(1.2) : hp(1)),
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
          width: wp(82),
          child: Text(
            "THANK YOU FOR SHOPPING!",
            style: TextStyle(
                fontSize: tablet ? hp(1.9) : hp(1.5),
                fontWeight: FontWeight.w700,
                color: AppColors.DarkGray),
          ));
    }

    Widget _barcode() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: hp(3)),
        margin: EdgeInsets.only(top: hp(1)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/receipt/barcode.png"))),
        height: hp(7),
      );
    }

    Widget content() {
      return Container(
        width: tablet ? wp(39) : wp(95),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, hp(1), hp(1), hp(1)),
                width: tablet ? wp(39) : wp(95) - hp(1),
                alignment: Alignment.topRight,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showModal = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      "assets/general_icons/xbutton.png",
                      height: tablet ? hp(2.8) : hp(2.2),
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: tablet ? wp(2.5) : wp(6.5)),
                child: Column(
                  children: <Widget>[
                    header(),
                    data(),
                    SizedBox(
                      height: hp(1),
                    ),
                    _table(),
                    SizedBox(
                      height: hp(1),
                    ),
                    _total(),
                    _thanks(),
                    _barcode()
                  ],
                ),
              ),
            ]),
      );
    }

    List<Widget> _theethUp() {
      List<Widget> upList = new List<Widget>();
      upList.add(
        ClipPath(
          child: Container(
            width: (tablet ? wp(39) : wp(95)) /
                (((tablet ? wp(39) : wp(95)) / (tablet ? wp(1) : wp(2.5)))
                    .toInt()) /
                2,
            height: hp(0.7),
            decoration: BoxDecoration(
                color: AppColors.PrimaryWhite,
                border: Border(
                    bottom:
                        BorderSide(color: AppColors.PrimaryWhite, width: 1))),
          ),
          clipper: TriangleUpClipper(half: true),
        ),
      );
      for (var i = 0;
          i <
              ((tablet ? wp(39) : wp(95)) / (tablet ? wp(1) : wp(2.5)))
                      .toInt() -
                  1;
          i++) {
        upList.add(
          ClipPath(
            child: Container(
              width: (tablet ? wp(39) : wp(95)) /
                  (((tablet ? wp(39) : wp(95)) / (tablet ? wp(1) : wp(2.5)))
                      .toInt()),
              height: hp(0.7),
              decoration: BoxDecoration(
                  color: AppColors.PrimaryWhite,
                  border: Border(
                      bottom:
                          BorderSide(color: AppColors.PrimaryWhite, width: 1))),
            ),
            clipper: TriangleUpClipper(),
          ),
        );
      }
      upList.add(
        ClipPath(
          child: Container(
            width: (tablet ? wp(39) : wp(95)) /
                (((tablet ? wp(39) : wp(95)) / (tablet ? wp(1) : wp(2.5)))
                    .toInt()) /
                2,
            height: hp(0.7),
            decoration: BoxDecoration(
                color: AppColors.PrimaryWhite,
                border: Border(
                    bottom:
                        BorderSide(color: AppColors.PrimaryWhite, width: 1))),
          ),
          clipper: TriangleUpClipper(half: true, right: true),
        ),
      );
      return upList;
    }

    List<Widget> _theethDown() {
      List<Widget> downList = new List<Widget>();
      downList.add(
        ClipPath(
          child: Container(
            width: (tablet ? wp(39) : wp(95)) /
                (((tablet ? wp(39) : wp(95)) / (tablet ? wp(1) : wp(2.5)))
                    .toInt()) /
                2,
            height: hp(0.7),
            decoration: BoxDecoration(
                color: AppColors.PrimaryWhite,
                border: Border(
                    bottom:
                        BorderSide(color: AppColors.PrimaryWhite, width: 1))),
          ),
          clipper: TriangleDownClipper(half: true),
        ),
      );
      for (var i = 0;
          i <
              ((tablet ? wp(39) : wp(95)) / (tablet ? wp(1) : wp(2.5)))
                      .toInt() -
                  1;
          i++) {
        downList.add(
          ClipPath(
            child: Container(
              width: (tablet ? wp(39) : wp(95)) /
                  (((tablet ? wp(39) : wp(95)) / (tablet ? wp(1) : wp(2.5)))
                      .toInt()),
              height: hp(0.7),
              decoration: BoxDecoration(
                  color: AppColors.PrimaryWhite,
                  border: Border(
                      bottom:
                          BorderSide(color: AppColors.PrimaryWhite, width: 1))),
            ),
            clipper: TriangleDownClipper(),
          ),
        );
      }
      downList.add(
        ClipPath(
          child: Container(
            width: (tablet ? wp(39) : wp(95)) /
                (((tablet ? wp(39) : wp(95)) / (tablet ? wp(1) : wp(2.5)))
                    .toInt()) /
                2,
            height: hp(0.7),
            decoration: BoxDecoration(
                color: AppColors.PrimaryWhite,
                border: Border(
                    bottom:
                        BorderSide(color: AppColors.PrimaryWhite, width: 1))),
          ),
          clipper: TriangleDownClipper(half: true, right: true),
        ),
      );
      return downList;
    }

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
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: (tablet ? wp(39) : wp(95)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _theethUp(),
                        ),
                      ),
                      Container(
                        width: (tablet ? wp(39) : wp(95)),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColors.PrimaryWhite, width: 1)),
                            color: AppColors.PrimaryWhite),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.PrimaryWhite,
                                ),
                                child: content()),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: tablet ? wp(39) : wp(95),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _theethDown(),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}

class TriangleDownClipper extends CustomClipper<Path> {
  bool half;
  bool right;
  TriangleDownClipper({this.half: false, this.right: false});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(half ? right ? size.width : 0.0 : size.width / 2, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleDownClipper oldClipper) => false;
}

class TriangleUpClipper extends CustomClipper<Path> {
  bool half;
  bool right;
  TriangleUpClipper({this.half: false, this.right: false});
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(half ? right ? size.width : 0.0 : size.width / 2, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleUpClipper oldClipper) => false;
}
