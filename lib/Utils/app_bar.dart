// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  bool showBack;
  VoidCallback? onPressed;

  // final Widget? w1;

  AppBarCustom(
      {Key? key, this.title = "Bookings", this.showBack = true, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: Colors.transparent,

      // automaticallyImplyLeading: false,
      shadowColor: Colors.transparent,
      toolbarHeight: kToolbarHeight + 40,
      leading: Padding(
        padding: const EdgeInsets.all(5),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: showBack == false
              ? const SizedBox()
              : CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 100,
                  child: SvgPicture.asset(
                    PathToImage.arrow,
                    // ignore: deprecated_member_use
                    color: Colors.white,
                    width: 15,
                    // height: 5,
                    height: 15,
                    clipBehavior: Clip.antiAlias,
                  ),
                ),
        ),
      ),

      title: Text(
        title,
        style: GoogleFonts.inter(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      ),

      centerTitle: true,
      // automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(
              PathToImage.appBar,
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

AppBar customBar(String title, bool showBack, context) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    backgroundColor: Colors.transparent,

    // automaticallyImplyLeading: false,
    shadowColor: Colors.transparent,
    toolbarHeight: kToolbarHeight + 40,
    leading: Padding(
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: showBack == false
            ? const SizedBox()
            : SvgPicture.asset(
                PathToImage.arrow,
                // ignore: deprecated_member_use
                color: Colors.white,
                width: 5,
                // height: 5,
                clipBehavior: Clip.antiAlias,
              ),
      ),
    ),

    title: Text(
      title,
      style: GoogleFonts.inter(
          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
    ),

    centerTitle: true,
    // automaticallyImplyLeading: false,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage(
            PathToImage.appBar,
          ),
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}
