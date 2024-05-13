// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Views/OnBoarding/Common/on_boarding.dart';

// ignore: must_be_immutable
class OnBoarding1View extends StatelessWidget {
  String title = "Discover Beauty\n Heavens";

  String subtitle = "Unlock the beauty secrets hidden in your neighborhood!";

  String imgPath = PathToImage.onBoard1;

  @override
  Widget build(BuildContext context) {
    return OnBoarding(
      path: imgPath,
      title: title,
      subtitle: subtitle,
    );
  }
}
