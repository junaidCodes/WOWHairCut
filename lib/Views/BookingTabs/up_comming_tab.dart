import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';

class UpcomingTab extends StatefulWidget {
  const UpcomingTab({super.key});

  @override
  State<UpcomingTab> createState() => _UpcomingTabState();
}

List<int> boolList = [];

class _UpcomingTabState extends State<UpcomingTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.2), width: 0.5)),
                      height: 224,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Aug 25, 2024 - 10:00 AM",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Spacer(
                                    flex: 2,
                                  ),

                                  Text(
                                    "Remind me",
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.lightGrey),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),

                                  Flexible(
                                    flex: 3,
                                    child: Transform.scale(
                                      scale: 0.7,
                                      child: Switch(
                                        inactiveTrackColor: AppColors.lightGrey,
                                        inactiveThumbColor: Colors.white,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: boolList.contains(index),
                                        onChanged: (value) {
                                          setState(() {
                                            if (boolList.contains(index)) {
                                              boolList.remove(index);
                                            } else {
                                              boolList.add(index);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                  //
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey.withOpacity(0.2),
                            indent: 0,
                            endIndent: 0,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              // right: 10,
                              right: MediaQuery.of(context).size.width * 0.022,
                              // left: 15,
                              left: MediaQuery.of(context).size.width * 0.032,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    PathToImage.UpcommingTabImages[index],
                                    height: 80,
                                    // width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      "Glamour Haven",
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondaryColor),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            PathToImage.pinLocationIcon),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        SizedBox(
                                          // width: 150,
                                          child: Text(
                                            "8502 Preston Rd. Inglewood",
                                            style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
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
                                            PathToImage.idUpcomingTab),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "Service ID:#HR4198614",
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
                          ),
                          Divider(color: Colors.grey.withOpacity(0.2)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: PrimaryButton(
                                        fontSize: 11.66,
                                        buttonColor: Colors.white,
                                        text: "Cancel",
                                        textColor: AppColors.primaryColor,
                                        onPressed: () {
                                          context.showSnackBar("Coming Soon");
                                        })),
                                const SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  child: PrimaryButton(
                                      fontSize: 11.66,
                                      text: "View E-Receipt",
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, RouteName.eReciptView);
                                      }),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
