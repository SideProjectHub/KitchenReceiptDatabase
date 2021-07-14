import 'package:flutter/material.dart';
import 'package:project/screens/HomePage/home_page.dart';
import 'package:project/screens/ProfilePage/user_profile_screen.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem({
    required this.page,
    required this.title,
    required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(Icons.home),
          title: "Home",
        ),
        TabNavigationItem(
          page: ProfilePage(),
          title: "Profile",
          icon: Icon(Icons.person),
        )
      ];
}
