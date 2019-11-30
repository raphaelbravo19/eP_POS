import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeScanner {
  static Future scan({
    @required Function onSuccess,
    @required Function onError,
    @required Function onBackButton,
  }) async {
    String barcode = await BarcodeScanner.scan();
    try {
      onSuccess(barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        onError('The user did not grant the camera permission!');
      } else {
        onError('Unknown error: $e');
      }
    } on FormatException {
      print('back button');
      onBackButton(
          'User returned using the "back"-button before scanning anything');
    } catch (e) {
      onError('Unknown error: $e');
    }
  }
}
