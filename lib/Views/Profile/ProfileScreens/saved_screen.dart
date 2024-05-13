import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';

class SavedView extends StatefulWidget {
  const SavedView({super.key});

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  int currentIndex = 0;
  Color btnColor = AppColors.primaryColor;
  List<String> categories = ['All', 'Haircut', 'Make Up', 'Shaving'];
  List<String> profession = [
    'Beauty Make Up',
    'Hair Stylish',
    'Nail Artist',
    'Beauty Make Up',
    'Hair Stylish',
    'Beauty Make Up',
    'Hair Stylish',
    'Nail Artist',
    'Beauty Make Up',
    'Hair Stylish',
  ];

  List<String> getFilteredProfession() {
    if (currentIndex == 0) {
      return profession; // All selected, return all professions
    } else {
      String selectedCategory = categories[currentIndex];
      return profession
          .where((prof) => prof.contains(selectedCategory))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        flexibleSpace: AppBarCustom(
          title: "Saved",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              // color: Colors.red,
              // width: double.infinity,
              height: 50,

              child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                          height: 45,
                          width: 120,
                          child: PrimaryButton(
                              buttonColor: currentIndex == index
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              textColor: currentIndex == index
                                  ? Colors.white
                                  : Colors.grey,
                              text: categories[index],
                              onPressed: () {
                                currentIndex = index;
                                setState(() {});
                              })),
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: getFilteredProfession().length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: InkWell(
                        onTap: () {
                          context.showSnackBar("Coming Soon");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2))),
                          height: 140,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        PathToImage.specialistsImages[index],
                                        height: 100,
                                        width: 110,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: InkWell(
                                                onTap: () {
                                                  context.showSnackBar(
                                                      "Coming Soon");
                                                },
                                                child: Text(
                                                  profession[index],
                                                  style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .secondaryColor),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: 40,
                                            // ),

                                            CircleAvatar(
                                              radius: 16,
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              child: IconButton(
                                                  onPressed: () {
                                                    context.showSnackBar(
                                                        "coming Soon");
                                                  },
                                                  icon: SvgPicture.asset(
                                                    PathToImage.favouriteIcon,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                PathToImage.pinLocationIcon),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                              width: 167,
                                              child: Text(
                                                "ul. Hektora 147, Warszawa 02-874",
                                                style: GoogleFonts.inter(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          // mainAxisAlignment:
                                          // MainAxisAlignment.spaceAround,
                                          children: [
                                            SvgPicture.asset(
                                                PathToImage.ratingStar),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "4.8 (1k + Reviews)",
                                              style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
