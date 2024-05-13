// ignore_for_file: prefer_const_constructors_in_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Views/Authentication/Common/drop_down.dart';
import 'package:wowcut/Views/Authentication/Location/location_manually.dart';

class AppBarrHomeScreen extends StatelessWidget {
  // String location;
  // String text2;
  // Widget? w1;
  // Widget? w2;
  // Widget? w3;
  AppBarrHomeScreen({
    Key? key,
    // this.location = "",
    // this.text2 = "",
    // this.w1, this.w2, this.w3
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // AppBarrHomeScreen(),
        Container(
          width: double.infinity,
          color: Colors.transparent,
          child: Image.asset(
            PathToImage.appBar,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              // top: 37.0,
              top: MediaQuery.of(context).size.height * 0.05,
              left: 24,
              right: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                  // left: MediaQuery.of(context).size.width *
                  //     0.000007
                ),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "Location",
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.notificationsView);
                },
                icon: CircleAvatar(
                  backgroundColor: const Color(0xffFFFFFF).withOpacity(0.8),
                  child: Badge(
                    backgroundColor: const Color(0xffF94144),
                    child: SvgPicture.asset(PathToImage.notificationIcon),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 55,
              // top: MediaQuery.of(context).size.height * 0.2,
              left: 20),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                width: 4,
              ),
              SvgPicture.asset(
                PathToImage.pinLocationIcon,
                color: Colors.white,
                height: 17,
                width: 17,
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                flex: 3,
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteName.locationManualView);
                    },
                    child: ValueListenableBuilder(
                        valueListenable: MyValueNotifier.placeNameNotifier,
                        builder: (BuildContext context, dynamic value,
                            Widget? child) {
                          return Text(
                            MyValueNotifier.placeNameNotifier.value,
                            style: GoogleFonts.inter(
                              // fontSize: 18,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.0223,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          );
                        })),
              ),
              Flexible(
                flex: 3,
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteName.locationManualView);
                    },
                    icon: SvgPicture.asset(
                      PathToImage.dropDownIcon,
                      height: 9,
                      width: 16,
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
