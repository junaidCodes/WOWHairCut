// ignore_for_file: unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Utils/app_colors.dart';

class TexttButton extends StatelessWidget {
  TextStyle googleFonts;
  VoidCallback onPressed;
  double paddings;
  String text;
  TexttButton(
      {super.key,
      required this.googleFonts,
      required this.text,
      required this.onPressed,
      this.paddings = 0.0});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.all(paddings)),
        onPressed: onPressed,
        child: Text(text, style: googleFonts

            //
            // GoogleFonts.inter(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w500,
            //     color: AppColors.primaryColor),
            ));
  }
}
