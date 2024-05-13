import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Utils/app_colors.dart';

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

List<String> list = <String>[
  'New York',
  'New York USA',
  'California USA',
  'London'
];

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;
  // bool isdropDownOpen = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: DropdownButton<String>(
        isDense: true,
        borderRadius: BorderRadius.circular(10),
        dropdownColor: AppColors.primaryColor,
        value: dropdownValue,
        icon: Row(
          children: [
            const SizedBox(
              width: 7,
            ),
            SvgPicture.asset(
              PathToImage.dropDownIcon,
              height: 9,
              width: 16,
            ),
          ],
        ),
        elevation: 16,
        style: GoogleFonts.inter(
          // fontSize: 18,
          fontSize: MediaQuery.of(context).size.height * 0.0223,
          fontWeight: FontWeight.w500,
          // color: isdropDownOpen ? Colors.red : Colors.white
        ),
        underline: const SizedBox(),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        onTap: () {},

        //
        // items: list.map(
        //   (curItem) {
        //     if (curItem == dropdownValue) {
        //       return DropdownMenuItem(
        //         value: curItem,
        //         child: Text(curItem.toString(),
        //             style: TextStyle(color: Colors.white)),
        //       );
        //     } else {
        //       return DropdownMenuItem(
        //         value: curItem,
        //         child: Text(curItem.toString(),
        //             style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
        //       );
        //     }
        //   },
        // ).toList(),
        //
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }
}
