import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingButton2 extends StatelessWidget {
  // final VoidCallback onPressed;
  VoidCallback onPressed;
  Color buttonColor;
  Color textColor;
  // String title;
  String subTitle;

  BookingButton2(
      {super.key,
      // this.title = "",
      required this.subTitle,
      required this.buttonColor,
      required this.textColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          // width: 85,
          width: MediaQuery.of(context).size.width * 0.22,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(35),
              border: Border.all(
                color: Colors.grey.withOpacity(0.1),
              )),
          // width: MediaQuery.of(context).size.width * 0.27,
          child: Center(
            child: Text(
              subTitle,
              style: GoogleFonts.inter(
                  // fontSize: 14,
                  fontSize: MediaQuery.of(context).size.height * 0.0175,
                  fontWeight: FontWeight.w500,
                  color: textColor),
            ),
          )),
    );
  }
}
