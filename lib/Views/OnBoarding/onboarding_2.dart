import 'package:flutter/material.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Views/OnBoarding/Common/on_boarding.dart';

// ignore: must_be_immutable
class OnBoarding2View extends StatelessWidget {
  String title = "Effortless Appointments Bookings";

  String subtitle =
      "Pick your dream solon, choose your preferred date, and secure your spot in a few taps.";

  String imgPath = PathToImage.onBoard2;

  @override
  Widget build(BuildContext context) {
    return OnBoarding(path: imgPath, title: title, subtitle: subtitle);
  }
}
