import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Utils/app_colors.dart';

class ServicesComponent extends StatefulWidget {
  const ServicesComponent({super.key});

  @override
  State<ServicesComponent> createState() => _ServicesComponentState();
}

class _ServicesComponentState extends State<ServicesComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {},
                        icon: CircleAvatar(
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(0.1),
                          radius: 23,
                          child: SvgPicture.asset(
                            PathToImage.hairCutIcon,
                          ),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Haircut",
                      style: GoogleFonts.inter(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {},
                        icon: CircleAvatar(
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(0.1),
                          radius: 23,
                          child: SvgPicture.asset(
                            PathToImage.makeUpIcon,
                          ),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Makeup",
                      style: GoogleFonts.inter(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {},
                        icon: CircleAvatar(
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(0.1),
                          radius: 23,
                          child: SvgPicture.asset(
                            PathToImage.shavingIcon,
                          ),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Shaving",
                      style: GoogleFonts.inter(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {},
                        icon: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  AppColors.primaryColor.withOpacity(0.1),
                              radius: 23,
                              child: SvgPicture.asset(
                                PathToImage.massageIcon,
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Massage",
                      style: GoogleFonts.inter(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {},
                        icon: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  AppColors.primaryColor.withOpacity(0.1),
                              radius: 23,
                              child: SvgPicture.asset(
                                PathToImage.combedIcon,
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Combed",
                      style: GoogleFonts.inter(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor),
                    ),
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
