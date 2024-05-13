import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Utils/app_colors.dart';

// ignore: must_be_immutable
class InfoPlate extends StatelessWidget {
  VoidCallback onPressWeb;
  VoidCallback onPressMessage;
  VoidCallback onPressCall;
  VoidCallback onPressShare;

  InfoPlate({
    super.key,
    required this.onPressWeb,
    required this.onPressMessage,
    required this.onPressCall,
    required this.onPressShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      // height: 400,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: onPressWeb,
                        icon: CircleAvatar(
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(0.1),
                          radius: 30,
                          child: SvgPicture.asset(
                            PathToImage.websiteIcon,
                            height: 28,
                            width: 28,
                          ),
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Website",
                      style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: onPressMessage,
                        icon: CircleAvatar(
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(0.1),
                          radius: 30,
                          child: SvgPicture.asset(
                            PathToImage.messageIcon,
                            height: 28,
                            width: 28,
                          ),
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Message",
                      style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: onPressCall,
                        icon: CircleAvatar(
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(0.1),
                          radius: 30,
                          child: SvgPicture.asset(
                            PathToImage.callIcon,
                            height: 28,
                            width: 28,
                          ),
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Call",
                      style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: onPressShare,
                        icon: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  AppColors.primaryColor.withOpacity(0.1),
                              radius: 30,
                              child: SvgPicture.asset(
                                PathToImage.shareIcon,
                                height: 28,
                                width: 28,
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Share",
                      style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
