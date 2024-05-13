import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/multi_checkbox.dart';

import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/check_box.dart';

// ignore: must_be_immutable
class SpecialistGridView extends StatefulWidget {
  // bool flag;
  VoidCallback? onpressed;
  String imgpath;
  String rating;
  String names;
  String profession;
  Widget? checkBox;

  SpecialistGridView(
      {super.key,
      required this.imgpath,
      required this.names,
      required this.profession,
      required this.rating,
      this.onpressed,
      // this.flag = false,
      this.checkBox});

  @override
  State<SpecialistGridView> createState() => _SpecialistGridViewState();
}

class _SpecialistGridViewState extends State<SpecialistGridView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: widget.onpressed,
      child: Container(
          height: 10,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              // color: Colors.amber,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.imgpath,
                      // height: 88,
                      // width: 100,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 65,
                    right: 8,
                    child: SizedBox(
                      child: widget.checkBox,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                      right: 8,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(7.87)),
                      height: 15,
                      width: 35,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                              color: Color.fromARGB(255, 238, 140, 49),
                            ),
                            Text(
                              widget.rating,
                              style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondaryColor),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  width: 90,
                  // height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.names,
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.profession,
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightGrey),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
