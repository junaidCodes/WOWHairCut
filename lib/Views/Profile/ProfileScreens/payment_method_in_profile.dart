import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/app_colors.dart';

class PaymentMethodInProfile extends StatefulWidget {
  const PaymentMethodInProfile({super.key});

  @override
  State<PaymentMethodInProfile> createState() => _PaymentMethodInProfileState();
}

class _PaymentMethodInProfileState extends State<PaymentMethodInProfile> {
  @override
  Widget build(BuildContext context) {
    List<String> paymentNames = [
      "Master Card",
      "Bitcoin",
      "Apple Pay",
      "Paypal",
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
            height: 150,
            color: Colors.transparent,
            child: AppBarCustom(
              title: "Payment Method",
            )),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // AppBarr(
            //   text1: "Payment Method",
            // ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                        itemCount: PathToImage.paymentOptionsImages.length,
                        itemBuilder: (BuildContext conext, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: const Color(0xff7f7f7f)
                                            .withOpacity(0.5),
                                        width: 0.5)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        SvgPicture.asset(
                                          PathToImage
                                              .paymentOptionsImages[index],
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          paymentNames[index],
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.lightGrey),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          context.showSnackBar("Coming Soon");
                                        },
                                        child: Text(
                                          "Link",
                                          style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryColor),
                                        ))
                                  ],
                                )),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
