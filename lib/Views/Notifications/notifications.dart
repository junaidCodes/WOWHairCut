import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_bar.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> notifications = [
      'Congratulations, Your booking for a relaxing psa session has been confrimed',
      'Your preferred stylist, Lisa, is available for the appointment on Wednesday',
      'Your estimated wait time at the salon is approximately 25 minutes',
      'Congratulations, Your booking for a relaxing psa session has been confrimed',
      'Your preferred stylist, Lisa, is available for the appointment on Wednesday',
      'Congratulations, Your booking for a relaxing psa session has been confrimed',
      'Your preferred stylist, Lisa, is available for the appointment on Wednesday',
      'Your estimated wait time at the salon is approximately 25 minutes',
      'Congratulations, Your booking for a relaxing psa session has been confrimed',
      'Your preferred stylist, Lisa, is available for the appointment on Wednesday',
    ];
    return Scaffold(
      appBar: customBar("Notificatifon", true, context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: PathToImage.specialistsImages.length,
                  // itemCount: pages.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          context.showSnackBar("coming Soon");
                        },
                        child: Container(
                          // height: 80,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              // color: Colors.amber,
                              borderRadius: BorderRadius.circular(14)),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                  PathToImage.specialistsImages[index]),
                            ),
                            title: Text(
                              notifications[index],
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
