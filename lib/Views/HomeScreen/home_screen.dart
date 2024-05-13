import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/exit_popup.dart';
import 'package:wowcut/Views/Authentication/Location/Services/handle_location.dart';
import 'package:wowcut/Views/Authentication/Location/location_manually.dart';
import 'package:wowcut/Views/HomeScreen/Common/app_bar_home_screen.dart';
import 'package:wowcut/Views/HomeScreen/Common/services_component.dart';
import 'package:wowcut/Views/HomeScreen/Common/top_rated_services.dart';
import 'package:wowcut/Views/HomeScreen/sliding_bar.dart';
import 'package:wowcut/Views/OnBoarding/Common/text_field.dart';

class HomeView extends StatefulWidget {
  String? currentAddress;
  HomeView({super.key, this.currentAddress});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    setState(() {
      MyValueNotifier.retrieveData();
    });
    if (MyValueNotifier.placeNameNotifier.value == "") {
      loader = true;
      setState(() {});
    } else {
      loader = false;
      setState(() {});
    }
  }

  bool loader = false;
  DateTime? currentBackPressTime;
  bool canPopNow = false;
  int requiredSeconds = 2;

  DateTime now = DateTime.now();
  List<String> imgTitles = [
    "Haircut",
    "Makeup",
    "Shaving",
    "Massage",
    "Combed",
  ];

  Future locationCheck(BuildContext context) async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // ignore: use_build_context_synchronously
      getCurrentLocation();
    } else {}
  }

  String? currentAddress;

  Position? currentPosition;
  Future<void> getAddress(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemark) {
      Placemark place = placemark[0];
      setState(() {
        currentAddress = '${place.subAdministrativeArea}';
      });
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
      getAddress(currentPosition!);
    }).onError((error, stackTrace) {
      context.showSnackBar(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // double h = context.height;
    // double w = context.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        flexibleSpace: Container(
          height: 150,
          color: Colors.transparent,
          child: ValueListenableBuilder(
            valueListenable: MyValueNotifier.placeNameNotifier,
            builder: (BuildContext context, dynamic value, Widget? child) {
              return AppBarrHomeScreen(
                  // location: MyValueNotifier.placeNameNotifier.value
                  );
            },
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: PopScope(
        canPop: canPopNow,
        onPopInvoked: onPopInvoked,
        child: SingleChildScrollView(
          child: AnnotatedRegion(
            value: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.light),
            child: Column(
              children: [
                SizedBox(
                  // height: 500,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 0,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 51,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: TextfieldCustom(
                                  inputType: TextInputType.name,
                                  hintText: "Search",
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    size: 35,
                                    color: AppColors.lightGrey,
                                  ),
                                )),
                            const SizedBox(
                              width: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RouteName.filterView);
                                    },
                                    icon: SvgPicture.asset(
                                      PathToImage.searchIcon,
                                      width: 24.47,
                                      height: 22,
                                      fit: BoxFit.cover,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        const SlideBar(),

                        //listview

                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Services",
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondaryColor)),
                                  IconButton(
                                      onPressed: () {
                                        context.showSnackBar("Coming Soon");
                                      },
                                      icon: const Icon(Icons.arrow_forward_ios))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // ServicesComponent(),
                              // const SizedBox(
                              //   height: 13,
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Top Rated Services",
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondaryColor)),
                                  IconButton(
                                      onPressed: () {
                                        context.showSnackBar("Coming Soon");
                                      },
                                      icon: const Icon(Icons.arrow_forward_ios))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 180,
                                child: ListView.builder(
                                    itemCount: PathToImage
                                        .topRatedServiceImages.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, index) {
                                      return TopRatedServices(
                                        imgPath: PathToImage
                                            .topRatedServiceImages[index],
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
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
