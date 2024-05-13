// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Utils/bottom_bar.dart';
import 'package:wowcut/Views/Authentication/Location/location_manually.dart';

class LocationServices {
  Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      context.showSnackBar(
          "Location services are disabled. Please enable the services'");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        context.showSnackBar(
            "Location services are disabled. Please enable the services");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      context.showSnackBar(
          "permissions are permanently denied, we cannot request permissions");
      return false;
    }
    return true;
  }

  String? currentAddress;

  Position? currentPosition;
  Future<void> getAddress(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemark) {
      Placemark place = placemark[0];
      // setState(() {
      currentAddress = '${place.subAdministrativeArea}';
      // });

      MyValueNotifier.setMyDoubleValue(currentPosition!.latitude,
          currentPosition!.longitude, currentAddress.toString());
    }).onError((error, stackTrace) {
      // context.showSnackBar(error.toString());
    });
  }

  Future<void> getCurrentLocation(BuildContext context) async {
    final haspermission =
        await LocationServices().handleLocationPermission(context);
    if (!haspermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      // setState(() {
      currentPosition = position;
      // });
      getAddress(currentPosition!);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomBarr(
              currentAddress: currentAddress.toString(),
            ),
          ));
    }).onError((error, stackTrace) {
      context.showSnackBar(error.toString());
    });
  }
}
