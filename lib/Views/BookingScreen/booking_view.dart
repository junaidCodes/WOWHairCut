import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Common/multi_checkbox.dart';
import 'package:wowcut/Common/toast_message.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Utils/specialist_gridview.dart';
import 'package:wowcut/Views/BookingScreen/Common/day_listview.dart';
import 'package:wowcut/Views/BookingScreen/booking_button2.dart';
import 'package:wowcut/Views/HomeScreen/Common/home_screen_header.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  List<String> names = [
    'Darrell Steward',
    'Arlene McCoy',
    'Jenny Wilson',
    'Darrell Steward',
    'Arlene McCoy',
    'Jenny Wilson',
    'Darrell Steward',
    'Arlene McCoy',
    'Jenny Wilson',
    'Jenny Wilson',
  ];
  List<String> profession = [
    'Hair Stylist',
    'Nail Artist',
    'Shaving Expert',
    'Hair Stylist',
    'Nail Artist',
    'Shaving Expert',
    'Hair Stylist',
    'Nail Artist',
    'Shaving Expert',
    'Shaving Expert',
  ];
  int currentIndex = 0;
  int currentIndexTimeButton = 0;
  List<String> timings = [
    '7:00 PM',
    '7:30 PM',
    '8:00 PM',
    '8:30 PM',
  ];

  late List<bool> _selected;

  @override
  void initState() {
    super.initState();
    // Initialize the list of selected states
    _selected = List<bool>.generate(
        PathToImage.specialistsImages.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    ScrollController constrolScroll = ScrollController();
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
            controller: constrolScroll,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  toolbarHeight: 635,
                  flexibleSpace: Column(
                    children: [
                      const HeaderHomeScreen(),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Book Appointment",
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryColor),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Day",
                                  style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightGrey),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const SizedBox(
                                height: 80,
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: DayListView(),
                                )),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Time",
                                  style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightGrey),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            SizedBox(
                              height: 80,
                              width: double.infinity,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  primary: false,
                                  itemCount: 4,
                                  itemBuilder: (BuildContext context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        // height: 20,
                                        child: BookingButton2(
                                          subTitle: timings[index],
                                          // text: "gg",
                                          buttonColor:
                                              currentIndexTimeButton == index
                                                  ? AppColors.primaryColor
                                                  : Colors.white,
                                          textColor:
                                              currentIndexTimeButton == index
                                                  ? Colors.white
                                                  : Colors.black,
                                          onPressed: () {
                                            currentIndexTimeButton = index;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ];
            },
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.aspectRatio,

                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15)),
                      // height: 400,
                      width: double.infinity,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 25, right: 10),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3, right: 20),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(
                            "Specialist",
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  // maxCrossAxisExtent: 100,
                                  crossAxisCount: 3,
                                  childAspectRatio: 4 / 5.5,
                                  crossAxisSpacing: 25,
                                  mainAxisSpacing: 10),
                          itemCount: PathToImage.specialistsImages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SpecialistGridView(
                              checkBox: CustomCheckbox1(
                                isSelected: _selected[index],
                                onTap: () {
                                  setState(() {
                                    _selected = List<bool>.generate(
                                        PathToImage.specialistsImages.length,
                                        (index) => false);
                                    _selected[index] = true;
                                  });
                                },
                              ),
                              imgpath: PathToImage.specialistsImages[index],
                              names: names[index],
                              profession: profession[index],
                              rating: "4.1",
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: PrimaryButton(
                        text: "Next",
                        onPressed: () {
                          bool anySelected = _selected.contains(true);
                          if (anySelected) {
                            Navigator.pushNamed(
                                context, RouteName.paymentMethod);
                          } else {
                            context.showSnackBar("Please select specialist");
                          }
                        }),
                  ),
                ),
              ],
            )));
  }
}
