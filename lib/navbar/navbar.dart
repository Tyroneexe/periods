import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:periods/navbar/bar_controller.dart';
import 'package:periods/screens/notepad_page.dart';
import 'package:periods/screens/account_page.dart';
import 'package:periods/screens/calender_page.dart';
import 'package:periods/screens/home_page.dart';
import 'package:periods/themes/colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final controller = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
            children: const [
              HomePage(),
              CalenderPage(),
              NotepadPage(),
              AccountPage(),
            ],
          ),
          extendBody: true,
          bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 25,
                  offset: const Offset(8, 20),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: primaryClr,
                unselectedItemColor: greyClr,
                currentIndex: controller.tabIndex,
                onTap: controller.changeTabIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: CustomNavBarIcon(
                      iconData: IconlyBold.home,
                      isSelected: controller.tabIndex == 0,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: CustomNavBarIcon(
                      iconData: IconlyBold.calendar,
                      isSelected: controller.tabIndex == 1,
                    ),
                    label: "Favorite",
                  ),
                  BottomNavigationBarItem(
                    icon: CustomNavBarIcon(
                      iconData: IconlyBold.paper,
                      isSelected: controller.tabIndex == 2,
                    ),
                    label: "Settings",
                  ),
                  BottomNavigationBarItem(
                    icon: CustomNavBarIcon(
                      iconData: IconlyBold.profile,
                      isSelected: controller.tabIndex == 3,
                    ),
                    label: "Profile",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomNavBarIcon extends StatelessWidget {
  final IconData iconData;
  final bool isSelected;
  final Color? color;
  final Color? selectedColor;

  const CustomNavBarIcon({
    super.key,
    required this.iconData,
    this.isSelected = false,
    this.color,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          color: isSelected
              ? (selectedColor ?? primaryClr)
              : (color ?? themeData.iconTheme.color),
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 4,
            width: 4,
            decoration: BoxDecoration(
              color: selectedColor ?? primaryClr,
              shape: BoxShape.circle,
            ),
          )
      ],
    );
  }
}
