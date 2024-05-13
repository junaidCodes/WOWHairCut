import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Common/toast_message.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

class EReciptView extends StatefulWidget {
  EReciptView({
    Key? key,
  });

  @override
  State<EReciptView> createState() => _EReciptViewState();
}

class _EReciptViewState extends State<EReciptView> {
  dynamic buildBarcode(
    Barcode bc,
    String data, {
    String? filename,
    double? width,
    double? height,
    double? fontHeight,
  }) {
    /// Create the Barcode
    final svg = bc.toSvg(
      PathToImage.bottomBarHomeIcon,
      width: width ?? 200,
      height: height ?? 80,
      fontHeight: fontHeight,
    );

    // Save the image
    filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
    File('$filename.svg').writeAsStringSync(svg);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> reviewSummary = [
      "02/30",
      "Address",
      "Name",
      "Phone",
      "Booking Date",
      "Booking Hours",
      "Specialist",
    ];
    final List<String> reviewSummaryAns = [
      "Glamour Haven",
      "G8502 Preston Rd. Iglewood",
      "Esther Howard",
      "030477496163",
      "August 23, 2023",
      "10:00 AM",
      "Nathan Alexander",
    ];
    double h = context.height;

    ScreenshotController screenShotController = ScreenshotController();

    return Scaffold(
      appBar: customBar("View E-Receipt", true, context),
      body: SingleChildScrollView(
        // padding: EdgeInsets.only(top: kToolbarHeight),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Screenshot(
                    controller: screenShotController,
                    child: Image.asset(
                      PathToImage.eReciptBarCode,
                      height: 53,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: reviewSummary.length,
                      itemBuilder: (context, index) => Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              reviewSummary[index],
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightGrey,
                              ),
                            ),
                            Text(
                              reviewSummaryAns[index],
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  serviceItems([
                    'Haircut',
                    'Hair wash',
                    'Shaving'
                  ], [
                    "\$60.00",
                    "\$80.00",
                    "\$30.00",
                  ]),
                  SizedBox(height: h * 0.12),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: PrimaryButton(
                        text: "Download E-Receipt",
                        onPressed: () async {
                          await screenShotController
                              .capture()
                              .then((value) async {
                            if (value != null) {
                              final directory =
                                  await getApplicationDocumentsDirectory();
                              final imagePath =
                                  await File('${directory.path}/image.png')
                                      .create();
                              saveImageToGalley(value);

                              log(imagePath.toString());
                            } else {
                              log("value is null");
                            }
                          });
                          // saveToGallery();

                          Timer.periodic(const Duration(seconds: 2), (timer) {
                            ToastMessage()
                                .toastMessage("Reciept Saved  in Gallery");
                            Navigator.pushNamedAndRemoveUntil(context,
                                RouteName.bottomBarr, (route) => false);
                          });
                        }),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Methods//
  Widget serviceItems(List<String> titles, List<String> prices) {
    assert(titles.length == prices.length);
    return Container(
      // height: 111,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          children: List.generate(titles.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titles[index],
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightGrey,
                    ),
                  ),
                  Text(
                    prices[index],
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Future saveImageToGalley(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'screenshot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }
}
