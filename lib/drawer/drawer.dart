// ignore_for_file: must_be_immutable, unused_field, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:periods/screens/home_page.dart';
import 'package:periods/themes/colors.dart';
import '../themes/text_styles.dart';

class NavitionDrawer extends StatefulWidget {
  const NavitionDrawer({super.key});

  @override
  State<NavitionDrawer> createState() => _NavitionDrawerState();
}

class _NavitionDrawerState extends State<NavitionDrawer> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(
          25,
        ),
        bottomLeft: Radius.circular(
          25,
        ),
      ),
      child: Drawer(
        width: 290,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  //
  Widget buildHeader(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const HomePage());
      },
      child: Stack(
        children: [
          Positioned(
            top: 28,
            left: 16,
            child: IconButton(
              icon: Text(
                String.fromCharCode(Icons.close_rounded.codePoint),
                style: TextStyle(
                  inherit: false,
                  color: primaryClr,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  fontFamily: Icons.close_rounded.fontFamily,
                  package: Icons.close_rounded.fontPackage,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    color: primaryClr,
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name'),
                      Text('Version'),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  //
  Widget buildMenuItems(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Divider(
            thickness: 2,
            color: secondaryClr,
            height: 20,
            indent: 25,
            endIndent: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: const Icon(Icons.home, size: 30, color: primaryClr),
              title: Text(
                'Home',
                style: bold.copyWith(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                leading: const Icon(Icons.person, size: 30, color: primaryClr),
                title: Text(
                  'Account',
                  style: bold.copyWith(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Get.to(() => const HomePage());
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: const Icon(Icons.settings, size: 30, color: primaryClr),
              title: Text(
                'App Settings',
                style: bold.copyWith(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Get.to(() => const HomePage());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: const Icon(Icons.phone, size: 30, color: primaryClr),
              title: Text(
                'Contact Us',
                style: bold.copyWith(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 4,
                        color: accentClr,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Contact Us Via',
                              style: bold.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    //
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: primaryClr,
                                    elevation: 8.0,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    minimumSize: const Size(130, 80),
                                  ),
                                  child: const Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    //
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: primaryClr,
                                    elevation: 8.0,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    minimumSize: const Size(130, 80),
                                  ),
                                  child: const Icon(
                                    Icons.abc,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading:
                  const Icon(Icons.info_rounded, size: 30, color: primaryClr),
              title: Text(
                'About Us',
                style: bold.copyWith(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Get.to(() => const HomePage());
                // Get.to(() => Test());
              },
            ),
          ),
          const Divider(
            thickness: 2,
            color: secondaryClr,
            height: 20,
            indent: 25,
            endIndent: 25,
          ),
          // Row(
          //   children: [
          //     SizedBox(
          //       width: MediaQuery.of(context).size.width / 6,
          //     ),
          //     Text(
          //       'Light',
          //       style: bold.copyWith(
          //         fontSize: 16,
          //         color: Get.isDarkMode ? Colors.grey : Colors.black,
          //       ),
          //     ),
          //! Dark Mode Toggle
          // Padding(
          //   padding: const EdgeInsets.only(
          //     right: 10,
          //     left: 10,
          //   ),
          //   child: Switch(
          //     value: Get.isDarkMode,
          //     splashRadius: 10,
          //     activeTrackColor: switchClr,
          //     inactiveTrackColor: Colors.grey,
          //     inactiveThumbColor: Colors.white,
          //     activeColor: blueClr,
          //     onChanged: (bool value) {
          //       setState(() {
          //         ThemeService().switchTheme();
          //       });
          //       setState(() {});
          //     },
          //   ),
          // ),
          //     Text(
          //       'Dark',
          //       style: bold.copyWith(
          //           fontSize: 16,
          //           color: Get.isDarkMode ? Colors.white : Colors.grey),
          //     ),
          //   ],
          // ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextButton(
              onPressed: () {
                //
              },
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(bold.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                )),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  primaryClr,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(
                    MediaQuery.of(context).size.width,
                    38,
                  ),
                ),
              ),
              child: const Text('Log Out'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
