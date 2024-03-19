// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:periods/navbar/bar_controller.dart';
import 'package:periods/screens/home_page.dart';
import 'package:periods/themes/colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, final String? payload});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final controller = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      builder: (context) {
        return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
            children: const [HomePage(), HomePage(), HomePage()],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: backgroundClr,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            selectedItemColor: primaryClr,
            unselectedItemColor: secondaryClr,
            currentIndex: controller.tabIndex,
            onTap: controller.changeTabIndex,
            selectedFontSize: 0,
            selectedIconTheme: const IconThemeData(size: 0),
            unselectedIconTheme: const IconThemeData(size: 0),
            items: [
              _bottombarItem(
                Icons.home,
                "",
                26,
              ),
              _bottombarItem(
                Icons.search_rounded,
                "",
                26,
              ),
              _bottombarItem(
                Icons.search_rounded,
                "",
                26,
              ),
            ],
          ),
        );
      },
    );
  }
}

_bottombarItem(IconData icon, String label, double size) {
  return BottomNavigationBarItem(
    icon: Icon(
      icon,
      size: size,
    ),
    label: label,
  );
}
