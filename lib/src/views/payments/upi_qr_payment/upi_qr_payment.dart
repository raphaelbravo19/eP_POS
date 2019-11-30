import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/buttons/epaisa_button.dart';
import 'package:flutter/material.dart';

class UpiQrPayment extends StatefulWidget {
  const UpiQrPayment({
    Key key,
    @required this.sHeight,
  }) : super(key: key);

  final double sHeight;

  @override
  _UpiQrPaymentState createState() => _UpiQrPaymentState();
}

class _UpiQrPaymentState extends State<UpiQrPayment> {
  var collectNow = true;
  @override
  Widget build(BuildContext context) {
    final tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final inputFontSize = hp(tablet ? 3 : 2.6);

    return Container(
      // color: Colors.green,
      // height: widget.sHeight * 0.80,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(hp(1)),
              child: Image.network(
                'https://chart.googleapis.com/chart?chs=500x500&cht=qr&chl=http://misapinga.com&chld=L|1&choe=UTF-8',
                width: hp(40),
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
