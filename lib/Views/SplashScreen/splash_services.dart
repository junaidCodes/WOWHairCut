import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowcut/Routes/route_name.dart';

class SplashServices {
  int? initScreen;

  Future locationCheck(BuildContext context) async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.bottomBarr, (route) => false);
    } else {}
  }

  checkLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool firstTime = prefs.getBool('first_time') ?? true;
    initScreen = await prefs.getInt("initScreen");
    await prefs.setInt("initScreen", 1);
    FirebaseAuth _auth = FirebaseAuth.instance;

    final user = _auth.currentUser;
    // initialRoute:
    //         initScreen == 0 || initScreen == null ? "firstTime" : "secondTime";
    if (initScreen == 0 || initScreen == null) {
      Timer(const Duration(seconds: 1), () {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.onBoardSlider, (route) => false);
      });
    } else {
      if (user != null) {
        Timer(const Duration(seconds: 1), () {
          locationCheck(context).then((value) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.bottomBarr, (route) => false);
          }).onError((error, stackTrace) {
            log("error");
          });
        });
      } else {
        Timer(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.signInView, (route) => false);
        });
      }
    }
  }
}
