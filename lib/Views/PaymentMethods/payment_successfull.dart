import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Views/Authentication/Common/appbar_titles.dart';

class PaymentSuccessFullView extends StatelessWidget {
  const PaymentSuccessFullView({super.key});

  @override
  Widget build(BuildContext context) {
    double w = context.width;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
              height: 175,
              color: Colors.transparent,
              child: AppBarCustom(
                showBack: false,
                title: "",
              ))),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.084),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Center(child: SvgPicture.asset(PathToImage.paymentOkIcon)),
            const SizedBox(
              height: 40,
            ),
            AppbarTitles(
              title: "Payment Successful!",
              fontSize: 20,
              heightBetween: 7,
              subtitle: "Your booking has been successfully done",
              fontSizeSub: 18,
              subTitleFontWeight: FontWeight.w400,
            ),
            const Spacer(),
            PrimaryButton(
                text: "View E-Receipt",
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteName.eReciptView, (route) => false);
                }),
            IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteName.bottomBarr, (route) => false);
                },
                icon: Text(
                  "Back to Home",
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor),
                ))
          ],
        ),
      ),
    );
  }
}
