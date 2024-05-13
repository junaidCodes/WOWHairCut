import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:readmore/readmore.dart';

class AboutUsTab extends StatelessWidget {
  const AboutUsTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "About Us",
                style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryColor),
              ),
            ),
            Flexible(
              flex: 1,
              // fit: FlexFit.,
              child: ReadMoreText(
                "This luxury designed for seating and lounging in living rooms or family rooms. They can be made of different materials such as leather, fabric, or microfiber, and can come in different sizes and styles ",
                trimMode: TrimMode.Line,
                trimLines: 3,
                colorClickableText: AppColors.primaryColor,
                trimCollapsedText: 'Read More',
                trimExpandedText: 'Read less',
                moreStyle: const TextStyle(
                    fontSize: 13, color: AppColors.primaryColor),
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightGrey),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Working Hours",
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryColor),
              ),
            ),
            const Divider(),
            Flexible(
              flex: 3,
              child: ListView.builder(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.1),
                  itemCount: days.length,
                  itemBuilder: (BuildContext context, index) {
                    return SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ListTile(
                        title: Text(
                          days[index],
                          style: GoogleFonts.inter(
                              fontSize: 14, color: AppColors.lightGrey),
                        ),
                        trailing: Text(
                          "00:00 - 00:00",
                          style: GoogleFonts.inter(
                              fontSize: 14, color: AppColors.secondaryColor),
                        ),
                      ),
                    );
                  }),
            ),
            // Container(
            //     // color: Colors.amber,
            //     // height: 10,
            //     // height: MediaQuery.of(context).size.height * 0.1,
            //     ),
          ],
        ));
  }
}
