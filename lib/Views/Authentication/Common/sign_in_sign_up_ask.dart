import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Views/OnBoarding/Common/text_button.dart';

// ignore: must_be_immutable
class SignInSingupAsk extends StatelessWidget {
  String question;
  String link;
  VoidCallback onPress;
  SignInSingupAsk(
      {super.key,
      required this.question,
      required this.link,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question,
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.lightGrey),
          ),
          TexttButton(
              onPressed: onPress,
              googleFonts: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor),
              text: link),
        ],
      ),
    );
  }
}
