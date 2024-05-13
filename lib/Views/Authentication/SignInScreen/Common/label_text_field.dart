import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LabelTextField extends StatelessWidget {
  String label;
  LabelTextField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              label,
              style:
                  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400),
            )),
        const SizedBox(
          height: 7,
        )
      ],
    );
  }
}
