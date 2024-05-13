import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int selectedValue = -1;

  List<String> paymentNames = [
    "Master Card",
    "Bitcoin",
    "Apple Pay",
    "Paypal",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: customBar("Payment Method", true, context),
      body: SingleChildScrollView(
        // padding: EdgeInsets.only(top: kToolbarHeight + 40),
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.light),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                      itemCount: PathToImage.paymentOptionsImages.length,
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedValue = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: selectedValue == index
                                      ? AppColors.primaryColor
                                      : const Color.fromARGB(
                                          126, 153, 153, 135),
                                ),
                              ),
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
                                        PathToImage.paymentOptionsImages[index],
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
                                          color: AppColors.lightGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Radio(
                                    value: index,
                                    groupValue: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value as int;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  PrimaryButton(
                    text: "Next",
                    onPressed: () {
                      if (selectedValue != -1) {
                        Navigator.pushNamed(
                          context,
                          RouteName.cardDetailsView,
                        );
                      } else {
                        context.showSnackBar("Please Select Payment Method");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
