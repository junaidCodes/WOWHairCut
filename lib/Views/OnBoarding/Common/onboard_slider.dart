// ignore_for_file: unused_local_variable

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wowcut/Common/media_query.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Views/OnBoarding/Common/text_button.dart';
import 'package:wowcut/Views/OnBoarding/onboarding_3.dart';
import 'package:wowcut/Views/OnBoarding/onboarding_1.dart';
import 'package:wowcut/Views/OnBoarding/onboarding_2.dart';

class OnBoardSlider extends StatefulWidget {
  const OnBoardSlider({super.key});

  @override
  State<OnBoardSlider> createState() => _OnBoardSliderState();
}

class _OnBoardSliderState extends State<OnBoardSlider> {
  final controllerx = PageController();

  List onBoardList = [OnBoarding1View(), OnBoarding2View(), OnBoarding3View()];
  int currentIndex = 0;
  int newindex = 0;

  @override
  Widget build(BuildContext context) {
    double h = context.height;
    double w = context.width;

    // SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.white,
    //   // systemNavigationBarIconBrightness: Brightness.light
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        child: SizedBox(
          height: h,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 580,
                    child: PageView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollBehavior: const ScrollBehavior(),
                      controller: controllerx,
                      children: [
                        ...List.generate(3, (index) => onBoardList[index]),
                        // for (int i = 0; i < 3; i++) onBoardList[i],
                      ],
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height * 0.025,
                            top: MediaQuery.of(context).size.height * 0.062),
                        child: SizedBox(
                            height: 40,
                            //10,
                            width: 60,
                            //33,
                            child: TexttButton(
                                googleFonts: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.secondaryColor),
                                text: "Skip",
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      RouteName.signInView, (route) => false);
                                })),
                      )),
                  Positioned(
                    top: 545,
                    // top: MediaQuery.of(context).size.height * 0.69,
                    left: MediaQuery.of(context).size.width * 0.42,
                    child: SmoothPageIndicator(
                      controller: controllerx,
                      count: 3,
                      effect: ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: AppColors.primaryColor,
                          dotColor: Colors.grey.withOpacity(0.1)
                          // strokeWidth: 4
                          // dotColor: Colors.green,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 0,
                // height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70, right: 70
                    // top: MediaQuery.of(context).size.height * 0.85,
                    // left: MediaQuery.of(context).size.height * 0.11\
                    ),
                child: PrimaryButton(
                    text: "Next",
                    onPressed: () {
                      if (currentIndex < onBoardList.length - 1) {
                        setState(() {
                          currentIndex++;
                          controllerx.animateToPage(currentIndex,
                              duration: const Duration(seconds: 2),
                              curve: Curves.ease);
                        });
                      } else if (currentIndex == 2) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RouteName.signInView, (route) => false);
                        currentIndex = 0;
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
