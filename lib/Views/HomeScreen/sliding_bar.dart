import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';

class SlideBar extends StatefulWidget {
  const SlideBar({super.key});

  @override
  State<SlideBar> createState() => _SlideBarState();
}

class _SlideBarState extends State<SlideBar> {
  final PageController _controlleer = PageController();
  int indexCarousel = 0;
  int indexx = 3;
  CarouselController carouselController = CarouselController();

  List<String> offerList = [
    "Hey everyone, don't miss out on this awesome deal! We're offering 40% off.",
    "Hey everyone, don't miss out on this awesome deal! We're offering 30% off.",
    "Hey everyone, don't miss out on this awesome deal! We're offering 30% off.",
  ];
  List<String> offerPercentageList = [
    "40%",
    "30%",
    "55%",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            // viewportFraction: 0.88,
            viewportFraction: 0.83,

            initialPage: 0,

            enableInfiniteScroll: false,

            // viewportFraction: 1 / 1.1,

            height: 150.0,
            onPageChanged: (index, reason) {
              indexCarousel = index;
              setState(() {});
            },
          ),
          items: [
            0,
            1,
            2,
          ].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.only(right: 12),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  // margin: const EdgeInsets.symmetric(horizontal: 0.0),
                  decoration: const BoxDecoration(),
                  child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14)),
                      child: Stack(
                        // alignment: Alignment.bottomCenter,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Image.asset(
                              PathToImage.imgPathCarousal[i],
                              fit: BoxFit.cover,
                              // height: 190,
                              // width: 280,
                            ),
                          ),
                          Positioned(
                            // top: MediaQuery.of(context).size.height * 0.02,
                            top: 15,
                            left: 25,
                            child: Text(
                              "Up to",
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                          Positioned(
                            top: 65,
                            left: 20,
                            child: SizedBox(
                              width: 240,
                              // height: 58,
                              child: Text(
                                offerList[i],
                                style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 70,
                            child: Text(
                              offerPercentageList[i],
                              style: GoogleFonts.inter(
                                  fontSize: 42,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 3,
                                left: 25,
                              ),
                              child: PrimaryButton(
                                  fontSize: 10,
                                  height: 26,
                                  width: 90,
                                  text: "Register",
                                  onPressed: () {
                                    context.showSnackBar("Coming Soon");
                                  }),
                            ),
                          )
                        ],
                      )),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 5,
        ),
        AnimatedSmoothIndicator(
          activeIndex: indexCarousel,
          count: 3,
          effect: ScrollingDotsEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: AppColors.primaryColor,
            dotColor: Colors.grey.withOpacity(0.1),
          ),
        ),
      ],
    );
  }
}
