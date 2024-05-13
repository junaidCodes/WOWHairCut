import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/FireBaseDB/auth_service.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Views/Authentication/Common/appbar_titles.dart';
import 'package:wowcut/Views/Authentication/Common/sign_in_sign_up_ask.dart';
import 'package:wowcut/Views/Authentication/Common/social_plate.dart';
import 'package:wowcut/Views/Authentication/SignInScreen/Common/label_text_field.dart';
import 'package:wowcut/Views/OnBoarding/Common/text_field.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _signInKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  bool obSec = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // RegExp _emailRegExp = RegExp(
  //   r'^(([^<>()[]\.,;:\s@"]+(.[^<>()[]\.,;:\s@"]+)*)|(".+"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))$');

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
              title: "Sign In",
              subtitle: "Hi, Welcome back, you've been missed",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            Form(
              key: _signInKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.083,
                ),
                child: Column(
                  children: [
                    LabelTextField(label: "Email"),
                    SizedBox(
                      width: double.infinity,
                      child: TextfieldCustom(
                        focusNode: _emailFocus,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Please Enter email";
                          } else if (!_emailRegExp.hasMatch(value!)) {
                            return "Please Enter a valid email address";
                          }
                          return null;
                        },
                        onChange: (value) {
                          setState(() {});
                        },
                        controller: _emailController,
                        inputType: TextInputType.emailAddress,
                        hintText: "abc@gmail.com",
                      ),
                    ),
                    const SizedBox(height: 18),
                    LabelTextField(label: "Password"),
                    SizedBox(
                        width: double.infinity,
                        child: TextfieldCustom(
                          obscure: obSec,

                          suffixIcon: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 0,
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
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
                          // suffixIcon: Icon(
                          //   Icons.visibility_off_outlined,
                          //   size: 21.5,
                          // ),
                        )),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0)),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteName.forgetPasswordView);
                            },
                            child: Text(
                              "Forget Password?",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(height: 40),
                    PrimaryButton(
                      loading: loading,
                      onPressed: () async {
                        if (_signInKey.currentState?.validate() ?? false) {
                          setState(() {
                            loading = true;
                          });
                          AuthService(context)
                              .login(_emailController.text,
                                  _passwordController.text)
                              .then((value) {
                            setState(() {
                              loading = false;
                            });
                          });
                          // loading = false;
                        }
                      },
                      text: "Sign In",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.048),
            const SocialPlate(),
            const SizedBox(height: 15),
            SignInSingupAsk(
              question: "Don't have an account?",
              link: "Sign Up",
              onPress: () {
                Navigator.pushNamed(
                  context,
                  RouteName.signUpView,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
