import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/bottom_bar.dart';
import 'package:wowcut/Views/Authentication/Location/PlaceModel.dart';
import 'package:wowcut/Views/Authentication/Location/Services/handle_location.dart';
import 'package:wowcut/Views/OnBoarding/Common/text_field.dart';
import 'package:http/http.dart' as http;

class LocationManualView extends StatefulWidget {
  const LocationManualView({super.key});

  @override
  State<LocationManualView> createState() => _LocationManualViewState();
}

class _LocationManualViewState extends State<LocationManualView> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
    // TODO: implement setState
  }

  TextEditingController controller = TextEditingController();
  bool condition = false;

  String sessionToken = "";
  final uuid = const Uuid();
  List<dynamic> placesList = [];
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      onChange();
    });
  }

  List<dynamic> listPlace = [];

  void onChange() {
    if (sessionToken == "") {
      setState(() {
        sessionToken = uuid.v4();
      });
    }

    fetchPlaces(controller.text);
  }

  String? currentAddress;

  Position? currentPosition;

  Future<void> getAddress(Position position) async {
    log("langlat ${currentPosition?.latitude.toString()}");
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemark) {
      Placemark place = placemark[0];
      setState(() {
        currentAddress = '${place.subAdministrativeArea}';
      });

      MyValueNotifier.setMyDoubleValue(currentPosition!.latitude,
          currentPosition!.longitude, place.subAdministrativeArea.toString());

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
      log("getLocation${position},${currentPosition}");
      getAddress(currentPosition!);
    }).onError((error, stackTrace) {
      context.showSnackBar(error.toString());
    });
  }

  List<Placemark> placemarks = [];
  getAddressFromCoord() async {
    placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
  }

  List<PlaceModel> places = [];
  Future<void> fetchPlaces(String query) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=AIzaSyCuJWFvaG1ZHCgYM2JwLQ61tptIHIcWct8'));

    if (response.statusCode == 200) {
      setState(() {
        places = _parsePlaces(response.body);
      });

      // setState(() {});
    } else {
      throw Exception('Failed to load places');
    }
  }

  List<PlaceModel> _parsePlaces(String responseBody) {
    final parsed = jsonDecode(responseBody);
    final results = parsed['results'];
    return List<PlaceModel>.from(
        results.map((place) => PlaceModel.fromJson(place)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 2, top: 2, bottom: 2),
            child: SvgPicture.asset(
              PathToImage.arrow,
              height: 10,
              width: 10,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Enter Location Manually",
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                    width: double.infinity,
                    child: TextfieldCustom(
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 35,
                        color: AppColors.lightGrey,
                      ),
                      controller: controller,
                      inputType: TextInputType.name,
                      hintText: "New York,USA",
                      // prefixIcon: Icon(Icons.search),
                      suffixIcon: InkWell(
                          radius: 0,
                          onTap: () {
                            controller.clear();
                            condition = false;
                            setState(() {});
                          },
                          child: condition == true
                              ? Image.asset(
                                  "assets/png/clear.png",
                                )
                              : const SizedBox()),
                      onTap: () {},
                      onChange: (value) {
                        if (value == "") {
                          condition = false;
                        } else {
                          condition = true;
                        }

                        setState(() {});
                      },
                    )),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: SvgPicture.asset(PathToImage.locationLogo)),
                    const SizedBox(
                      width: 6.99,
                    ),
                    TextButton(
                        onPressed: () {
                          getCurrentLocation();
                          // LocationServices().getCurrentLocation(context);
                        },
                        child: Text(
                          "Use my current location",
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 51.17,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Search Results",
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkGrey),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                      itemCount: places.length,
                      itemBuilder: (BuildContext context, index) {
                        final place = places[index];

                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: InkWell(
                            onTap: () {
                              MyValueNotifier.setMyDoubleValue(
                                  place.lat, place.lng, place.name);
                              Navigator.pushNamedAndRemoveUntil(context,
                                  RouteName.bottomBarr, (route) => false);
                            },
                            child: Text(
                              place.name.toString(),
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color((0xff7f7f7f))),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyValueNotifier {
  static ValueNotifier<double> latitudeNotifier = ValueNotifier<double>(0.0);
  static ValueNotifier<double> longitudeNotifier = ValueNotifier<double>(0.0);
  static ValueNotifier<String> placeNameNotifier = ValueNotifier<String>("");

  static double get latValue => latitudeNotifier.value;
  static double get lngValue => longitudeNotifier.value;
  static String get getName => placeNameNotifier.value;

  static void setMyDoubleValue(double lat, double lng, String placeName) async {
    latitudeNotifier.value = lat;
    longitudeNotifier.value = lng;
    placeNameNotifier.value = placeName;
    await LocalStorageService.savePlaceName(placeName);
    await LocalStorageService.saveLatLng(lat, lng);
  }

  static Future<void> retrieveData() async {
    final placeName = await LocalStorageService.getPlaceName();
    final latLng = await LocalStorageService.getLatLng();

    if (placeName != null) {
      placeNameNotifier.value = placeName;
    }

    if (latLng.isNotEmpty) {
      latitudeNotifier.value = latLng[0];
      longitudeNotifier.value = latLng[1];
    }
  }
}

class LocalStorageService {
  static const String placeNameKey = 'placeName';
  static const String latValueKey = 'lat';
  static const String lngValueKey = 'lng';

  static Future<void> savePlaceName(String placeName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(placeNameKey, placeName);
  }

  static Future<String?> getPlaceName() async {
    final prefs = await SharedPreferences.getInstance();
    log("locattion");
    log(placeNameKey.toString());

    return prefs.getString(placeNameKey);
  }

  static Future<void> saveLatLng(double lat, double lng) async {
    final prefss = await SharedPreferences.getInstance();
    await prefss.setDouble(latValueKey, lat);
    await prefss.setDouble(lngValueKey, lng);
  }

  static Future<List<double>> getLatLng() async {
    final prefs = await SharedPreferences.getInstance();
    double? lat = prefs.getDouble(latValueKey);
    double? lng = prefs.getDouble(lngValueKey);
    if (lat != null && lng != null) {
      return [lat, lng];
    } else {
      return [];
    }
  }
}
