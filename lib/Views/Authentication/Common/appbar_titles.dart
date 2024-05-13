// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Utils/app_colors.dart';

class AppbarTitles extends StatelessWidget {
  String title;
  String subtitle;
  double fontSize;
  double fontSizeSub;
  FontWeight titleFontWeight;
  FontWeight subTitleFontWeight;
  double heightBetween;
  AppbarTitles(
      {super.key,
      required this.title,
      required this.subtitle,
      this.fontSize = 28,
      this.fontSizeSub = 16,
      this.titleFontWeight = FontWeight.w500,
      this.subTitleFontWeight = FontWeight.w300,
      this.heightBetween = 20});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(
          title,
          style: GoogleFonts.inter(
              fontSize: fontSize, fontWeight: titleFontWeight),
          textAlign: TextAlign.center,
        )),
        SizedBox(
          height: heightBetween,
          // height: MediaQuery.of(context).size.height * 0.027,
        ),
        SizedBox(
          // height: 40,
          width: 300,
          child: Text(
            subtitle,
            style: GoogleFonts.inter(
                fontSize: fontSizeSub,
                fontWeight: FontWeight.w300,
                color: AppColors.lightGrey),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
