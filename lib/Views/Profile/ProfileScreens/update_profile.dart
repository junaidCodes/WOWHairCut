// import 'dart:convert';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wowcut/Common/extensions.dart';
// import 'package:wowcut/Common/image_paths.dart';
// import 'package:wowcut/Common/toast_message.dart';
// import 'package:wowcut/FireBaseDB/auth_service.dart';
// import 'package:wowcut/Utils/app_bar.dart';
// import 'package:wowcut/Utils/app_colors.dart';
// import 'package:wowcut/Utils/button.dart';
// import 'package:wowcut/Views/Authentication/SignInScreen/Common/label_text_field.dart';
// import 'package:wowcut/Views/OnBoarding/Common/text_field.dart';

// class ProfileUpdate extends StatefulWidget {
//   const ProfileUpdate({super.key});

//   @override
//   State<ProfileUpdate> createState() => _UpdateProfileState();
// }

// class _UpdateProfileState extends State<ProfileUpdate> {
//   Map<String, dynamic>? user = {};
//   List<DropDownValueModel> genderList = const [
//     DropDownValueModel(name: 'Male', value: 1),
//     DropDownValueModel(name: 'Female', value: 2),
//   ];
//   TextEditingController exController = TextEditingController();
//   bool clicked = false;
//   File? _image;
//   bool flag = false;
//   bool isloading = false;
//   String hint = "0315663453";

//   @override
//   void initState() {
//     super.initState();
//     // _fetchData();
//     loadData();
//   }

//   // void _fetchData() async {
//   //   user = await AuthService(context).fetchData();
//   //   setState(() {});
//   // }
//   Future<void> getImagefromGallery() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//         _saveDataToFirestore();
//       } else {}
//     });
//   }

//   Future<void> _saveDataToFirestore() async {
//     try {
//       final imageFile = File(_image?.path ?? '');
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('users')
//           .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
//       final uploadTask = storageRef.putFile(imageFile);

//       flag = true;
//       await uploadTask.whenComplete(() async {
//         final url = await storageRef.getDownloadURL();
//         flag = false;

//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(FirebaseAuth.instance.currentUser?.uid)
//             .update({
//           'image': url,
//         });
//       });
//     } catch (e) {
//       ToastMessage().toastMessage(e.toString());
//     }
//   }

//   Future<void> loadData() async {
//     setState(() {
//       isloading = true;
//     });
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? dataString = prefs.getString('user');

//       if (dataString != null) {
//         user = json.decode(dataString) as Map<String, dynamic>;
//       }

//       // Listen for changes in Firestore
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser?.uid)
//           .snapshots()
//           .listen((snapshot) {
//         if (snapshot.exists) {
//           setState(() {
//             isloading = false;
//           });
//           prefs.setString('user', json.encode(snapshot.data()));
//           setState(() {
//             user = snapshot.data() as Map<String, dynamic>;
//           });
//         }
//       });
//     } catch (e) {}
//   }

//   GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController nameControllerr = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController genderController = TextEditingController();
//   SingleValueDropDownController controllerG = SingleValueDropDownController();

//   TextEditingController cardExpireyDate = TextEditingController();
//   String selectedGender = 'Male';
//   bool readOnlyy = true;
//   bool readOnlEyEmail = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           toolbarHeight: 80,
//           automaticallyImplyLeading: false,
//           flexibleSpace: AppBarCustom(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             title: "Your Profile",
//           )),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: isloading == true
//               ? const Center(child: CircularProgressIndicator())
//               : Column(
//                   children: [
//                     Align(
//                       alignment: Alignment.center,
//                       child: SizedBox(
//                         height: 115,
//                         width: 115,
//                         child: Stack(
//                           clipBehavior: Clip.none,
//                           fit: StackFit.expand,
//                           children: [
//                             const CircleAvatar(
//                               backgroundColor: Colors.transparent,
//                               backgroundImage:
//                                   AssetImage(PathToImage.profilePic),
//                             ),
//                             user?['image'] == ""
//                                 ? const CircleAvatar(
//                                     backgroundColor: Colors.transparent,
//                                     backgroundImage:
//                                         AssetImage(PathToImage.profilePic),
//                                   )
//                                 : flag == true
//                                     ? const CircleAvatar(
//                                         backgroundColor: Colors.transparent,
//                                         child: CircularProgressIndicator())
//                                     : CircleAvatar(
//                                         backgroundColor: Colors.transparent,
//                                         backgroundImage:
//                                             NetworkImage(user?['image']),
//                                       ),
//                             Positioned(
//                                 bottom: 0,
//                                 right: -25,
//                                 child: RawMaterialButton(
//                                   onPressed: getImagefromGallery,
//                                   elevation: 2.0,
//                                   fillColor: const Color(0xFFF5F6F9),
//                                   padding: const EdgeInsets.all(1.0),
//                                   shape: const CircleBorder(
//                                       side: BorderSide(
//                                           color: AppColors.primaryColor)),
//                                   child: SvgPicture.asset(
//                                     PathToImage.editIcon,
//                                     height: 15,
//                                     width: 15,
//                                   ),
//                                 )),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 7,
//                     ),
//                     Text(
//                       user?['name'],
//                       style: GoogleFonts.inter(
//                           fontSize: 18, fontWeight: FontWeight.w500),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Form(
//                       key: _signUpKey,
//                       child: Column(
//                         children: [
//                           LabelTextField(label: "Name"),
//                           SizedBox(
//                             width: double.infinity,
//                             child: TextfieldCustom(
//                               controller: nameControllerr
//                                 ..text = ' ${user?['name']}',
//                               validator: (value) {
//                                 if (value == "") {
//                                   return "Fill Name Field";
//                                 }
//                                 return null;
//                               },
//                               inputType: TextInputType.name,
//                               hintText: "Esther Howard",
//                             ),
//                           ),
//                           const SizedBox(height: 18),
//                           LabelTextField(label: "Phone Number"),
//                           SizedBox(
//                             width: double.infinity,
//                             child: TextfieldCustom(
//                               length: [LengthLimitingTextInputFormatter(12)],
//                               controller: phoneController
//                                 ..text = ' ${user?['phone'] ?? hint}',

//                               readOnly: readOnlyy,
//                               suffixIcon: Padding(
//                                 padding:
//                                     const EdgeInsets.only(top: 12, right: 10),
//                                 child: InkWell(
//                                   radius: 10,
//                                   onTap: () {
//                                     //

//                                     setState(() {
//                                       readOnlyy = !readOnlyy;
//                                     });
//                                   },
//                                   child: Text(
//                                     "Change",
//                                     style: GoogleFonts.inter(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: AppColors.primaryColor),
//                                   ),
//                                 ),
//                               ),
//                               // controller: _emailController,
//                               validator: (value) {
//                                 if (value?.isEmpty ?? true) {
//                                   return "enter Valid Phone Number";
//                                 } else if (value!.length < 10) {
//                                   return "enter Valid Phone Number";
//                                 }
//                                 {}
//                                 return null;
//                               },
//                               onChange: (value) {
//                                 // setState(() {});
//                               },
//                               inputType: TextInputType.number,
//                               hintText: hint,
//                             ),
//                           ),
//                           const SizedBox(height: 18),
//                           LabelTextField(label: "Email"),
//                           SizedBox(
//                             width: double.infinity,
//                             child: TextfieldCustom(
//                               readOnly: true,
//                               suffixIcon: Padding(
//                                 padding:
//                                     const EdgeInsets.only(top: 12, right: 10),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     // readOnlEyEmail = !readOnlEyEmail;
//                                     // setState(() {});
//                                   },
//                                   child: Text(
//                                     "Change",
//                                     style: GoogleFonts.inter(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: AppColors.primaryColor),
//                                   ),
//                                 ),
//                               ),
//                               controller: _emailController
//                                 ..text = '${user?['email'] ?? "N/A"}',
//                               onChange: (value) {
//                                 // setState(() {});
//                               },
//                               inputType: TextInputType.emailAddress,
//                               hintText: "Esther.Howard@gmail.com",
//                             ),
//                           ),
//                           const SizedBox(height: 18),
//                           LabelTextField(label: "DOB"),
//                           SizedBox(
//                             height: 50,
//                             width: double.infinity,
//                             child: TextfieldCustom(
//                               readOnly: true,
//                               controller: dobController
//                                 ..text = ' ${user?['DOB'] ?? "Date of birth"}',
//                               // readOnly: false,
//                               onTap: () async {
//                                 datePicker();
//                               },
//                               validator: (value) {
//                                 if (value == "") {
//                                   return "Enter DOB";
//                                 }
//                                 return null;
//                               },
//                               inputType: TextInputType.datetime,
//                               hintText: 'DD/MM/YYYY',
//                             ),
//                           ),
//                           const SizedBox(height: 18),
//                           LabelTextField(label: "Gender"),
//                           SizedBox(
//                             height: 50,
//                             child: DropDownTextField(
//                                 initialValue: ' ${user?['gender'].toString()}',
//                                 onChanged: (value) {
//                                   genderController.text = value.name.toString();
//                                 },
//                                 dropdownColor: Colors.white.withOpacity(1),
//                                 textFieldDecoration: InputDecoration(
//                                     enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                         borderSide: BorderSide(
//                                             color: const Color(0xff7f7f7f)
//                                                 .withOpacity(0.5),
//                                             width: 0.5)),
//                                     // hintText: ' ${user?['gender']}',
//                                     hintText: "Select Gender",
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     )),
//                                 dropDownList: genderList),
//                           ),
//                           const SizedBox(
//                             height: 50,
//                           ),
//                           !clicked
//                               ? PrimaryButton(
//                                   onPressed: () {
//                                     if (_signUpKey.currentState?.validate() ??
//                                         false) {
//                                       AuthService(context).updateProfile(
//                                         nameControllerr.text.trim(),
//                                         _emailController.text.trim(),
//                                         phoneController.text.trim(),
//                                         dobController.text.trim(),
//                                         genderController.text,
//                                       );

//                                       setState(() {
//                                         clicked = true;
//                                       });
//                                     }
//                                   },
//                                   text: "Update Profile",
//                                 )
//                               : PrimaryButton(
//                                   text: "Update Profile", onPressed: () {})
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }

//   Future datePicker() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(DateTime.now().year - 124),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       dobController.text = "${picked.day}/${picked.month}/${picked.year}";
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Common/toast_message.dart';
import 'package:wowcut/FireBaseDB/auth_service.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Views/Authentication/SignInScreen/Common/label_text_field.dart';
import 'package:wowcut/Views/OnBoarding/Common/text_field.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<ProfileUpdate> {
  Map<String, dynamic>? user = {};
  List<DropDownValueModel> genderList = const [
    DropDownValueModel(name: 'Male', value: 1),
    DropDownValueModel(name: 'Female', value: 2),
  ];
  TextEditingController exController = TextEditingController();
  bool clicked = false;
  File? _image;
  bool flag = false;
  bool isloading = false;
  String hint = "0315663453";

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
  Future<void> getImagefromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _saveDataToFirestore();
      } else {}
    });
  }

  Future<void> _saveDataToFirestore() async {
    try {
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
    } catch (e) {
      ToastMessage().toastMessage(e.toString());
    }
  }

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
    } catch (e) {}
  }

  GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController nameControllerr = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  SingleValueDropDownController controllerG = SingleValueDropDownController();

  TextEditingController cardExpireyDate = TextEditingController();
  String selectedGender = 'Male';
  bool readOnlyy = true;
  bool readOnlEyEmail = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          flexibleSpace: AppBarCustom(
            onPressed: () {
              Navigator.pop(context);
            },
            title: "Your Profile",
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: isloading == true
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage(PathToImage.profilePic),
                            ),
                            user?['image'] == ""
                                ? const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        AssetImage(PathToImage.profilePic),
                                  )
                                : flag == true
                                    ? const CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: CircularProgressIndicator())
                                    : CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            NetworkImage(user?['image']),
                                      ),
                            Positioned(
                                bottom: 0,
                                right: -25,
                                child: RawMaterialButton(
                                  onPressed: getImagefromGallery,
                                  elevation: 2.0,
                                  fillColor: const Color(0xFFF5F6F9),
                                  padding: const EdgeInsets.all(1.0),
                                  shape: const CircleBorder(
                                      side: BorderSide(
                                          color: AppColors.primaryColor)),
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
                      user?['name'],
                      style: GoogleFonts.inter(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _signUpKey,
                      child: Column(
                        children: [
                          LabelTextField(label: "Name"),
                          SizedBox(
                            width: double.infinity,
                            child: TextfieldCustom(
                              controller: nameControllerr
                                ..text = ' ${user?['name']}',
                              validator: (value) {
                                if (value == "") {
                                  return "Fill Name Field";
                                }
                                return null;
                              },
                              inputType: TextInputType.name,
                              hintText: "Esther Howard",
                            ),
                          ),
                          const SizedBox(height: 18),
                          LabelTextField(label: "Phone Number"),
                          SizedBox(
                            width: double.infinity,
                            child: TextfieldCustom(
                              length: [LengthLimitingTextInputFormatter(11)],
                              controller: phoneController
                                ..text = ' ${user?['phone'] ?? hint}',
                              readOnly: readOnlyy,
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, right: 10),
                                child: InkWell(
                                  radius: 10,
                                  onTap: () {
                                    //

                                    setState(() {
                                      readOnlyy = !readOnlyy;
                                    });
                                  },
                                  child: Text(
                                    "Change",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ),
                              // controller: _emailController,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return "enter Valid Phone Number";
                                } else if (value!.length < 10) {
                                  return "enter Valid Phone Number";
                                }
                                {}
                                return null;
                              },
                              onChange: (value) {
                                // setState(() {});
                              },
                              inputType: TextInputType.number,
                              hintText: hint,
                            ),
                          ),
                          const SizedBox(height: 18),
                          LabelTextField(label: "Email"),
                          SizedBox(
                            width: double.infinity,
                            child: TextfieldCustom(
                              readOnly: true,
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    // readOnlEyEmail = !readOnlEyEmail;
                                    // setState(() {});
                                  },
                                  child: Text(
                                    "Change",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ),
                              controller: _emailController
                                ..text = '${user?['email'] ?? "N/A"}',
                              onChange: (value) {
                                // setState(() {});
                              },
                              inputType: TextInputType.emailAddress,
                              hintText: "Esther.Howard@gmail.com",
                            ),
                          ),
                          const SizedBox(height: 18),
                          LabelTextField(label: "DOB"),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: TextfieldCustom(
                              readOnly: true,
                              controller: dobController
                                ..text = ' ${user?['DOB'] ?? "Date of birth"}',
                              // readOnly: false,
                              onTap: () async {
                                datePicker();
                              },
                              validator: (value) {
                                if (value == "") {
                                  return "Enter DOB";
                                }
                                return null;
                              },
                              inputType: TextInputType.datetime,
                              hintText: 'DD/MM/YYYY',
                            ),
                          ),
                          const SizedBox(height: 18),
                          LabelTextField(label: "Gender"),
                          SizedBox(
                            height: 50,
                            child: DropDownTextField(
                                initialValue: ' ${user?['gender'].toString()}',
                                onChanged: (value) {
                                  genderController.text = value.name.toString();
                                },
                                dropdownColor: Colors.white.withOpacity(1),
                                textFieldDecoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: const Color(0xff7f7f7f)
                                                .withOpacity(0.5),
                                            width: 0.5)),
                                    hintText: ' ${user?['gender']}',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                dropDownList: genderList),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          !clicked
                              ? PrimaryButton(
                                  onPressed: () {
                                    if (_signUpKey.currentState?.validate() ??
                                        false) {
                                      AuthService(context).updateProfile(
                                        nameControllerr.text.trim(),
                                        _emailController.text.trim(),
                                        phoneController.text.trim(),
                                        dobController.text.trim(),
                                        genderController.text,
                                      );

                                      setState(() {
                                        clicked = true;
                                      });
                                    }
                                  },
                                  text: "Update Profile",
                                )
                              : PrimaryButton(
                                  text: "Update Profile", onPressed: () {})
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future datePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 124),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }
}
