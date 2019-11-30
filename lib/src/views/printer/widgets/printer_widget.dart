import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/devices/device_screen.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_toggle.dart';
import 'package:epaisa_pos/src/widgets/cards/paired_card.dart';
import 'package:flutter/material.dart';

class PrinterWidget extends StatefulWidget {
  @override
  _PrinterWidgetState createState() => _PrinterWidgetState();
}

class _PrinterWidgetState extends State<PrinterWidget> {
  var _selected = 0;
  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final bool tablet = isTablet(MediaQuery.of(context));
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.65 : width * 0.85;
    var layoutHeight = tablet ? height : height * 0.8;

    Widget printerTitle() {
      return Column(
        children: <Widget>[
          Text(
            "Paired Printers",
            style: TextStyle(
              color: AppColors.PrimaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: tablet ? hp(2.5) : wp(5),
            ),
          ),
          Text(
            "Enable paired printers to be used with ePaisa",
            style: TextStyle(
              fontSize: tablet ? hp(2.5) : wp(3.2),
              fontWeight: FontWeight.w500,
              color: AppColors.DarkGray,
            ),
          )
        ],
      );
    }

    Widget noPrinterImage() {
      return Padding(
        padding: EdgeInsets.only(
            top: tablet ? hp(1) : wp(10), bottom: tablet ? hp(2) : wp(8)),
        child: Column(
          children: <Widget>[
            Image.asset("assets/general_icons/NoPrinter.png",
                height: tablet ? hp(10) : wp(15),
                width: tablet ? hp(10) : wp(15)),
            SizedBox(
              height: tablet ? hp(3) : wp(5),
            ),
            Text(
              "No Printers Detected",
              style: TextStyle(
                  color: AppColors.NoPrinterText,
                  fontWeight: FontWeight.bold,
                  fontSize: tablet ? hp(2) : wp(5)),
            )
          ],
        ),
      );
    }

    Widget addNewPrinter() {
      return Column(
        children: <Widget>[
          SizedBox(
            height: tablet ? hp(2) : wp(5),
          ),
          Text(
            "Add New Printer",
            style: TextStyle(
              color: AppColors.PrimaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: tablet ? hp(2.5) : wp(5),
            ),
          ),
          Text(
            "Detect and pair new printers",
            style: TextStyle(
              fontSize: tablet ? hp(2) : wp(3.2),
              fontWeight: FontWeight.w500,
              color: AppColors.DarkGray,
            ),
          )
        ],
      );
    }

    Widget buildDetectPrinterButton() {
      return Padding(
        padding: EdgeInsets.all(tablet ? hp(2) : wp(5)),
        child: ButtonGradiant(
          layoutHeight * 0.025,
          layoutwidth,
          'DETECT PRINTER',
          textStyle: TextStyle(
              fontSize: tablet ? hp(2) : wp(2),
              color: AppColors.PrimaryWhite,
              fontWeight: FontWeight.w600),
          onPressed: () {
            //print("Hola");
            //loginBloc.submit(this);
          },
        ),
      );
    }

    Widget buildPairedPrinters() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            tablet
                ? SizedBox()
                : Container(
                    height: tablet ? hp(40) : wp(43),
                    decoration: BoxDecoration(
                        color: AppColors.sideArrowColor,
                        borderRadius: BorderRadius.only(
                            //topLeft: const Radius.circular(40.0),
                            //bottomLeft: const Radius.circular(40.0),
                            bottomRight: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0))),
                    child: Center(
                        child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.SettingArrow,
                    ))),
            PairedAssignedCard(
                name: "Printer 1",
                icon: "assets/hardware/Printer.png",
                modelName: "Model : HP 102",
                color: _selected == 0
                    ? AppColors.IconGray
                    : AppColors.PrimaryWhite,
                onTap: () {
                  setState(
                    () {
                      _selected = 0;
                    },
                  );
                }),
            PairedAssignedCard(
                name: "Printer 2",
                icon: "assets/hardware/Printer.png",
                modelName: "Model : HP 102",
                color: _selected == 1
                    ? AppColors.IconGray
                    : AppColors.PrimaryWhite,
                onTap: () {
                  setState(
                    () {
                      _selected = 1;
                    },
                  );
                }),
            PairedAssignedCard(
                name: "Printer 3",
                icon: "assets/hardware/Printer.png",
                modelName: "Model : HP 102",
                color: _selected == 2
                    ? AppColors.IconGray
                    : AppColors.PrimaryWhite,
                onTap: () {
                  setState(
                    () {
                      _selected = 2;
                    },
                  );
                }),
            tablet
                ? SizedBox()
                : Container(
                    height: tablet ? hp(40) : wp(43),
                    decoration: BoxDecoration(
                        color: AppColors.sideArrowColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          bottomLeft: const Radius.circular(10.0),
                        )),
                    child: Center(
                        child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.SettingArrow,
                    ))),
          ],
        ),
      );
    }

    Widget buildPrinter() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: tablet ? hp(2) : wp(5),
          ),
          printerTitle(),
          //noPrinterImage(),
          buildPairedPrinters(),
          Divider(
            color: AppColors.DarkGray,
          ),
          addNewPrinter(),
          buildDetectPrinterButton()
        ],
      );
    }

    return buildPrinter();
  }
}
