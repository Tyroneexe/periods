import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:periods/screens/login_page.dart';
import 'package:periods/themes/colors.dart';
import 'package:periods/themes/text_styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isNotification = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                    elevation: 7,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                      ),
                      child: const Icon(
                        IconlyLight.arrow_left_2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Settings',
                    textAlign: TextAlign.center,
                    style: semiBold.copyWith(
                      fontSize: 18,
                      color: const Color(
                        0xFF10275A,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'General',
              style: semiBold.copyWith(
                fontSize: 16,
                color: const Color(
                  0xFF10275A,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Delete Account",
                        style: semiBold,
                      ),
                      content: Text(
                        "Clear all settings and delete the current account",
                        style: regularFont,
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            "Cancel",
                            style: semiBold.copyWith(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          onPressed: () {
                            Hive.box('userSettings').clear();
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            "OK",
                            style: bold.copyWith(
                              color: primaryClr,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            Get.to(() => const LogInPage());
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Delete Account',
                    style: regularFont.copyWith(
                      fontSize: 16,
                      color: const Color(
                        0xFF10275A,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(IconlyLight.arrow_right_2)
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Notifications',
              style: semiBold.copyWith(
                fontSize: 16,
                color: const Color(
                  0xFF10275A,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Allow Notifications',
                  style: regularFont.copyWith(
                    fontSize: 16,
                    color: const Color(
                      0xFF10275A,
                    ),
                  ),
                ),
                const Spacer(),
                Switch(
                  activeColor: Colors.white,
                  activeTrackColor: primaryClr,
                  inactiveTrackColor: const Color(0xFFB1C0DE),
                  inactiveThumbColor: Colors.white,
                  value: isNotification,
                  onChanged: (value) {
                    setState(() {
                      isNotification = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
