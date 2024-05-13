// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Utils/app_colors.dart';

class BookingButton extends StatefulWidget {
  // VoidCallback onPressed;
  // double height;
  // double width;
  // Color buttonColor;
  // Color textColor;
  // String text;

  VoidCallback onPressed;

  Color buttonColor;
  Color textColor;
  String title;
  String subTitle;

  BookingButton(
      {super.key,
      this.title = "",
      required this.subTitle,
      required this.buttonColor,
      required this.textColor,
      required this.onPressed});

  @override
  State<BookingButton> createState() => _BookingButtonState();
}

class _BookingButtonState extends State<BookingButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 85,
      width: MediaQuery.of(context).size.width * 0.22,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
          )),

      child: TextButton(
          style: TextButton.styleFrom(backgroundColor: widget.buttonColor),
          onPressed: widget.onPressed,
          child: Column(
            children: [
              Center(
                child: Text(
                  widget.title,
                  style: GoogleFonts.inter(
                      // fontSize: 11,
                      fontSize: MediaQuery.of(context).size.height * 0.014,
                      fontWeight: FontWeight.w300,
                      color: widget.textColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  widget.subTitle,
                  style: GoogleFonts.inter(
                      // fontSize: 14,
                      fontSize: MediaQuery.of(context).size.height * 0.0175,
                      fontWeight: FontWeight.w500,
                      color: widget.textColor),
                ),
              )
            ],
          )),
    );
  }
}
