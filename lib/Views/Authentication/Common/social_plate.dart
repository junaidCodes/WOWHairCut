// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wowcut/Common/image_paths.dart';
// ignore: unused_import
import 'package:wowcut/Common/toast_message.dart';
import 'package:wowcut/FireBaseDB/auth_service.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SocialPlate extends StatefulWidget {
  const SocialPlate({super.key});

  @override
  State<SocialPlate> createState() => _SocialPlateState();
}

bool loading = false;
bool loadingFb = false;
// AuthService authService = AuthService(get context,setState)

class _SocialPlateState extends State<SocialPlate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                shape: const CircleBorder(),
                side: BorderSide(color: AppColors.borderColor)),
            onPressed: () {
              setState(() {
                loadingFb = true;
              });
              signInWithFacebook();
            },
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: loadingFb != true
                    ? SvgPicture.asset(
                        PathToImage.fbLogo,
                        height: 22,
                        width: 27.31,
                      )
                    : const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ))),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                shape: const CircleBorder(),
                side: BorderSide(color: AppColors.borderColor)),
            onPressed: () {
              setState(() {
                loading = true;
              });
              // signInWithGoogle(context);
              AuthService(context).signInWithGoogle().then((value) {
                setState(() {
                  loading = false;
                });
              });
              // AuthService(context).signInWithGoogle();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: loading == false
                  ? SvgPicture.asset(
                      PathToImage.googleLogo,
                      height: 20,
                      width: 25.31,
                    )
                  : const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )),
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                shape: const CircleBorder(side: BorderSide()),
                side: BorderSide(color: AppColors.borderColor)),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: SvgPicture.asset(
                PathToImage.xLogo,
                width: 25.31,
                height: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      setState(() {
        loadingFb = false;
      });

      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(facebookAuthCredential);

        final userData = await FacebookAuth.instance
            .getUserData(fields: "name,email,picture");

        final userName = userData["name"];
        final userEmail = userData["email"];
        final userProfilePicUrl = userData["picture"]["data"]["url"];

        AuthService(context).saveUserDataToFirestore(
            userCredential.user!, userName, userEmail, userProfilePicUrl);

        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.locationAccessView, (route) => false);
        return userCredential;
      } else {
        return null;
      }
    } catch (e) {
      print("Error signing in with Facebook: $e");
      return null;
    }
  }
}
