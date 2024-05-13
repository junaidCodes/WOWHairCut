import 'package:flutter/material.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Views/BookingScreen/booking_button.dart';

class DayListView extends StatefulWidget {
  const DayListView({super.key});

  @override
  State<DayListView> createState() => _DayListViewState();
}

int currentIndex = 0;
List<String> day = [
  'Today',
  'Mon',
  'Tue',
  'Wed',
];
List<String> date = [
  '3 Dec',
  '4 Dec',
  '5 Dec',
  '6 Dec',
];

class _DayListViewState extends State<DayListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              primary: false,
              itemCount: date.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 15,
                    child: BookingButton(
                      title: day[index],
                      subTitle: date[index],
                      buttonColor: currentIndex == index
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      textColor:
                          currentIndex == index ? Colors.white : Colors.black,
                      onPressed: () {
                        currentIndex = index;
                        setState(() {});
                      },
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
