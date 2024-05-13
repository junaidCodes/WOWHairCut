import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Utils/exit_popup.dart';
import 'package:wowcut/Views/Authentication/SignInScreen/sign_in_view.dart';
import 'package:wowcut/Views/Authentication/SignUpScreen/sign_up_view.dart';

class ChatListTab extends StatefulWidget {
  const ChatListTab({
    super.key,
  });

  @override
  State<ChatListTab> createState() => _ChatListTabState();
}

class _ChatListTabState extends State<ChatListTab> {
  DateTime? currentBackPressTime;
  bool canPopNow = false;
  int requiredSeconds = 2;
  int currentIndex = 0;
  int indexs = 1 + 1;
  List<Widget> pages = [const SignInView(), const SignUpView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBar("Chats", false, context),
      body: PopScope(
        canPop: canPopNow,
        onPopInvoked: onPopInvoked,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
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
                            setState(() {
                              currentIndex = index;
                            });
                            Navigator.pushNamed(context, RouteName.chatScreen);
                          },
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: currentIndex == index
                                        ? AppColors.primaryColor
                                        : Colors.grey.withOpacity(0.3),
                                    width: 0.5),
                                // color: Colors.amber,
                                borderRadius: BorderRadius.circular(14)),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage(
                                  PathToImage.specialistsImages[index],
                                ),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ralph Edwards",
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "12 jul",
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.lightGrey),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Paperless opt-out email sent",
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.lightGrey),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: AppColors.primaryColor,
                                    radius: 12,
                                    child: Text(
                                      indexs.toString(),
                                      style: GoogleFonts.inter(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
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
