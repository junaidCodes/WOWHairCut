import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';

import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';

class PackagesTab extends StatelessWidget {
  final ScrollController? scrollControl;

  const PackagesTab({super.key, this.scrollControl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Packages",
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryColor),
                ),
              ),
              const SizedBox(
                width: 5,
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
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.1),
                controller: scrollControl,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: PathToImage.specialistsImages.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            // color: Colors.amber,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: const Color(0xff7f7f7f33)
                                    .withOpacity(0.1))),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                PathToImage.specialistsImages[index],
                                height: 100,
                                width: 120,
                              ),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  SizedBox(
                                    // height: 00,
                                    width: 170,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Beauty Make Up",
                                            style: GoogleFonts.inter(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    AppColors.secondaryColor),
                                          ),
                                        ),
                                        Text(
                                          "Special Offers Package Valid until Dec 10, 2023",
                                          style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.lightGrey),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$100",
                                              style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                            PrimaryButton(
                                              fontSize: 12,
                                              text: "Book Now",
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    RouteName.bookingView);
                                              },
                                              width: 80,
                                              height: 32,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
