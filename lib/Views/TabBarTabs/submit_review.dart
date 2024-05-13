import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowcut/Common/toast_message.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Views/HomeScreen/Common/home_screen_header.dart';
import 'package:wowcut/Views/TabBarTabs/review.dart';

class SubmitReviewView extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  SubmitReviewView({super.key});
  TextEditingController addReivewController = TextEditingController();

  // get reviews => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                const HeaderHomeScreen(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  // height: 400,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 20),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Divider(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              "Your overall rating of the services",
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: AppColors.lightGrey),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            RatingBar.builder(
                              initialRating: 5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (double value) {},
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Add Detailed Review",
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryColor),
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                height: 150,
                                width: 370,
                                child: TextFormField(
                                    controller: addReivewController,
                                    decoration: InputDecoration(
                                      hintText: "Type Here",
                                      hintStyle: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: AppColors.lightGrey),
                                      contentPadding: const EdgeInsets.only(
                                          top: 15, left: 20),
                                      border: const OutlineInputBorder(),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        // Allow only basic formatting characters
                                        RegExp(r'^[a-zA-Z0-9\s.,?!-]*$'),
                                      ),
                                    ])),
                            const SizedBox(
                              height: 20,
                            ),
                            //here
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: PrimaryButton(
                  text: "Submit Review",
                  onPressed: () {
                    ReviewClass.setReview(addReivewController.text);
                    LocalStorageServiceforReview.saveReview(
                        addReivewController.text);

                    ToastMessage()
                        .toastMessage("review submited", color: Colors.green);

                    // Navigator.pushNamed(context, RouteName.tab);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class ReviewClass {
  static ValueNotifier<String> reviewNotifier = ValueNotifier<String>("");

  static String get getName => reviewNotifier.value;

  static void setReview(String reviewText) async {
    reviewNotifier.value = reviewText;
    await LocalStorageServiceforReview.saveReview(reviewText);
  }

  static Future<void> retrieveDataReview() async {
    final review = await LocalStorageServiceforReview.getReview();

    if (review != null) {
      reviewNotifier.value = review;
    }
  }
}

class LocalStorageServiceforReview {
  static const String reviewKey = 'reviews';

  static Future<void> saveReview(String review) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(reviewKey, review);
  }

  static Future<String?> getReview() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(reviewKey);
  }
}
