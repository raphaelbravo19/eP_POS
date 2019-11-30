import 'dart:convert';

import 'package:jaguar/jaguar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_common.dart';

class PersonalBloc {
  final _loadingAddressController = BehaviorSubject<bool>();
  final _personAddressController = BehaviorSubject<String>();
  final _personAddress2Controller = BehaviorSubject<String>();
  final _personLocationAccess = BehaviorSubject<int>();

  Function(String) get personAddressSink => _personAddressController.sink.add;
  Function(String) get personAddress2Sink => _personAddress2Controller.sink.add;
  Sink<bool> get loadingAddressSink => _loadingAddressController.sink;
  Sink<int> get personLocationAccessSink => _personLocationAccess.sink;

  Stream<String> get personAddressStream => _personAddressController.stream;
  Stream<String> get personAddress2Stream => _personAddress2Controller.stream;
  Stream<bool> get loadingAddressStream => _loadingAddressController.stream;
  Stream<int> get personLocationAccessStream => _personLocationAccess.stream;

  //Method to get the current address
  getCurrentAddress(context) async {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var layoutwidth = tablet ? height * 0.20 : width * 0.25;
    var layoutHeight = tablet ? height * 0.70 : height * 0.6;

    bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();
    GeolocationStatus status =
        await Geolocator().checkGeolocationPermissionStatus();
    print("isLocationEnabled: " + isLocationEnabled.toString());
    //GeolocationStatus.denied

    if (isLocationEnabled) {
      if (status != GeolocationStatus.granted) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Allow access to the location services for this App using the device settings.",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: wp(10),
                    ),
                    ButtonGradiant(
                      layoutHeight * 0.025,
                      layoutwidth,
                      'OK',
                      textStyle: TextStyle(
                          fontSize: tablet
                              ? layoutHeight * 0.03
                              : layoutHeight * 0.025,
                          color: AppColors.PrimaryWhite,
                          fontWeight: FontWeight.w600),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await locate();
                      },
                    ),
                  ],
                ),
              );
            });
      } else {
        print("has permissions");
        await locate();
      }
    } else {
      print('isLocationEnabled: False');

      loadingAddressSink.add(false);
      personLocationAccessSink.add(2);
    }
  }

  locate() async {
    try {
      final val = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      print("position: ${val.latitude}");
      print("position: ${val.longitude}");
      final coordinates = new Coordinates(val.latitude, val.longitude);
      Geocoder.local
          .findAddressesFromCoordinates(coordinates)
          .then((addresses) {
        // var first = addresses.first;
        print('addresses.first.addressLine');
        print(addresses.first.addressLine);
        // print(
        //     'Address ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
        // print("Addressline: " +
        //     first.addressLine +
        //     '\n featureName ${first.featureName}, \n thoroughfare ${first.thoroughfare}, \locality  ${first.locality}, \n subAdminArea ${first.subAdminArea},\n subLocality ${first.subLocality}, ');

        // String local =
        //     "${first.featureName.toString() == null ? '' : first.featureName.toString()} ${first.thoroughfare.toString() == null ? '' : first.thoroughfare.toString()},";

        // String subLocality =
        //     "${first.subLocality.toString() == null ? '' : first.subLocality.toString()}";
        // if (subLocality == "null" || local == "null") {
        //   if (local == "null") {
        //     personLocationAccessSink.add(4);
        //   } else {
        //     // personLocationAccessSink.add(5);
        //   }
        // }

        // if (subLocality == "null") {
        //   subLocality = "";
        // }
        // if (local == "null") {
        //   subLocality = "";
        // }
        // if (addresses.first.addressLine == null) {
        //   personLocationAccessSink.add(4);
        // }

        // print("local" + local);

        //personAddressSink(addresses.first.addressLine);
        // personAddress2Sink(subLocality);
        loadingAddressSink.add(false);
      });
    } catch (e) {
      print('isLocationEnabled: False');
      loadingAddressSink.add(false);
      personLocationAccessSink.add(3);
    }
  }

  validate({personBloc, Widget child, BuildContext context}) {
    final dialog = DialogCommon(context: context);
    return StreamBuilder(
      stream: personBloc.personLocationAccessStream,
      builder: (context, snapshotLocationPermission) {
        if (snapshotLocationPermission.hasData) {
          final key = snapshotLocationPermission.data.toString();
          if (key == "2") {
            print("Location Off");
            dialog.basic(message: 'Please on your GPS setting');
          } else if (key == "1") {
            print("Location denied");
            dialog.basic(
                message:
                    "Allow access to the location services for this App using the device settings.");
          } else if (key == "3") {
            print("Location denied");
            dialog.basic(
                message:
                    'You need to allow access to the location services for this App using the device settings.');
          } else if (key == "4") {
            dialog.basic(message: "Couldn't find the location");
          } else if (key == "5") {
            dialog.basic(message: "Couldn't find the sublocation");
          } else {
            print("Location nothing");
          }
        }

        return child;
      },
    );
  }

  void dispose() {
    _loadingAddressController.close();
    _personAddressController.close();
    _personAddress2Controller.close();
    _personLocationAccess.close();
  }
}
