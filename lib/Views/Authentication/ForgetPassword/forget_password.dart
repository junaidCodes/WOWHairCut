import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/toast_message.dart';
import 'package:wowcut/FireBaseDB/auth_service.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Views/Authentication/Common/appbar_titles.dart';
import 'package:wowcut/Views/Authentication/Common/social_plate.dart';

import 'package:wowcut/Views/OnBoarding/Common/text_button.dart';
import 'package:wowcut/Views/OnBoarding/Common/text_field.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _SignInViewState();
}

class _SignInViewState extends State<ForgetPasswordView> {
  @override
  void initState() {
    super.initState();
  }

  bool obSec = true;
  bool isValid = true;
  final auth = FirebaseAuth.instance;
  bool loading = false;

  GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.088,
              ),
              AppbarTitles(
                title: "Forget Password",
                subtitle: "Enter Email Address to get Code",
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Form(
                  key: signInKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.083,
                      right: MediaQuery.of(context).size.width * 0.083,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "Email",
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )),
                              const SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: TextfieldCustom(
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return "Please Enter email";
                                      } else {
                                        final bool emailValid = RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value ?? '');
                                        if (emailValid == false) {
                                          return "Please Enter a valid email address";
                                        }
                                      }
                                      return null;
                                    },
                                    onChange: (value) {
                                      final bool emailValid = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value);

                                      setState(() {
                                        isValid = emailValid;
                                      });
                                    },
                                    controller: emailController,
                                    inputType: TextInputType.emailAddress,
                                    hintText: "junaid@gmail.com",
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TexttButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    text: "Back to Sign In?",
                                    googleFonts: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColor)),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              PrimaryButton(
                                loading: loading,
                                onPressed: () {
                                  if (signInKey.currentState?.validate() ??
                                      false) {
                                    setState(() {
                                      loading = true;
                                    });
                                    resetPassword();
                                  }
                                },
                                text: "Get Code",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an account?",
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.lightGrey),
                            ),
                            TexttButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RouteName.signUpView);
                                },
                                googleFonts: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryColor),
                                text: "Sign Up")
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    try {
      await auth.sendPasswordResetEmail(email: emailController.text.trim());
      setState(() {
        loading = false;
      });
      context.showSnackBar("please check your Email");

      // You can navigate the user to a confirmation screen
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });
      ToastMessage()
          .toastMessage(AuthService(context).errorMessage(e.toString()));
    }
  }
}
