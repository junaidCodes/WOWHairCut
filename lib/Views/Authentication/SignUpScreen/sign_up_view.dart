// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Common/toast_message.dart';
import 'package:wowcut/FireBaseDB/auth_service.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Utils/check_box.dart';
import 'package:wowcut/Views/Authentication/Common/appbar_titles.dart';
import 'package:wowcut/Views/Authentication/Common/sign_in_sign_up_ask.dart';
import 'package:wowcut/Views/Authentication/Common/social_plate.dart';
import 'package:wowcut/Views/Authentication/SignInScreen/Common/label_text_field.dart';
import 'package:wowcut/Views/OnBoarding/Common/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool obSec = true;
  bool loading = false;
  bool isCheck = false;
  final _emailRegEx = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  FirebaseAuth _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('users');
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.088,
            ),
            AppbarTitles(
              title: "Create Account",
              subtitle:
                  "Fill your information below or register with your social account",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.083,
              ),
              child: Form(
                key: _signUpKey,
                child: Column(
                  children: [
                    LabelTextField(label: "Name"),
                    SizedBox(
                      width: double.infinity,
                      child: TextfieldCustom(
                        controller: nameController,
                        validator: (value) {
                          if (value == "") {
                            return "please Enter name";
                          }
                          return null;
                        },
                        inputType: TextInputType.name,
                        hintText: "Enter Name",
                      ),
                    ),
                    const SizedBox(height: 18),
                    LabelTextField(label: "Email"),
                    SizedBox(
                      width: double.infinity,
                      child: TextfieldCustom(
                        controller: _emailController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Please Enter email";
                          } else {
                            final bool emailValid =
                                _emailRegEx.hasMatch(value ?? '');
                            if (!emailValid) {
                              return "Please Enter a valid email address";
                            }
                          }
                          return null;
                        },
                        onChange: (value) {
                          setState(() {});
                        },
                        inputType: TextInputType.emailAddress,
                        hintText: "abc@gmail.com",
                      ),
                    ),
                    const SizedBox(height: 15),
                    LabelTextField(label: "Password"),
                    SizedBox(
                        width: double.infinity,
                        child: TextfieldCustom(
                          obscure: obSec,
                          suffixIcon: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 0,
                            child: IconButton(
                              onPressed: () {
                                obSec = !obSec;
                                setState(() {});
                              },
                              icon: obSec
                                  ? SvgPicture.asset(
                                      PathToImage.visibilityOffIcon)
                                  : SvgPicture.asset(
                                      PathToImage.visibilityOnIcon),
                            ),
                          ),
                          controller: _passwordController,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Please Enter password";
                            } else if (value!.length < 8) {
                              return "Password Must be at least 8 characters long";
                            }

                            return null;
                          },
                          inputType: TextInputType.visiblePassword,
                          hintText: "*******",
                        )),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        CustomCheckbox(
                          value: isCheck,
                          onChanged: (value) {
                            isCheck = value;
                          },
                        ),
                        const SizedBox(width: 7),
                        Text(
                          "I agree with ",
                          style: GoogleFonts.inter(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            context.showSnackBar("Coming Soon");
                          },
                          child: Text(
                            "Terms ",
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor),
                          ),
                        ),
                        Text(
                          "and ",
                          style: GoogleFonts.inter(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            context.showSnackBar("Coming Soon");
                          },
                          child: Text(
                            "Conditions",
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    PrimaryButton(
                      loading: loading,
                      onPressed: () async {
                        if (_signUpKey.currentState?.validate() ?? false) {
                          if (isCheck) {
                            setState(() {
                              loading = true;
                            });
                            AuthService(context)
                                .register(
                              nameController.text,
                              _emailController.text,
                              _passwordController.text,
                            )
                                .then((value) {
                              setState(() {
                                loading = false;
                              });
                            });
                          } else {
                            context.showSnackBar(
                                "You must agree to terms and conditions");
                          }

                          // SignUp();

                          // setData();
                        }
                      },
                      text: "Sign Up",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: const Color(0xff7f7f7f).withOpacity(0.5),
                  width: 85,
                  height: 1,
                ),
                const SizedBox(width: 15),
                Text(
                  "Or sign in with",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightGrey,
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  color: const Color(0xff7f7f7f).withOpacity(0.5),
                  width: 85,
                  height: 1,
                ),
              ],
            ),
            const SizedBox(height: 30),
            const SocialPlate(),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                SignInSingupAsk(
                  question: "Already have an account?",
                  link: "Sign In",
                  onPress: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
