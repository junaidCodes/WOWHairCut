import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/specialist_gridview.dart';

class SpcialistTab extends StatefulWidget {
  const SpcialistTab({super.key});

  @override
  State<SpcialistTab> createState() => _SpcialistTabState();
}

class _SpcialistTabState extends State<SpcialistTab> {
  ScrollController controllScroll = ScrollController();

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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 20),
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Specialist",
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryColor),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "(4)",
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 4 / 5.4,
                crossAxisSpacing: 25,
                mainAxisSpacing: 10),
            itemCount: PathToImage.specialistsImages.length,
            itemBuilder: (BuildContext context, int index) {
              return SpecialistGridView(
                  imgpath: PathToImage.specialistsImages[index],
                  names: names[index],
                  profession: profession[index],
                  rating: "4.8",
                  onpressed: () {
                    context.showSnackBar("Coming Soon");
                  });
            },
          ),
        ),
      ]),
    );
  }
}
