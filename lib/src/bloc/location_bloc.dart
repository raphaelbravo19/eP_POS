import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:epaisa_pos/src/models/Location.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_with_close.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import './bloc.dart';

showMessage(context, message) {
  Navigator.of(context).push(
    new PageRouteBuilder(
      opaque: false,
      pageBuilder: (ctx, _, __) {
        return DialogWithClose(
          message: message,
        );
      },
    ),
  );
}

Future<Location> getLocation(BuildContext context) async {
  print('getLocation');

  print("Enabling");
  bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();
  print("Enabled $isLocationEnabled");
  if (!isLocationEnabled) {
    print("bad");
    throw Exception("Please enable your location");
    //return Location();
  }

  final val = await Geolocator().getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  final coordinates = new Coordinates(val.latitude, val.longitude);
  final addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
  print('addresses.first.addressLine');
  print(addresses.first.toMap());
  final address = addresses.first.toMap();
  final Location location = Location.fromMap(address);
  print('location.shortAddress');
  print(location.shortAddress);
  /* if (location.shortAddress == null) {
    showMessage(
      context,
      'Unable to Fetch: \n${location.shortAddress == null ? '- Address' : ''}${'\n${location.cityWithPostal}' == null ? '- City' : ''}',
    );
  } */
  await Future.delayed(Duration(seconds: 2));
  return location;
}

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  @override
  LocationState get initialState => LocationInitial();

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is GetLocation) {
      yield LocationLoading();

      final location = await getLocation(event.context);
      yield LocationLoaded(location);
    } else if (event is StopLocation) {
      print('stop');
      yield LocationLoaded(Location());
    }
  }
}
