import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Common/toast_message.dart';
import 'package:wowcut/FireBaseDB/auth_service.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Views/OnBoarding/Common/text_field.dart';

class NewPasswordViewInProfile extends StatefulWidget {
  const NewPasswordViewInProfile({super.key});

  @override
  State<NewPasswordViewInProfile> createState() =>
      _NewPasswordViewInProfileState();
}

class _NewPasswordViewInProfileState extends State<NewPasswordViewInProfile> {
  bool obSec = true;
  bool obSecNewPass = true;
  bool isLoading = false;

  bool obSecConfrimPass = true;
  GlobalKey<FormState> newPasswordKey = GlobalKey<FormState>();
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  changePassword(String email, String oldPass, String newPass) async {
    try {
      var cred = EmailAuthProvider.credential(email: email, password: oldPass);
      await currentUser!.reauthenticateWithCredential(cred).then((value) {
        currentUser!.updatePassword(newPass);

        ToastMessage()
            .toastMessage("Password updated successfully", color: Colors.green);
        ToastMessage().toastMessage("please Login Again", color: Colors.green);
        AuthService(context).signOut();
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      ToastMessage().toastMessage(errorMessage(e.code));
    }
  }

  String errorMessage(String code) {
    setState(() {
      isLoading = false;
    });

    switch (code) {
      case "invalid-email":
        return "Your email address appears to be malformed.";

      case "weak-password":
        return "Password is too weak.";

      case "requires-recent-login":
        return "Please  Login Again";

      default:
        return "An undefined error occurred.";
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: customBar("New Password", true, context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                            "Current Password",
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
                            controller: currentPass,

                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Please Enter password";
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
                            "New Password",
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          )),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: TextfieldCustom(
                            obscure: obSecNewPass,

                            suffixIcon: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 0,
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  obSecNewPass = !obSecNewPass;
                                  setState(() {});
                                },
                                icon: obSecNewPass
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
                                return "Password Must be 8 characters long";
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
                            "Confirm New Password",
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
                                return "password is not  matched";
                              } else {}

                              return null;
                            },
                            inputType: TextInputType.visiblePassword,
                            hintText: "*******",
                          )),
                      SizedBox(
                        height: height * 0.33,
                      ),
                      PrimaryButton(
                          loading: isLoading,
                          text: "Change Password",
                          onPressed: () async {
                            if (newPasswordKey.currentState?.validate() ??
                                false) {
                              isLoading = true;
                              setState(() {});
                              await changePassword(
                                  currentUser!.email.toString(),
                                  currentPass.text,
                                  newPass.text);
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
