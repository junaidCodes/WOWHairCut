import 'package:flutter/material.dart';
import 'package:wowcut/Utils/app_colors.dart';

// ignore: must_be_immutable
class CustomTabBar extends StatefulWidget {
  final List<String> tabTitles;
  List<Widget> pages;

  CustomTabBar({Key? key, required this.tabTitles, required this.pages})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabTitles.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicatorColor: AppColors.primaryColor,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: AppColors.lightGrey,
          indicatorWeight: 3.2,
          dividerColor: const Color(0xff7f7f7f).withOpacity(0.3),
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          labelStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          controller: _tabController,
          tabs: widget.tabTitles.map((title) => Tab(text: title)).toList(),
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: widget.pages),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
