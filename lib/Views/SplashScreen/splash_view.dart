import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Views/SplashScreen/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices splash = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash.checkLogin(context);

    // Timer(const Duration(seconds: 2), () {
    //   // ElevatedButton(onPressed: () {}, child: Text("Get Started"));

    //   Navigator.pushNamedAndRemoveUntil(
    //       context, RouteName.onBoardSlider, (route) => false);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1,
                child: Image.asset(
                  PathToImage.splash,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      PathToImage.splashLogo,
                      height: 74.80,
                      width: 68.39,
                    ),
                    Text(
                      "WOW HAIR ",
                      style: GoogleFonts.oswald(
                          fontSize: 42.361,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        "SMART CUT",
                        style: GoogleFonts.inter(
                            fontSize: 18.327,
                            letterSpacing: 8.797,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
