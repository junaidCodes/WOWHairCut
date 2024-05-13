import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Views/Authentication/Common/appbar_titles.dart';
import 'package:wowcut/Views/OnBoarding/Common/text_field.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  bool obSec = true;

  bool obSecConfrimPass = true;
  GlobalKey<FormState> newPasswordKey = GlobalKey<FormState>();

  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              // height: 68,
              height: height * 0.088,
            ),
            AppbarTitles(
                title: "New Password",
                subtitle:
                    "Your new password must be different from previously used passwords"),
            SizedBox(
              // height: 60,
              height: height * 0.075,
            ),
            Form(
                key: newPasswordKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Password",
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          )),
                      const SizedBox(
                        height: 7,
                      ),
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
                            controller: newPass,

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
                      const SizedBox(
                        height: 18,
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Confirm Password",
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          )),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: TextfieldCustom(
                            obscure: obSecConfrimPass,

                            suffixIcon: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 0,
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  obSecConfrimPass = !obSecConfrimPass;
                                  setState(() {});
                                },
                                icon: obSec
                                    ? SvgPicture.asset(
                                        PathToImage.visibilityOffIcon)
                                    : SvgPicture.asset(
                                        PathToImage.visibilityOnIcon),
                              ),
                            ),
                            controller: confirmPass,

                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Please Enter password";
                              }
                              if (newPass.text != confirmPass.text) {
                                return "passwod is not  matched";
                              } else {}

                              return null;
                            },

                            inputType: TextInputType.visiblePassword,
                            hintText: "*******",

                            // suffixIcon: Icon(
                            //   Icons.visibility_off_outlined,
                            //   size: 21.5,
                            // ),
                          )),
                      const SizedBox(
                        height: 60,
                      ),
                      PrimaryButton(
                          text: "Create New Password",
                          onPressed: () {
                            if (newPasswordKey.currentState?.validate() ??
                                false) {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  RouteName.signInView, (route) => false);
                            }
                          }),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
