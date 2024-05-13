import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/bottom_bar.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Views/Authentication/Common/appbar_titles.dart';
import 'package:wowcut/Views/Authentication/Location/Services/handle_location.dart';
import 'package:wowcut/Views/Authentication/Location/location_manually.dart';
import 'package:wowcut/Views/OnBoarding/Common/text_button.dart';

class LocationAccessView extends StatefulWidget {
  LocationAccessView({super.key});

  @override
  State<LocationAccessView> createState() => _LocationAccessViewState();
}

class _LocationAccessViewState extends State<LocationAccessView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String? currentAddress;

  Position? currentPosition;

  Future<void> getAddress(Position position) async {
    log("langlat ${position.latitude.toString()}");
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemark) {
      Placemark place = placemark[0];
      setState(() {
        currentAddress = '${place.subAdministrativeArea}';
      });

      MyValueNotifier.setMyDoubleValue(position.latitude, position.longitude,
          place.subAdministrativeArea.toString());

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomBarr(
              currentAddress: currentAddress.toString(),
            ),
          ));
    }).onError((error, stackTrace) {
      context.showSnackBar(error.toString());
    });
  }

  Future<void> getCurrentLocation() async {
    final haspermission =
        await LocationServices().handleLocationPermission(context);
    if (!haspermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        currentPosition = position;
      });
      log("getLocation $position");
      getAddress(position);
    }).onError((error, stackTrace) {
      context.showSnackBar(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // void locToFb() async {
    //   await FirebaseFirestore.instance
    //       .collection("Location")
    //       .add({'location': currentAddress});
    // }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Text('LAT: ${currentPosition?.latitude ?? ""}'),
              // Text('Long: ${currentPosition?.longitude ?? ""}'),
              // Text('address: ${currentAddress ?? ""}'),
              const SizedBox(
                height: 36.98,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    PathToImage.sessorLogoBlue,
                    fit: BoxFit.cover,
                    height: 46.47,
                    width: 42.87,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "WOW ",
                              style: GoogleFonts.oswald(
                                  fontSize: 26.437,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryColor),
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              "HAIR ",
                              style: GoogleFonts.oswald(
                                  fontSize: 26.437,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text(
                            "SMART CUT",
                            style: GoogleFonts.inter(
                                fontSize: 11.438, letterSpacing: 5.49),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 33, right: 32),
                child: Image.asset(
                  PathToImage.locationAccess,
                  // height: 260,
                  // width: 300,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              AppbarTitles(
                  title: "What is Your Location?",
                  subtitle:
                      "We need to know your location in order to suggest nearby services"),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: PrimaryButton(
                    text: "Allow Location Access",
                    onPressed: () {
                      getCurrentLocation();
                      // log("check location${MyValueNotifier.placeNameNotifier.value}");
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              TexttButton(
                  paddings: 10,
                  googleFonts: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor),
                  text: "Enter Location Manually",
                  onPressed: () {
                    Navigator.popAndPushNamed(
                        context, RouteName.locationManualView);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

// class MyAddressNotifier {
//   static ValueNotifier<String> placeNameNotifier = ValueNotifier<String>("");

//   static String get getName => placeNameNotifier.value;

//   static void setMyDoubleValue(String placeName) {
//     placeNameNotifier.value = placeName;
//   }
// }
