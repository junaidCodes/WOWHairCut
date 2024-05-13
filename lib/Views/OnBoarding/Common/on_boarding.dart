import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class OnBoarding extends StatefulWidget {
  String path;
  String title;
  String subtitle;
  OnBoarding(
      {super.key,
      required this.path,
      required this.title,
      required this.subtitle});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.125,
                // height: 95,
              ),
              Center(
                child: SizedBox(
                  child: Image.asset(
                    widget.path,
                    width: 300,
                    height: 200,
                    fit: BoxFit.contain,

                    // fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                // height: 40,
                height: MediaQuery.of(context).size.height * 0.053,
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        // width: 300,
                        // height: 74,
                        // color: Colors.amber,
                        child: Text(
                          widget.title,
                          style: GoogleFonts.inter(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        // height: 50,
                        width: 300,
                        child: Text(
                          widget.subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xFF7F7F7F),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
