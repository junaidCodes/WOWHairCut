import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Views/TabBarTabs/submit_review.dart';

class ReviewTab extends StatefulWidget {
  String? review;
  ReviewTab({super.key, this.review});

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReviewClass.retrieveDataReview();
  }

  @override
  Widget build(BuildContext context) {
    List<String> reviews = [
      'This luxury designed for seating and lounging in living rooms or family rooms. They can be made of different materials such as leather, fabric, or microfiber, and can come in different sizes and styles. ',
      'This luxury designed for seating and lounging in living rooms or family rooms. They can be made of different materials such as leather, fabric, or microfiber, and can come in different sizes and styles.',
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Review ",
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryColor),
                        ),
                      ),
                      Text(
                        "(4)",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  // width: 100,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteName.submitReviewView);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                PathToImage.addReviewPenIcon,
                                height: 13,
                                width: 13,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                "Add review",
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppColors.primaryColor),
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: const Color(0xff7f7f7f).withOpacity(0.3),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SizedBox(
                width: double.infinity,
                child: ListView.builder(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.1),
                    shrinkWrap: true,
                    itemCount: PathToImage.reviewsProfileImages.length,
                    itemBuilder: (BuildContext context, index) {
                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                      PathToImage.reviewsProfileImages[index],
                                    )),
                                  ),
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.71,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Dale Theil",
                                              style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.secondaryColor),
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.star,
                                              size: 13,
                                              color: Color.fromARGB(
                                                  255, 247, 193, 17),
                                            ),
                                            Text(
                                              "4.8",
                                              style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.727,
                                        child: Row(
                                          children: [
                                            Text(
                                              "New User",
                                              style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  color: AppColors.lightGrey),
                                            ),
                                            const Spacer(),
                                            // const Text("11 month ago"),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: SizedBox(
                                  width: double.infinity,
                                  child: ValueListenableBuilder(
                                      valueListenable:
                                          ReviewClass.reviewNotifier,
                                      builder: (context, review, child) {
                                        return Text(
                                          ReviewClass.reviewNotifier.value == ""
                                              ? "This luxury designed for seating and lounging in living rooms or family rooms. They can be made of different materials such as leather, fabric, or microfiber, and can come in different sizes and styles."
                                              : ReviewClass
                                                  .reviewNotifier.value,
                                          style: GoogleFonts.inter(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300,
                                              color: AppColors.lightGrey),
                                        );
                                      })),
                            ),
                            Divider(
                              color: const Color(0xff7f7f7f).withOpacity(0.3),
                            )
                          ],
                        ),
                      );
                    })),
          ),
        ],
      ),
    );
  }
}
