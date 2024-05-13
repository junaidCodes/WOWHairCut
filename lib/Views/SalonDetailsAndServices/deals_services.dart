import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Utils/tab_bar.dart';
import 'package:wowcut/Views/HomeScreen/Common/home_screen_header.dart';

import 'package:wowcut/Views/SalonDetailsAndServices/Common/info_plate.dart';
import 'package:wowcut/Views/TabBarTabs/about_us.dart';
import 'package:wowcut/Views/TabBarTabs/packages.dart';
import 'package:wowcut/Views/TabBarTabs/review.dart';
import 'package:wowcut/Views/TabBarTabs/services.dart';
import 'package:wowcut/Views/TabBarTabs/specialist.dart';
import 'package:share_plus/share_plus.dart';

class SalonServicesView extends StatefulWidget {
  const SalonServicesView({super.key});

  @override
  State<SalonServicesView> createState() => _SalonServicesViewState();
}

class _SalonServicesViewState extends State<SalonServicesView> {
  ScrollController controllScroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              toolbarHeight:
                  // MediaQuery.of(context).size.height * 1 * 0.72,
                  457,
              automaticallyImplyLeading: false,
              flexibleSpace: Column(
                children: [
                  const HeaderHomeScreen(),
                  InfoPlate(
                    onPressWeb: () {
                      _launchURL("https://www.virtuenetz.com/");
                    },
                    onPressMessage: () => _launchSms('2345'),
                    onPressCall: () => _makeCall('1234'),
                    onPressShare: shareApp,
                  ),
                ],
              ),
              pinned: false,
            ),
          ];
        },
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: CustomTabBar(tabTitles: const [
                    'Services',
                    'Specialist',
                    'Package',
                    'Review',
                    'About Us'
                  ], pages: [
                    const Center(child: ServicesTab()),
                    const Center(child: SpcialistTab()),
                    const Center(child: PackagesTab()),
                    Center(child: ReviewTab()),
                    const Center(child: AboutUsTab()),
                  ]),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: PrimaryButton(
                    text: "Book Appointment",
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.bookingView);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> shareApp() async {
    const String appUrl = 'https://virtuenetz.com';
    await Share.share(appUrl);
  }
}

Future<void> _launchSms(String phoneNumber) async {
  String url = 'sms:$phoneNumber';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> _makeCall(String phoneNumber) async {
  final Telephony telephony = Telephony.instance;
  await telephony.dialPhoneNumber(phoneNumber);
}

Future<void> _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
