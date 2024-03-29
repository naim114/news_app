import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/features/account/index.dart';
import 'package:news_app/src/features/notification/index.dart';
import 'package:news_app/src/services/helpers.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../model/user_model.dart';
import '../explore/index.dart';
import '../news/index.dart';

class FrontFrame extends StatefulWidget {
  const FrontFrame({super.key});

  @override
  State<FrontFrame> createState() => _FrontFrameState();
}

class _FrontFrameState extends State<FrontFrame> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  // Screen
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.newspaper),
        title: ("News"),
        activeColorPrimary:
            isDarkTheme(context) ? Colors.white : CustomColor.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("Explore"),
        activeColorPrimary:
            isDarkTheme(context) ? Colors.white : CustomColor.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.bell_fill),
        title: ("Notification"),
        activeColorPrimary:
            isDarkTheme(context) ? Colors.white : CustomColor.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_fill),
        title: ("Account"),
        activeColorPrimary:
            isDarkTheme(context) ? Colors.white : CustomColor.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel?>();

    return PersistentTabView(
      context,
      controller: _controller,
      screens: [
        News(
          mainContext: context,
          user: user,
          onAvatarTap: () => _controller.jumpToTab(3),
        ),
        Explore(
          mainContext: context,
          user: user,
          onAvatarTap: () => _controller.jumpToTab(3),
        ),
        Notifications(mainContext: context, user: user),
        Account(mainContext: context, user: user),
      ],
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor:
          isDarkTheme(context) ? CustomColor.primary : Colors.white,
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar:
            isDarkTheme(context) ? CustomColor.neutral1 : Colors.white,
        boxShadow: isDarkTheme(context)
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
      margin: const EdgeInsets.all(20),
    );
  }
}
