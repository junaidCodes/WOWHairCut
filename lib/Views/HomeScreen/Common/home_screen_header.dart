import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';

class HeaderHomeScreen extends StatefulWidget {
  const HeaderHomeScreen({super.key});

  @override
  State<HeaderHomeScreen> createState() => _HeaderHomeScreenState();
}

class _HeaderHomeScreenState extends State<HeaderHomeScreen> {
  List<String> names = [
    'Darrell Steward',
    'Arlene McCoy',
    'Jenny Wilson',
    'Darrell Steward',
    'Arlene McCoy',
    'Jenny Wilson',
    'Darrell Steward',
    'Arlene McCoy',
    'Jenny Wilson',
    'Jenny Wilson',
  ];
  List<String> profession = [
    'Hair Stylist',
    'Nail Artist',
    'Shaving Expert',
    'Hair Stylist',
    'Nail Artist',
    'Shaving Expert',
    'Hair Stylist',
    'Nail Artist',
    'Shaving Expert',
    'Shaving Expert',
  ];
  int currentIndex = 0;
  int currentIndexTimeButton = 0;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      PathToImage.topRatedService1,
                      height: 230,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 65,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: SvgPicture.asset(PathToImage.arrow)),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      flag = !flag;
                                    });
                                    // context.showSnackBar("Coming Soon");
                                  },
                                  icon: flag
                                      ? SvgPicture.asset(
                                          PathToImage.favouriteIcon2,
                                        )
                                      : SvgPicture.asset(
                                          PathToImage.favouriteIcon,
                                          color: AppColors.primaryColor,
                                          width: 15,
                                          height: 15,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 90),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(35),
                                        topRight: Radius.circular(35))),
                                // height: 400,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                  ),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Wow Hair Salon",
                                          style: GoogleFonts.inter(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.secondaryColor),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Haircuts & Styling",
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.lightGrey),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Divider(
                                        color: const Color(0xff7f7f7f)
                                            .withOpacity(0.3),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              PathToImage.pinLocationIcon),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "8502 Preston Rd. Inglewood, Maine 98380",
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                color: AppColors.lightGrey),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            PathToImage.timerIcon,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              "15 min - 1.5km - Mon Sun | 11am - 11pm",
                                              style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  color: AppColors.lightGrey))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 3, right: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 81.7),
                              child: Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.submitReviewView);
                                  },
                                  child: Container(
                                    // width: 88,
                                    width: MediaQuery.of(context).size.width *
                                        0.29,

                                    // height: 12,
                                    height: MediaQuery.of(context).size.height *
                                        0.023,

                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(11.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Icon(
                                          Icons.star,
                                          // size: 8,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,

                                          color: Colors.white,
                                        ),
                                        Text(
                                          "4.8(1k + Reviews)",
                                          style: GoogleFonts.inter(
                                              // fontSize: 10,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0123,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
