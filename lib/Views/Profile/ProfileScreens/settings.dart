// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/FireBaseDB/auth_service.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Views/Profile/Common/listile.dart';

class SettingView extends StatelessWidget {
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowDialogg();
      },
    );
  }

  SettingView({super.key});
  final auth = FirebaseAuth.instance;
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        flexibleSpace: AppBarCustom(
          title: "Settings",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            ListileWidget(
                icon: PathToImage.notificationIcon,
                title: "Notification Settings",
                onPress: () {
                  context.showSnackBar("co\ming soon");
                }),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey.withOpacity(0.05),
            ),
            const SizedBox(
              height: 10,
            ),
            ListileWidget(
                icon: PathToImage.passwordicon,
                title: "Password Manager",
                onPress: () {
                  Navigator.pushNamed(
                      context, RouteName.newPasswordViewInProfile);
                }),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey.withOpacity(0.05),
            ),
            const SizedBox(
              height: 10,
            ),
            ListileWidget(
                icon: PathToImage.deleteIcon,
                title: "Delete Account",
                onPress: () {
                  _showDialog(context);
                }),
          ],
        ),
      ),
    );
  }
}

class ShowDialogg extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  ShowDialogg({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Text(
        'Do you want to delete the account?',
        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            )),
        TextButton(
          onPressed: () async {
            AuthService(context).deleteUser();
          },
          child: Text(
            'Delete',
            style: GoogleFonts.inter(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
          ),
        )
      ],
    );
  }
}
