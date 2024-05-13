import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';

// ignore: must_be_immutable
class ComplettedTab extends StatefulWidget {
  Widget? button;
  String remindMe;
  String buttonText;
  // VoidCallback onPress;

  ComplettedTab({
    super.key,
    this.button,
    this.remindMe = "",
    this.buttonText = "View E-Receipt",
    // required this.onPress
  });

  @override
  State<ComplettedTab> createState() => _ComplettedTabState();
}

class _ComplettedTabState extends State<ComplettedTab> {
  List<int> boolList = [];

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
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2))),
                      height: 224,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: SizedBox(
                                    // color: Colors.red,
                                    height: 35,
                                    // width: 2F00,

                                    child: Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Aug 25, 2024 - 10:00 AM",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 120,
                                )
                                // const Spacer(
                                //   flex: 3,
                                // ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey.withOpacity(0.2)),
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
                                const SizedBox(
                                  width: 50,
                                ),

                                Expanded(
                                  child: PrimaryButton(
                                      fontSize: 11.66,
                                      text: widget.buttonText,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, RouteName.eReciptView);
                                      }),
                                ),
                                const SizedBox(
                                  width: 50,
                                )
                                // Spacer(
                                //   flex: 2,
                                // )
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
