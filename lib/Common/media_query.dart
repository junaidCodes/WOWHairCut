import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

// ignore_for_file: unused_import

// import 'dart:convert';
// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wowcut/Common/extensions.dart';
// import 'package:wowcut/Common/image_paths.dart';
// import 'package:wowcut/FireBaseDB/auth_service.dart';
// import 'package:wowcut/Utils/app_bar.dart';
// import 'package:wowcut/Utils/app_colors.dart';
// import 'package:wowcut/Utils/button.dart';
// import 'package:wowcut/Views/Authentication/SignInScreen/Common/label_text_field.dart';
// import 'package:wowcut/Views/OnBoarding/Common/text_field.dart';

// class ProfileUpdate extends StatefulWidget {
//   const ProfileUpdate({super.key});

//   @override
//   State<ProfileUpdate> createState() => _ProfileUpdateState();
// }

// class _ProfileUpdateState extends State<ProfileUpdate> {
//   Map<String, dynamic> data = {};

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isDataFetched = prefs.getBool('isDataFetched') ?? false;
//     if (!isDataFetched) {
//       // Fetch data from Firestore
//       DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser?.uid)
//           .get();
//       data = docSnapshot.data() as Map<String, dynamic>;
//       // Store the fetched data in SharedPreferences
//       await prefs.setBool('isDataFetched', true);
//       await prefs.setString('data', json.encode(data));
//     } else {
//       // Retrieve data from SharedPreferences
//       String dataString = prefs.getString('data')!;
//       data = json.decode(dataString) as Map<String, dynamic>;
//     }
//     setState(() {});
//   }

//   final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final _emailRegEx = RegExp(
//       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//   TextEditingController dobController = TextEditingController();
//   TextEditingController myController = TextEditingController();
//   TextEditingController nameControllerr = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController genderController = TextEditingController();

//   SingleValueDropDownController dropDownController =
//       SingleValueDropDownController();

//   String selectedGender = 'Male';
//   bool readOnly = false;
//   bool readOnlEyEmail = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           toolbarHeight: 80,
//           automaticallyImplyLeading: false,
//           flexibleSpace: AppBarCustom(
//             title: "Your Profile",
//           )),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             children: [
//               StreamBuilder(
//                 stream:const Stream.empty(),
//                 builder: (context, AsyncSnapshot snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   }
//                   // else if (snapshot.hasError) {
//                   //   return Text('Error: ${snapshot.error}');
//                   // }
//                   else if (snapshot.hasData) {
//                     var user = snapshot.data.data() as Map<String, dynamic>;

//                     // log(user);
//                     // ImageProvider? imageProvider;
//                     Widget getImage = Container();
//                     if (user['image'] != null && user['image'].isNotEmpty) {
//                       getImage = Stack(
//                         clipBehavior: Clip.none,
//                         fit: StackFit.expand,
//                         children: [
//                           user['image'] == null
//                               ? const CircularProgressIndicator(
//                                   color: Colors.red,
//                                 )
//                               : CircleAvatar(
//                                   backgroundImage: NetworkImage(user['image']),
//                                 ),
//                           Positioned(
//                               bottom: 0,
//                               right: -25,
//                               child: RawMaterialButton(
//                                 onPressed: () {},
//                                 elevation: 2.0,
//                                 fillColor: const Color(0xFFF5F6F9),
//                                 padding: const EdgeInsets.all(15.0),
//                                 shape: const CircleBorder(
//                                     side: BorderSide(
//                                         color: AppColors.primaryColor)),
//                                 child: SvgPicture.asset(PathToImage.editIcon),
//                               )),
//                         ],
//                       );
//                     } else {
//                       getImage = Stack(
//                         clipBehavior: Clip.none,
//                         fit: StackFit.expand,
//                         children: [
//                           const CircleAvatar(
//                             backgroundImage: AssetImage(PathToImage.profilePic),
//                           ),
//                           Positioned(
//                               bottom: 0,
//                               right: -25,
//                               child: RawMaterialButton(
//                                 onPressed: () {},
//                                 elevation: 2.0,
//                                 fillColor: const Color(0xFFF5F6F9),
//                                 padding: const EdgeInsets.all(15.0),
//                                 shape: const CircleBorder(
//                                     side: BorderSide(
//                                         color: AppColors.primaryColor)),
//                                 child: SvgPicture.asset(PathToImage.editIcon),
//                               )),
//                         ],
//                       );
//                     }
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 100.0,
//                           height: 100.0,
//                           decoration: const BoxDecoration(
//                             color: Colors.black,
//                             shape: BoxShape.circle,
//                             // image: DecorationImage(
//                             //   image: imageProvider,
//                             //   fit: BoxFit.cover,
//                             // ),
//                           ),
//                           child: getImage,
//                         ),
//                         Form(
//                           key: _signUpKey,
//                           child: Column(
//                             children: [
//                               LabelTextField(label: "Name"),
//                               SizedBox(
//                                 width: double.infinity,
//                                 child:
//                                  TextfieldCustom(
//                                   controller: nameControllerr
//                                     ..text = ' ${data['name'] ?? "N/A"}',
//                                   validator: (value) {
//                                     if (value == "") {
//                                       return "Fill Name Field";
//                                     }
//                                     return null;
//                                   },
//                                   inputType: TextInputType.name,
//                                   hintText: "Esther Howard",
//                                 ),
                             
                             
//                               ),
//                               const SizedBox(height: 18),
//                               LabelTextField(label: "Phone Number"),
//                               SizedBox(
//                                 width: double.infinity,
//                                 child: 
//                                 TextfieldCustom(
//                                   controller: phoneController
//                                     ..text = ' ${user['phone'] ?? "N/A"}',
//                                   // readOnly: false,
//                                   suffixIcon: Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 12, right: 10),
//                                     child: InkWell(
//                                       onTap: () {
//                                         // readOnly = !readOnly;
//                                         // setState(() {});
//                                       },
//                                       child: Text(
//                                         "Change",
//                                         style: GoogleFonts.inter(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w500,
//                                             color: AppColors.primaryColor),
//                                       ),
//                                     ),
//                                   ),
//                                   // controller: _emailController,
//                                   validator: (value) {
//                                     if (value?.isEmpty ?? true) {
//                                       return "Fill Email field";
//                                     } else {}
//                                     return null;
//                                   },
//                                   onChange: (value) {
//                                     // setState(() {});
//                                   },
//                                   inputType: TextInputType.number,
//                                   hintText: "0315663453",
//                                 ),
                             
//                               ),
//                               const SizedBox(height: 18),
//                               LabelTextField(label: "Email"),
//                               SizedBox(
//                                 width: double.infinity,
//                                 child:
//                                  TextfieldCustom(
//                                   readOnly: true,
//                                   suffixIcon: Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 12, right: 10),
//                                     child: InkWell(
//                                       onTap: () {
//                                         // readOnlEyEmail = !readOnlEyEmail;
//                                         // setState(() {});
//                                       },
//                                       child: Text(
//                                         "Change",
//                                         style: GoogleFonts.inter(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w500,
//                                             color: AppColors.primaryColor),
//                                       ),
//                                     ),
//                                   ),
//                                   controller: _emailController
//                                     ..text = '${user['email'] ?? "N/A"}',
//                                   validator: (value) {
//                                     if (value?.isEmpty ?? true) {
//                                       return "Fill Email field";
//                                     } else {
//                                       final bool emailValid =
//                                           _emailRegEx.hasMatch(value ?? '');
//                                       if (!emailValid) {
//                                         return "Please enter valid email";
//                                       }
//                                     }
//                                     return null;
//                                   },
//                                   onChange: (value) {
//                                     setState(() {});
//                                   },
//                                   inputType: TextInputType.emailAddress,
//                                   hintText: "Esther.Howard@gmail.com",
//                                 ),
                              
//                               ),
//                               const SizedBox(height: 18),
//                               LabelTextField(label: "DOB"),
//                               SizedBox(
//                                 // height: 50,
//                                 width: double.infinity,
//                                 child: 
                                
//                                 TextfieldCustom(
//                                   controller: dobController
//                                     ..text = ' ${user['DOB'] ?? "N/A"}',
//                                   // readOnly: false,
//                                   onTap: () async {
//                                     datePicker();
//                                   },
//                                   validator: (value) {
//                                     if (value == "") {
//                                       return "Enter DOB";
//                                     }
//                                     return null;
//                                   },
//                                   inputType: TextInputType.datetime,
//                                   hintText: 'DD/MM/YYYY',
//                                 ),
                             
//                               ),
//                               const SizedBox(height: 18),
//                               LabelTextField(label: "Gender"),
//                               SizedBox(
//                                 height: 50,
//                                 child:
//                                  DropDownTextField(
//                                     // controller: genderController,
//                                     onChanged: (value) {
//                                       genderController.text =
//                                           value.name.toString();
//                                     },
//                                     dropdownColor: Colors.white.withOpacity(1),
//                                     textFieldDecoration: InputDecoration(
//                                         enabledBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                             borderSide: BorderSide(
//                                                 color: const Color(0xff7f7f7f)
//                                                     .withOpacity(0.5),
//                                                 width: 0.5)),
//                                         hintText: "Select",
//                                         border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(12),
//                                         )),
//                                     dropDownList: const [
//                                       DropDownValueModel(
//                                           name: 'Male', value: "value1"),
//                                       DropDownValueModel(
//                                           name: 'Female', value: "value1"),
//                                     ]),
                            
//                               ),
//                               const SizedBox(
//                                 height: 50,
//                               ),
//                               PrimaryButton(
//                                 onPressed: () async {
//                                   if (_signUpKey.currentState?.validate() ??
//                                       false) {
//                                     AuthService(context).updateProfile(
//                                         nameControllerr.text.trim(),
//                                         _emailController.text.trim(),
//                                         phoneController.text.trim(),
//                                         dobController.text.trim(),
//                                         genderController.text);
//                                   }
//                                 },
//                                 text: "Update Profile",
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   } else {
//                     return const Text('Not data');
//                   }
//                   // return Container();
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
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
