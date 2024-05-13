import 'package:flutter/material.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/exit_popup.dart';
import 'package:wowcut/Utils/tab_bar.dart';
import 'package:wowcut/Views/BookingTabs/Common/completed_tab.dart';
import 'package:wowcut/Views/BookingTabs/cancelled_tab.dart';
import 'package:wowcut/Views/BookingTabs/up_comming_tab.dart';

class BookingTabBarView extends StatefulWidget {
  const BookingTabBarView({super.key});

  @override
  State<BookingTabBarView> createState() => _BookingTabBarViewState();
}

class _BookingTabBarViewState extends State<BookingTabBarView> {
  DateTime? currentBackPressTime;
  bool canPopNow = false;
  int requiredSeconds = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBar("Booking", true, context),
      body: PopScope(
        canPop: canPopNow,
        onPopInvoked: onPopInvoked,
        child: CustomTabBar(
          // ignore: prefer_const_literals_to_create_immutables
          tabTitles: ['Upcoming', 'Completed', 'Cancelled'],
          pages: [
            Center(child: const UpcomingTab()),
            Center(child: ComplettedTab()),
            Center(
                child: CancelledTab(
              buttonText: "Re-Book",
            )),
          ],
        ),
      ),
    );
  }

  void onPopInvoked(bool didPop) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) >
            Duration(seconds: requiredSeconds)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(context, "Press again to exit");
      // Fluttertoast.showToast(msg: exit_warning);
      Future.delayed(
        Duration(seconds: requiredSeconds),
        () {
          // Disable pop invoke and close the toast after 2s timeout
          setState(() {
            canPopNow = false;
          });
          Fluttertoast.cancelToast();
        },
      );
      // Ok, let user exit app on the next back press
      setState(() {
        canPopNow = true;
      });
    }
  }
}
