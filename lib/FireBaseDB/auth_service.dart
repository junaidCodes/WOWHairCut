// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wowcut/Common/extensions.dart';
// import 'package:wowcut/Common/toast_message.dart';
// import 'package:wowcut/Routes/route_name.dart';
// import 'package:wowcut/Views/Authentication/Location/location_manually.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   final BuildContext context;
//   bool loading = false;
//   File? _image;

//   AuthService(
//     this.context,
//   );

//   Future<UserCredential?> signInWithGoogle() async {
//     FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;

//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );

//       UserCredential userCredential =
//           await firebaseAuth.signInWithCredential(credential);

//       final userData = userCredential.user;

//       final userName = userData!.displayName;
//       final userEmail = userData.email;
//       final userProfilePicUrl = userData.photoURL;

//       saveUserDataToFirestore(
//           userData, userName ?? "", userEmail ?? "", userProfilePicUrl ?? "");

//       // ignore: use_build_context_synchronously
//       Navigator.pushNamedAndRemoveUntil(
//           context, RouteName.locationAccessView, (route) => false);

//       return userCredential;
//     } catch (e) {
//       return null;
//     }
//   }

//   Future signInWithFacebook() async {
//     try {
//       // Trigger the sign-in flow
//       final LoginResult loginResult = await FacebookAuth.instance.login();

//       // Create a credential from the access token
//       final OAuthCredential facebookAuthCredential =
//           FacebookAuthProvider.credential(loginResult.accessToken!.token);

//       // Once signed in, return the UserCredential
//       // ignore: use_build_context_synchronously
//       Navigator.pushNamedAndRemoveUntil(
//           context, RouteName.locationAccessView, (route) => false);
//       return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//     } on FirebaseAuthException catch (e) {
//       ToastMessage().toastMessage(errorMessage(e.code.toString()));
//     }
//   }

//   void saveUserDataToFirestore(
//       User user, String userName, String userEmail, String userProfilePicUrl,
//       {bool isDeleted = false}) async {
//     try {
//       FirebaseFirestore firestore = FirebaseFirestore.instance;

//       final QuerySnapshot querySnapshot = await firestore
//           .collection('users')
//           .where('email', isEqualTo: userEmail)
//           .get();
//       if (querySnapshot.docs.isNotEmpty) {
//         // If user exists, update the existing document
//         final DocumentSnapshot userDoc = querySnapshot.docs.first;
//         await userDoc.reference.update({
//           // Update any necessary fields
//           "name": userName,
//           "email": userEmail,
//           "image": userProfilePicUrl,
//           "isDeleted": false,

//           // Set isDeleted to false to mark it as not deleted
//         });
//       } else {
//         FirebaseFirestore firestore = FirebaseFirestore.instance;

//         await firestore.collection('users').doc(user.uid).set({
//           "name": userName,
//           "email": userEmail,
//           "image": userProfilePicUrl,
//           "isDeleted": isDeleted,
//         });
//       }
//     } catch (e) {
//       print("Error saving user data: $e");
//     }
//   }

//   void setState(VoidCallback fn) {
//     // Implement your state management logic here
//   }
//   Future<User?> register(String userName, String email, String password,
//       {bool isDeleted = false}) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       FirebaseFirestore firestore = FirebaseFirestore.instance;

//       await userCredential.user!.updateDisplayName(userName);
//       final QuerySnapshot querySnapshot = await firestore
//           .collection('users')
//           .where('email', isEqualTo: email)
//           .get();
//       if (querySnapshot.docs.isNotEmpty) {
//         // If user exists, update the existing document
//         final DocumentSnapshot userDoc = querySnapshot.docs.first;
//         await userDoc.reference.update({
//           // Update any necessary fields
//           'name': userName,
//           'email': email,

//           // Set isDeleted to false to mark it as not deleted
//           'isDeleted': false,
//         });
//         setState(() {});
//       } else {
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(userCredential.user!.uid)
//             .set({
//           "name": userName,
//           "email": email,
//           "uid": userCredential.user!.uid,
//           "image": "",
//           "isDeleted": isDeleted,
//         });
//       }
//       Navigator.pushNamedAndRemoveUntil(
//           context, RouteName.locationAccessView, (route) => false);
//       // Get.off(() => const DashboardCoffeeScreen());

//       return userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       ToastMessage().toastMessage(errorMessage(e.code.toString()));
//     }
//     return null;
//   }

//   Future login(String email, String password) async {
//     try {
//       const CircularProgressIndicator(
//         color: Colors.amber,
//       );
//       UserCredential user = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       if (MyValueNotifier.placeNameNotifier.value == "") {
//         // ignore: use_build_context_synchronously
//         Navigator.pushNamedAndRemoveUntil(
//             context, RouteName.locationAccessView, (route) => false);
//       } else {
//         // ignore: use_build_context_synchronously
//         Navigator.pushNamedAndRemoveUntil(
//             context, RouteName.bottomBarr, (route) => false);
//       }
//       // ignore: use_build_context_synchronously
//     } on FirebaseAuthException catch (e) {
//       ToastMessage().toastMessage(errorMessage(e.code.toString()));
//     }
//   }

//   Future signOut() async {
//     FirebaseAuth auth = FirebaseAuth.instance;

//     try {
//       auth.signOut();
//       await GoogleSignIn().signOut();
//       // ignore: use_build_context_synchronously
//       Navigator.pushNamedAndRemoveUntil(
//           context, RouteName.signInView, (route) => false);
//     } on FirebaseAuthException catch (e) {
//       errorMessage(e.code.toString());
//     }
//   }

//   Future updateProfile(
//     String name,
//     String email,
//     String phone,
//     String dob,
//     String gender,
//   ) async {
//     final firestore = FirebaseFirestore.instance.collection('users');
//     User? user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       // Get the current user's document from Firestore
//       DocumentReference userDocRef = firestore.doc(user.uid);

//       // Update the phone number field with the new value
//       await userDocRef.update({
//         // 'phone': phoneController.text.toString(),
//         'name': name,
//         'email': email,
//         'phone': phone,
//         'DOB': dob,
//         if (gender.isNotEmpty) 'gender': gender.trim()
//       }).then((value) {
//         ToastMessage()
//             .toastMessage("updated successfully", color: Colors.green);
//         Timer.periodic(const Duration(seconds: 1), (timer) {
//           Navigator.pop(context);
//         });
//       }).onError((error, stackTrace) {
//         context.showSnackBar(error.toString());
//       });

//       // Show a snackbar to indicate successful update
//     }
//   }

//   Future deleteUser() async {
//     final firestore = FirebaseFirestore.instance.collection('users');

//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       // Get the current user's document from Firestore
//       DocumentReference userDocRef = firestore.doc(user.uid);

//       // Update the phone number field with the new value
//       await userDocRef.update({'isDeleted': true});
//       await FirebaseAuth.instance.currentUser?.delete().then((value) {
//         context.showSnackBar("deleted user");
//       }).onError((error, stackTrace) {
//         context.showSnackBar(error.toString());
//       });

//       // ignore: use_build_context_synchronously
//       Navigator.pushNamedAndRemoveUntil(
//           context, RouteName.signInView, (route) => false);
//     }
//   }

//   String errorMessage(String code) {
//     setState(() {
//       loading = false;
//     });

//     switch (code) {
//       case "invalid-email":
//         return "Your email address appears to be malformed.";

//       case "email-already-in-use":
//         return "Email already exists.";

//       case "weak-password":
//         return "Password is too weak.";

//       case "operation-not-allowed":
//         return "Signing in with Email and Password is not enabled.";

//       case "user-not-found":
//         return "User with this email doesn't exist.";

//       case "user-disabled":
//         return "User with this email has been disabled.";

//       case "wrong-password":
//         return "Incorrect password.";

//       case "too-many-requests":
//         return "Too many requests. Try again later.";

//       case "account-exists-with-different-credential":
//         return "Account exists with a different credential.";

//       case "invalid-credential":
//         return "Invalid credentials.";

//       case 'unauthorized-continue-uri':
//         return 'Invalid request. Please try again later.';

//       case 'invalid-continue-uri':
//         return 'Invalid request. Please try again later.';

//       case 'missing-ios-bundle-id':
//         return 'Internal error occurred. Please contact support.';

//       case 'missing-continue-uri':
//         return 'Internal error occurred. Please contact support.';

//       case 'missing-android-pkg-name':
//         return 'Internal error occurred. Please contact support.';

//       default:
//         return "An undefined error occurred.";
//     }
//   }

//   Future<Map<String, dynamic>?> fetchData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? dataString = prefs.getString('user');
//     Map<String, dynamic>? user;
//     if (dataString != null) {
//       user = json.decode(dataString) as Map<String, dynamic>;
//     }

//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(_auth.currentUser?.uid)
//         .snapshots()
//         .listen((snapshot) {
//       if (snapshot.exists) {
//         prefs.setString('user', json.encode(snapshot.data()));
//       }
//     });
//     return user;
//   }

//   Future<void> saveImageToFireStore(bool flag) async {
//     try {
//       final imageFile = File(_image?.path ?? '');
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('users')
//           .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
//       final uploadTask = storageRef.putFile(imageFile);

//       flag = true;
//       await uploadTask.whenComplete(() async {
//         flag = false;
//         final url = await storageRef.getDownloadURL();
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(FirebaseAuth.instance.currentUser?.uid)
//             .update({
//           'image': url,
//         });
//       });
//     } catch (e) {}
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/toast_message.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Views/Authentication/Location/location_manually.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final BuildContext context;
  bool loading = false;
  File? _image;

  AuthService(
    this.context,
  );

  Future<UserCredential?> signInWithGoogle() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      final userData = userCredential.user;

      final userName = userData!.displayName;
      final userEmail = userData.email;
      final userProfilePicUrl = userData.photoURL;

      saveUserDataToFirestore(
          userData, userName ?? "", userEmail ?? "", userProfilePicUrl ?? "");

      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.locationAccessView, (route) => false);

      return userCredential;
    } catch (e) {
      return null;
    }
  }

  Future signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.locationAccessView, (route) => false);
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      ToastMessage().toastMessage(errorMessage(e.code.toString()));
    }
  }

  void saveUserDataToFirestore(
      User user, String userName, String userEmail, String userProfilePicUrl,
      {bool isDeleted = false}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      final QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // If user exists, update the existing document
        final DocumentSnapshot userDoc = querySnapshot.docs.first;
        await userDoc.reference.update({
          // Update any necessary fields
          "name": userName,
          "email": userEmail,
          "image": userProfilePicUrl,
          "isDeleted": false,

          // Set isDeleted to false to mark it as not deleted
        });
      } else {
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        await firestore.collection('users').doc(user.uid).set({
          "name": userName,
          "email": userEmail,
          "image": userProfilePicUrl,
          "isDeleted": isDeleted,
        });
      }
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  void setState(VoidCallback fn) {
    // Implement your state management logic here
  }
  Future<User?> register(String userName, String email, String password,
      {bool isDeleted = false}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await userCredential.user!.updateDisplayName(userName);
      final QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // If user exists, update the existing document
        final DocumentSnapshot userDoc = querySnapshot.docs.first;
        await userDoc.reference.update({
          // Update any necessary fields
          'name': userName,
          'email': email,

          // Set isDeleted to false to mark it as not deleted
          'isDeleted': false,
        });
        setState(() {});
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          "name": userName,
          "email": email,
          "uid": userCredential.user!.uid,
          "image": "",
          "isDeleted": isDeleted,
        });
      }
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.locationAccessView, (route) => false);
      // Get.off(() => const DashboardCoffeeScreen());

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ToastMessage().toastMessage(errorMessage(e.code.toString()));
    }
    return null;
  }

  Future login(String email, String password) async {
    try {
      const CircularProgressIndicator(
        color: Colors.amber,
      );
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (MyValueNotifier.placeNameNotifier.value == "") {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.locationAccessView, (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.bottomBarr, (route) => false);
      }
      // ignore: use_build_context_synchronously
    } on FirebaseAuthException catch (e) {
      ToastMessage().toastMessage(errorMessage(e.code.toString()));
    }
  }

  Future signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      auth.signOut();
      await GoogleSignIn().signOut();
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.signInView, (route) => false);
    } on FirebaseAuthException catch (e) {
      errorMessage(e.code.toString());
    }
  }

  Future updateProfile(
    String name,
    String email,
    String phone,
    String dob,
    String gender,
  ) async {
    final firestore = FirebaseFirestore.instance.collection('users');
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Get the current user's document from Firestore
      DocumentReference userDocRef = firestore.doc(user.uid);

      // Update the phone number field with the new value
      await userDocRef.update({
        // 'phone': phoneController.text.toString(),
        'name': name,
        'email': email,
        'phone': phone,
        'DOB': dob,
        if (gender.isNotEmpty) 'gender': gender.trim(),
      }).then((value) {
        ToastMessage()
            .toastMessage("updated successfully", color: Colors.green);
        Timer.periodic(const Duration(seconds: 1), (timer) {
          Navigator.pop(context);
        });
      }).onError((error, stackTrace) {
        context.showSnackBar(error.toString());
      });

      // Show a snackbar to indicate successful update
    }
  }

  Future deleteUser() async {
    final firestore = FirebaseFirestore.instance.collection('users');

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Get the current user's document from Firestore
      DocumentReference userDocRef = firestore.doc(user.uid);

      // Update the phone number field with the new value
      await userDocRef.update({'isDeleted': true});
      await FirebaseAuth.instance.currentUser?.delete().then((value) {
        context.showSnackBar("deleted user");
      }).onError((error, stackTrace) {
        context.showSnackBar(error.toString());
      });

      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.signInView, (route) => false);
    }
  }

  String errorMessage(String code) {
    setState(() {
      loading = false;
    });

    switch (code) {
      case "invalid-email":
        return "Your email address appears to be malformed.";

      case "email-already-in-use":
        return "Email already exists.";

      case "weak-password":
        return "Password is too weak.";

      case "operation-not-allowed":
        return "Signing in with Email and Password is not enabled.";

      case "user-not-found":
        return "User with this email doesn't exist.";

      case "user-disabled":
        return "User with this email has been disabled.";

      case "wrong-password":
        return "Incorrect password.";

      case "too-many-requests":
        return "Too many requests. Try again later.";

      case "account-exists-with-different-credential":
        return "Account exists with a different credential.";

      case "invalid-credential":
        return "Invalid credential.";

      case 'unauthorized-continue-uri':
        return 'Invalid request. Please try again later.';

      case 'invalid-continue-uri':
        return 'Invalid request. Please try again later.';

      case 'missing-ios-bundle-id':
        return 'Internal error occurred. Please contact support.';

      case 'missing-continue-uri':
        return 'Internal error occurred. Please contact support.';

      case 'missing-android-pkg-name':
        return 'Internal error occurred. Please contact support.';

      default:
        return "An undefined error occurred.";
    }
  }

  Future<Map<String, dynamic>?> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dataString = prefs.getString('user');
    Map<String, dynamic>? user;
    if (dataString != null) {
      user = json.decode(dataString) as Map<String, dynamic>;
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        prefs.setString('user', json.encode(snapshot.data()));
      }
    });
    return user;
  }

  Future<void> saveImageToFireStore(bool flag) async {
    try {
      final imageFile = File(_image?.path ?? '');
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('users')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(imageFile);

      flag = true;
      await uploadTask.whenComplete(() async {
        flag = false;
        final url = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .update({
          'image': url,
        });
      });
    } catch (e) {}
  }
}
