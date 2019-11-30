import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:flutter/material.dart';

class DialogSelectPrinter extends StatefulWidget {
  final Function close;
  DialogSelectPrinter({
    this.close,
  });

  @override
  _DialogSelectPrinterState createState() => _DialogSelectPrinterState();
}

class _DialogSelectPrinterState extends State<DialogSelectPrinter> {
  var _selected = 0;
  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    final double sWidth = tablet ? hp(75) : MediaQuery.of(context).size.width;
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
              onTap: () {
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
                  width: sWidth * 0.85,
                  child: EpaisaCard(
                    borderRadius: BorderRadius.circular(16),
                    header: Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: hp(2)),
                          child: Text(
                            'Select Printer',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: tablet ? hp(4) : hp(3),
                              color: AppColors.BackPrimaryGray,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            onPressed: () => widget.close(),
                            icon: Image.asset(
                              'assets/general_icons/xbutton.png',
                              height: hp(2.4),
                            ),
                          ),
                        )
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        padding: EdgeInsets.all(tablet ? hp(4) : hp(3)),
                        child: Row(
                          children: <Widget>[
                            PrinterOption(
                              selected: _selected == 0,
                              tablet: tablet,
                              margin: EdgeInsets.only(
                                  right: tablet ? hp(4) : hp(3)),
                              width:
                                  ((sWidth * 0.85) - hp(tablet ? 12 : 9)) / 2,
                              onTap: () {
                                setState(() {
                                  _selected = 0;
                                });
                              },
                            ),
                            PrinterOption(
                              selected: _selected == 1,
                              tablet: tablet,
                              margin: EdgeInsets.only(
                                  right: tablet ? hp(4) : hp(3)),
                              width:
                                  ((sWidth * 0.85) - hp(tablet ? 12 : 9)) / 2,
                              onTap: () {
                                setState(() {
                                  _selected = 1;
                                });
                              },
                            ),
                            PrinterOption(
                              selected: _selected == 2,
                              tablet: tablet,
                              width:
                                  ((sWidth * 0.85) - hp(tablet ? 12 : 9)) / 2,
                              onTap: () {
                                setState(() {
                                  _selected = 2;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PrinterOption extends StatelessWidget {
  final EdgeInsets margin;
  final double width;
  final bool tablet;
  final bool selected;
  final Function onTap;
  const PrinterOption({
    Key key,
    this.tablet = false,
    this.selected = false,
    this.onTap,
    @required this.width,
    this.margin = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: EpaisaCard(
        color: selected ? AppColors.IconGray : AppColors.PrimaryWhite,
        margin: margin,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: width,
          padding: EdgeInsets.all(hp(1)),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: hp(1)),
                child: Text(
                  'Printer 1',
                  style: TextStyle(
                    fontSize: tablet ? hp(2.8) : wp(5),
                    fontWeight: FontWeight.w600,
                    color: AppColors.BackPrimaryGray,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.6),
                      blurRadius: 0.5,
                      offset: Offset(1, 1),
                      // spreadRadius: 1,
                    )
                  ],
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/payments/icons/printer_main.png',
                  height: tablet ? hp(15) : hp(10),
                  width: tablet ? hp(15) : hp(10),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: hp(1)),
                child: FittedBox(
                  child: Text(
                    'Model: HP102',
                    style: TextStyle(
                      fontSize: tablet ? hp(2.5) : wp(3.6),
                      fontWeight: FontWeight.w600,
                      color: AppColors.BackPrimaryGray,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
