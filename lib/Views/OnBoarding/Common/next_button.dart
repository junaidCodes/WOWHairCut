import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Utils/app_colors.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 176,
      height: 51,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(25.5)),
      child: Center(
        child: Text(
          "Next",
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }
}
