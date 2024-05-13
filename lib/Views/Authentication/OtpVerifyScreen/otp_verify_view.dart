// ignore_for_file: unused_import

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Views/Authentication/Common/appbar_titles.dart';

// ignore: must_be_immutable
class OtpVerifyView extends StatefulWidget {
  String email;
  OtpVerifyView({super.key, this.email = "example@gmail.com"});

  @override
  State<OtpVerifyView> createState() => _OtpVerifyViewState();
}

class _OtpVerifyViewState extends State<OtpVerifyView> {
  static const int _count = 10;
  final List<bool> _checks = List.generate(_count, (_) => false);

  GlobalKey<FormState> otpVerifyKey = GlobalKey<FormState>();

  FocusNode pinCodeTextFieldFocusNode = FocusNode();
  TextEditingController pinCodeTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isChecked = false;

    return GestureDetector(
      onTap: () {
        if (pinCodeTextFieldFocusNode.hasFocus) {
          pinCodeTextFieldFocusNode.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // height: 68,
                height: height * 0.088,
              ),
              AppbarTitles(
                  title: "Verify Code",
                  subtitle: "Please enter the code we just sent to "),
              Text(
                widget.email.toString(),
                style: GoogleFonts.inter(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                // height: 60,
                height: height * 0.075,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 30),
                key: otpVerifyKey,
                child: Form(
                  child: PinCodeTextField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Enter code";
                        }
                        return null;
                      },
                      controller: pinCodeTextFieldController,
                      keyboardType: TextInputType.number,
                      focusNode: pinCodeTextFieldFocusNode,
                      pinTheme: PinTheme(
                          inactiveBorderWidth: 0.5,
                          fieldOuterPadding: const EdgeInsets.only(right: 15),
                          shape: PinCodeFieldShape.box,
                          borderWidth: 0.5,
                          borderRadius: BorderRadius.circular(12),
                          fieldHeight: 45,
                          fieldWidth: 55,
                          // activeColor: Colors.amber,
                          selectedColor: AppColors.primaryColor,
                          disabledColor: AppColors.primaryColor,
                          activeFillColor: Colors.white,
                          inactiveFillColor: AppColors.primaryColor,
                          selectedFillColor: AppColors.primaryColor,
                          inactiveColor: Colors.grey),
                      appContext: context,
                      length: 4),
                ),
              ),
              SizedBox(
                // height: 65,
                height: height * 0.081,
              ),
              Text(
                "Didn't receive OTP?",
                style:
                    GoogleFonts.inter(fontSize: 16, color: AppColors.lightGrey),
              ),
              SizedBox(
                // height: 7,
                height: height * 0.009,
              ),
              IconButton(
                onPressed: () {},
                icon: Text(
                  "Resend Code",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                // height: 40,
                height: height * 0.05,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.083,
                  ),
                  child: PrimaryButton(
                      text: "Verify",
                      onPressed: () {
                        if (otpVerifyKey.currentState?.validate() ?? false) {
                          Navigator.pushNamed(
                              context, RouteName.newPasswordView);
                        }
                        Navigator.pushNamed(context, RouteName.newPasswordView);
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
