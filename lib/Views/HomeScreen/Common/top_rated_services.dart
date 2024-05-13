// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Common/media_query.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';

class TopRatedServices extends StatefulWidget {
  String imgPath;
  TopRatedServices({super.key, required this.imgPath});

  @override
  State<TopRatedServices> createState() => _TopRatedServicesState();
}

class _TopRatedServicesState extends State<TopRatedServices> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double heights = context.height;
    double widths = context.width;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.pushNamed(context, RouteName.salonServicesView);
        },
        child: Container(
            clipBehavior: Clip.hardEdge,
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                // color: Colors.amber,
                // color: Colors.red,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: Color(0xff7f7f7f).withOpacity(0.3), width: 0.5)),
            child: Column(
              children: [
                Column(
                  children: [
                    Stack(alignment: Alignment.topRight, children: [
                      Image.asset(
                        widget.imgPath,
                        width: 200,
                        height: 113,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {},
                            icon: CircleAvatar(
                              radius: 17,
                              backgroundColor: AppColors.primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: SvgPicture.asset(
                                  PathToImage.favouriteIcon,
                                  height: 16,
                                  width: 18,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ))
                    ]),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Wow Hair saloon",
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryColor),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hair Stylish",
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.lightGrey),
                              ),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 240, 218, 25),
                                    size: 15,
                                  ),
                                  Text("4.8")
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
