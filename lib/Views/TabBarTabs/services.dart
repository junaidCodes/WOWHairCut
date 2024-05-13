import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';

import 'package:wowcut/Utils/app_colors.dart';

class ServicesTab extends StatelessWidget {
  const ServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listHeading = [
      'Hair Cut',
      'Hair Coloring',
      'Hair Wash',
      'Artificial Hair',
    ];

    List<String> listType = [
      '20 Types',
      '18 Types',
      '12 Types',
      '8 Types',
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 20),
      child: Column(children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Services",
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
        Expanded(
            child: SizedBox(
          width: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: listHeading.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Container(
                      // height: 50,
                      // height: MediaQuery.of(context).size.height * 0.062,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color:
                                  const Color(0xff7F7F7F33).withOpacity(0.1))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              listHeading[index],
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.lightGrey),
                            ),
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,

                            children: [
                              Text(
                                listType[index],
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryColor),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              IconButton(
                                  onPressed: () {
                                    context.showSnackBar("Coming Soon");
                                  },
                                  icon:
                                      const Icon(Icons.arrow_forward_ios_sharp))
                            ],
                          )
                        ],
                      )),
                );
              }),
        )),
      ]),
    );
  }
}
