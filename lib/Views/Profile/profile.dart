import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/FireBaseDB/auth_service.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Utils/exit_popup.dart';
import 'package:wowcut/Views/Profile/Common/listile.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Map<String, dynamic>? user = {};
  bool isloading = false;
  bool flag = false;

  @override
  void initState() {
    super.initState();
    // _fetchData();
    loadData();
  }

  // void _fetchData() async {
  //   user = await AuthService(context).fetchData();
  //   setState(() {});
  // }

  Future<void> loadData() async {
    setState(() {
      isloading = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? dataString = prefs.getString('user');
      if (dataString != null) {
        user = json.decode(dataString) as Map<String, dynamic>;
      }
      // Listen for changes in Firestore
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          setState(() {
            isloading = false;
          });
          prefs.setString('user', json.encode(snapshot.data()));
          setState(() {
            user = snapshot.data() as Map<String, dynamic>;
          });
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  DateTime? currentBackPressTime;
  bool canPopNow = false;
  int requiredSeconds = 2;
  DateTime now = DateTime.now();

  File? _image;
  FirebaseAuth auth = FirebaseAuth.instance;

  // function/o
  Future<void> getImagefromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // AuthService(context).saveImageToFireStore(flag);
        _saveDataToFirestore();
      } else {}
    });
  }

  Future<void> _saveDataToFirestore() async {
    try {
      log(_image.toString());
      final imageFile = File(_image?.path ?? '');
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('users')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(imageFile);

      flag = true;
      await uploadTask.whenComplete(() async {
        final url = await storageRef.getDownloadURL();
        flag = false;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .update({
          'image': url,
        });
      });
    } catch (e) {}
  }

  DateTime timeBackPressed = DateTime.now();
  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: customBar("Profile", false, context),
        body: PopScope(
          canPop: canPopNow,
          onPopInvoked: onPopInvoked,
          child: SingleChildScrollView(
            child: Column(
              children: [
                isloading == true
                    ? const CircularProgressIndicator(
                        // color: Colors.white,
                        )
                    : Column(
                        children: [
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 115,
                                  width: 115,
                                  child: Stack(
                                    // clipBehavior: Clip.none,
                                    fit: StackFit.expand,
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            AssetImage(PathToImage.profilePic),
                                      ),
                                      user?['image'] == ""
                                          ? const CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: AssetImage(
                                                  PathToImage.profilePic),
                                            )
                                          : flag == true
                                              ? const CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child:
                                                      CircularProgressIndicator())
                                              : CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                          user?['image'])),
                                      Positioned(
                                          bottom: 0,
                                          right: -25,
                                          child: RawMaterialButton(
                                            onPressed: () {
                                              getImagefromGallery();
                                            },
                                            elevation: 2.0,
                                            fillColor: const Color(0xFFF5F6F9),
                                            padding: const EdgeInsets.all(1.0),
                                            shape: const CircleBorder(
                                                side: BorderSide(
                                                    color: AppColors
                                                        .primaryColor)),
                                            child: SvgPicture.asset(
                                              PathToImage.editIcon,
                                              height: 15,
                                              width: 15,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                user?['name'] ?? "",
                                style: GoogleFonts.inter(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 30,
                ),
                ListileWidget(
                  icon: PathToImage.profileIcon,
                  title: "Profile",
                  onPress: () {
                    Navigator.pushNamed(context, RouteName.updateProfile);
                  },
                ),
                const Column(
                  children: [
                    // Text('LAT: ${currentPosition?.latitude ?? ""}'),
                    // Text('Long: ${currentPosition?.longitude ?? ""}'),
                    // Text('address: ${currentAddress ?? ""}'),
                  ],
                ),
                ListileWidget(
                  icon: PathToImage.savedIcon,
                  title: "Saved",
                  onPress: () {
                    Navigator.pushNamed(context, RouteName.savedView);
                  },
                ),
                ListileWidget(
                  icon: PathToImage.transactionIcon,
                  title: "Transactions",
                  onPress: () {
                    Navigator.pushNamed(context, RouteName.transactionsView);
                  },
                ),
                ListileWidget(
                  icon: PathToImage.paymentMethodIcon,
                  title: "Payment Method",
                  onPress: () {
                    Navigator.pushNamed(
                        context, RouteName.paymentMethodInProfile);
                  },
                ),
                ListileWidget(
                  icon: PathToImage.helpCenterIcon,
                  title: "Help Center",
                  onPress: () {
                    context.showSnackBar("Screen not found");
                  },
                ),
                ListileWidget(
                  icon: PathToImage.privacyPolicyIcon,
                  title: "Privacy Policy",
                  onPress: () {
                    Navigator.pushNamed(context, RouteName.privacyPolicyView);
                  },
                ),
                ListileWidget(
                  icon: PathToImage.setttingsIcon,
                  title: "Settings",
                  onPress: () {
                    Navigator.pushNamed(context, RouteName.settingView);
                  },
                ),
                ListileWidget(
                  icon: PathToImage.logoutIcon,
                  title: "Log out",
                  onPress: () {
                    logoutPopUp(context);
                  },
                )
              ],
            ),
          ),
        ));
  }

  void onPopInvoked(bool didPop) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) >
            Duration(seconds: requiredSeconds)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(context, "Press again to exit");
      // Fluttertoast.showToast(msg: exit_warning);
      Future.delayed(
        Duration(seconds: requiredSeconds),
        () {
          // Disable pop invoke and close the toast after 2s timeout
          setState(() {
            canPopNow = false;
          });
          Fluttertoast.cancelToast();
        },
      );
      // Ok, let user exit app on the next back press
      setState(() {
        canPopNow = true;
      });
    }
  }

  Future logoutPopUp(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Logout",
                style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xfff94144)),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Are you sure you want to logout?',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: PrimaryButton(
                      onPressed: () {
                        // Add your logout logic here

                        Navigator.pop(context);
                      },
                      text: "Cancel",
                      buttonColor: Colors.white,
                      textColor: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: PrimaryButton(
                      onPressed: () async {
                        AuthService(context).signOut();
                      },
                      text: "Yes, Logout",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

//
