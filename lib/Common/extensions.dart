import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void unFocus() {
    FocusScope.of(this).unfocus();
  }
}

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//  Map<String, dynamic> data = {};

//  @override
//  void initState() {
//     super.initState();
//     loadData();
//  }

//  Future<void> loadData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isDataFetched = prefs.getBool('isDataFetched') ?? false;
//     if (!isDataFetched) {
//       // Fetch data from Firestore
//       DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('yourCollection').doc('yourDoc').get();
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
//  }

//  @override
//  Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Home Page'),
//       ),
//       body: Center(
//         child: Text('Data: ${data.toString()}'),
//       ),
//     );
//  }
// }

