import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ListileWidget extends StatelessWidget {
  String icon;
  String title;
  VoidCallback onPress;
  ListileWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPress});

  get profileTitles => null;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(icon),
      title: Text(
        title,
        style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onTap: onPress,
    );
  }
}
