import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';

class ReviewSummaryView extends StatelessWidget {
  ReviewSummaryView({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> reviewSummary = [
      "02/30",
      "Address",
      "Name",
      "Phone",
      "Booking Date",
      "Booking Hours",
      "Specialist",
    ];
    final List<String> reviewSummaryAns = [
      "Glamour Haven",
      "G8502 Preston Rd. Iglewood",
      "Esther Howard",
      "030477496163",
      "August 23, 2023",
      "10:00 AM",
      "Nathan Alexander",
    ];

    return Scaffold(
      extendBodyBehindAppBar: false,
      // extendBody: true,
      appBar: customBar("Review Summary", true, context),
      body: SingleChildScrollView(
        // padding: EdgeInsets.only(top: kToolbarHeight + 20),
        child: Column(
          children: [
            // AppBarCustom(title: "Review Summary"),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Container(
                    height: 265,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: reviewSummary.length,
                      itemBuilder: (context, index) => Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              reviewSummary[index],
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightGrey,
                              ),
                            ),
                            Text(
                              reviewSummaryAns[index],
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  serviceItems([
                    'Haircut',
                    'Hair wash',
                    'Shaving'
                  ], [
                    "\$60.00",
                    "\$80.00",
                    "\$30.00",
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  paymentMethod(context),
                  const SizedBox(height: 20),
                  const SizedBox(height: 40),
                  PrimaryButton(
                      text: "Confirm Payment",
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RouteName.paymentSuccessFullView, (route) => false);
                      }),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Methods//
  Widget serviceItems(List<String> titles, List<String> prices) {
    assert(titles.length == prices.length);
    return Container(
      // height: 111,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Column(
            children: List.generate(titles.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      titles[index],
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightGrey,
                      ),
                    ),
                    Text(
                      prices[index],
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  Widget paymentMethod(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(PathToImage.masterCard),
                const SizedBox(width: 10),
                Text(
                  "Master Card",
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightGrey),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteName.cardDetailsView,
                );
              },
              child: Text(
                "Change",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
