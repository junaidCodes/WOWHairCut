import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/exit_popup.dart';
import 'package:wowcut/Views/Authentication/Location/location_manually.dart';

class LocationOnMapView extends StatefulWidget {
  LocationOnMapView({super.key});

  @override
  State<LocationOnMapView> createState() => _LocationOnMapViewState();
}

class _LocationOnMapViewState extends State<LocationOnMapView> {
  late GoogleMapController mapController;
  bool loading = false;
  late BitmapDescriptor markerIcon;
  late BitmapDescriptor currentLocMarkerIcon;

  @override
  void initState() {
    customIcon();
    customIconCurrentLoc();

    super.initState();
    MyValueNotifier.retrieveData();

    setState(() {});
  }

  customIcon() async {
    loading = true;
    markerIcon = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/png/pinLocation.png")
        .then((icon) {
      setState(() {
        markerIcon = icon;
        loading = false;
      });
      return icon;
    });
  }

  customIconCurrentLoc() async {
    loading = true;
    currentLocMarkerIcon = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/png/exactLoc.png")
        .then((icon) {
      setState(() {
        currentLocMarkerIcon = icon;
        loading = false;
      });
      return icon;
    });
  }

  Future<Position> getUserPermission() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      context.showSnackBar(error.toString());
    }).then((value) {});
    return Geolocator.getCurrentPosition();
  }

  late Marker googleMarker1 = Marker(
      markerId: const MarkerId('userLocation'),
      infoWindow: const InfoWindow(title: 'User Location'),
      position: LatLng(MyValueNotifier.latitudeNotifier.value,
          MyValueNotifier.longitudeNotifier.value),
      icon: markerIcon);

  DateTime? currentBackPressTime;
  bool canPopNow = false;
  int requiredSeconds = 2;

  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  double lat = 0.0;
  double lng = 0.0;

  late Marker currentLocMarker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
          onTap: () {
            getUserPermission().then((value) async {
              lat = value.latitude;
              lng = value.longitude;

              CameraPosition camPoss = CameraPosition(
                  // bearing: 192.8334901395799,
                  target: LatLng(value.latitude, value.longitude),
                  // tilt: 59.440717697143555,
                  zoom: 14.151926040649414);

              GoogleMapController controllerr = await _controller.future;

              controllerr
                  .animateCamera(CameraUpdate.newCameraPosition(camPoss));

              setState(() {});
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                    color: const Color(0xff7f7f7f).withOpacity(0.3))),
            child: SvgPicture.asset("assets/svg/currentLoc.svg"),
          )),
      appBar: customBar("Location on Map", false, context),
      body: PopScope(
        canPop: canPopNow,
        onPopInvoked: onPopInvoked,
        child: AnnotatedRegion(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.yellow,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
            ),
            child: loading == true
                ? const Center(child: CircularProgressIndicator())
                : ValueListenableBuilder(
                    valueListenable: MyValueNotifier.latitudeNotifier,
                    builder: (BuildContext context, dynamic latitude,
                        Widget? child) {
                      return ValueListenableBuilder(
                        valueListenable: MyValueNotifier.longitudeNotifier,
                        builder: (BuildContext context, dynamic longitude,
                            Widget? child) {
                          return GoogleMap(
                            markers: {
                              Marker(
                                markerId: const MarkerId('userLocation'),
                                infoWindow:
                                    const InfoWindow(title: 'User Location'),
                                position: LatLng(latitude, longitude),
                                icon: markerIcon,
                              ),
                              Marker(
                                markerId: const MarkerId('userLocation'),
                                infoWindow:
                                    const InfoWindow(title: 'User Location'),
                                position: LatLng(lat, lng),
                                icon: currentLocMarkerIcon,
                              ),
                            },
                            onMapCreated: (GoogleMapController controller) {
                              // mapController = controller;
                              _controller.complete(controller);
                            },
                            initialCameraPosition:
                                // camPos,

                                CameraPosition(
                              target: LatLng(latitude, longitude),
                              zoom: 14,
                            ),
                            mapType: MapType.normal,
                            myLocationButtonEnabled: false,
                            myLocationEnabled: false,
                            zoomControlsEnabled: false,
                            onCameraMove: (CameraPosition position) {
                              // You can do something when camera position changes
                            },
                          );
                        },
                      );
                    })),
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
