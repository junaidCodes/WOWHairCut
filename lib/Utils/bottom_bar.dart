// // ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Views/Authentication/Location/location_on_map.dart';
import 'package:wowcut/Views/BookingTabs/booking_tab_bar.dart';
import 'package:wowcut/Views/Chat/chat_list.dart';
import 'package:wowcut/Views/HomeScreen/home_screen.dart';
import 'package:wowcut/Views/Profile/profile.dart';

class BottomBarr extends StatefulWidget {
  String? currentAddress;
  BottomBarr({super.key, this.currentAddress});

  @override
  State<BottomBarr> createState() => _BottomBarrState();
}

class _BottomBarrState extends State<BottomBarr> {
  // late HomeView homeView = widget.currentAddress as HomeView;
  late Widget homeWidget;
  late List<Widget> _pages;
  @override
  void initState() {
    // TODO: implement initState
    homeWidget = HomeView(
      currentAddress: widget.currentAddress,
    );
    _pages = [
      homeWidget,

      // const HomeViewPage(),
      const FavPage(),

      const BookingsView(),

      const Chats(),
      const Profile(),
      // const SignInView(),
      // const ChatListTab()
    ];
    super.initState();
  }

  Color btnColor = Colors.grey;
  int _selectedIndex = 0;

  // Define your pages/screens here
  // final List<Widget> _pages =

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: LayoutBuilder(
          builder: (context, constraints) {
            // log("width    ${constraints.maxHeight}");
            return Stack(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.white,
                  ),
                  child: Container(
                    // height: 90,
                    height: MediaQuery.of(context).size.height * 0.12,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),

                      // boxShadow: [
                      //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                      // ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        elevation: 0,
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        selectedItemColor: AppColors.primaryColor,
                        unselectedItemColor: AppColors.lightGrey,
                        currentIndex: _selectedIndex,
                        onTap: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        items: [
                          // ,
                          BottomNavigationBarItem(
                            icon: Column(
                              children: [
                                SvgPicture.asset(
                                  PathToImage.bottomBarHomeIcon,
                                  color: _selectedIndex == 0
                                      ? AppColors.primaryColor.withOpacity(0.5)
                                      : btnColor,
                                ),
                              ],
                            ),
                            label: 'Home',
                          ),

                          //icon2
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              PathToImage.bottomBarExploreIcon,
                              color: _selectedIndex == 1
                                  ? AppColors.primaryColor
                                  : btnColor,
                            ),
                            label: 'Explore',
                          ),

                          //icon3

                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              PathToImage.bottomBarBookingIcon,
                              color: _selectedIndex == 2
                                  ? AppColors.primaryColor
                                  : btnColor,
                            ),
                            label: 'Bookings',
                          ),

                          //icon4
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              PathToImage.bottomBarChatsIcon,
                              color: _selectedIndex == 3
                                  ? AppColors.primaryColor
                                  : btnColor,
                            ),
                            label: 'Chats',
                          ),

                          //icon5
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              PathToImage.bottomBarProfileIcon,
                              color: _selectedIndex == 4
                                  ? AppColors.primaryColor
                                  : btnColor,
                            ),
                            label: 'Profile',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                    // bottom: 83,
                    // top: 3,
                    left: constraints.maxWidth /
                            4.95 *
                            (_selectedIndex) + //space of current index
                        (constraints.maxWidth /
                            14.6) - // minimize the half of it
                        0,
                    duration: const Duration(
                      milliseconds: 200,
                    ), // minimize the width of dash
                    child: SvgPicture.asset(
                      PathToImage.bottomBartopIcon,
                      height: 10,
                      width: 10,
                    )),
              ],
            );
          },
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
//1

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}

//2
class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return LocationOnMapView();
  }
}

//3
class BookingsView extends StatefulWidget {
  const BookingsView({super.key});

  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  @override
  Widget build(BuildContext context) {
    return const BookingTabBarView();
  }
}

//4
class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return const ChatListTab();
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}
