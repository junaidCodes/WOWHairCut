import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Common/multi_checkbox.dart';
import 'package:wowcut/Common/toast_message.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Utils/specialist_gridview.dart';
import 'package:wowcut/Views/BookingScreen/booking_button2.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  Color primary = AppColors.primaryColor;
  bool flag = false;
  List<String> gender = ['Male', 'Female'];
  List<String> services = [
    'Haircut',
    'Makeup',
    'Shaving',
  ];

  int currentIndex = 0;
  int currentIndexService = 0;
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
  // int _selectedIndex = -1;
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
                  toolbarHeight: 100,
                  flexibleSpace: AppBarCustom(
                    title: "Filter",
                    showBack: true,
                  ),
                )
              ];
            },
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      // height: MediaQuery.of(context).size.aspectRatio,

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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
                            style: GoogleFonts.inter(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < 2; i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 15,
                                  ),
                                  // child:

                                  child: SizedBox(
                                    height: 50,
                                    child: BookingButton2(
                                        subTitle: gender[i],
                                        buttonColor: currentIndex == i
                                            ? primary
                                            : Colors.white,
                                        textColor: currentIndex == i
                                            ? Colors.white
                                            : Colors.grey,
                                        onPressed: () {
                                          currentIndex = i;
                                          setState(() {});
                                        }),
                                  ),
                                )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Services",
                            style: GoogleFonts.inter(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            // height: 50,
                            height: MediaQuery.of(context).size.height * 0.066,
                            child: ListView.builder(
                                itemCount: services.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (buildcontext, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: SizedBox(
                                      height: 50,
                                      child: BookingButton2(
                                          subTitle: services[index],
                                          buttonColor:
                                              currentIndexService == index
                                                  ? AppColors.primaryColor
                                                  : Colors.white,
                                          textColor:
                                              currentIndexService == index
                                                  ? Colors.white
                                                  : Colors.grey,
                                          onPressed: () {
                                            currentIndexService = index;
                                            setState(() {});
                                          }),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.1),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  }),
                              imgpath: PathToImage.specialistsImages[index],
                              names: names[index],
                              profession: profession[index],
                              rating: "4.8",
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
                    child: Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              buttonColor: Colors.white,
                              textColor: AppColors.primaryColor,
                              text: "Reset Filter",
                              onPressed: () {
                                currentIndex = 0;
                                currentIndexService = 0;
                                _selected = List<bool>.generate(
                                  PathToImage.specialistsImages.length,
                                  (index) => false,
                                );

                                setState(() {});
                              }),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                            child: PrimaryButton(
                                text: "Apply",
                                onPressed: () {
                                  bool anySelected = _selected.contains(true);
                                  if (anySelected) {
                                    ToastMessage().toastMessage("Applied");
                                    Timer.periodic(const Duration(seconds: 2),
                                        (timer) {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    context.showSnackBar(
                                        "Please select specialist");
                                  }
                                }))
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
