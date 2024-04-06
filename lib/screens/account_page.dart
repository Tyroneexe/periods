import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:periods/screens/add_task_page.dart';
import 'package:periods/screens/home_page.dart';
import 'package:periods/screens/login_page.dart';
import 'package:periods/screens/notepad_page.dart';
import 'package:periods/screens/settings_page.dart';
import 'package:periods/screens/time_table_page.dart';
import 'package:periods/themes/colors.dart';
import 'package:periods/themes/text_styles.dart';
import 'package:periods/widgets/custom_snackbar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController dayChangeController = TextEditingController();
  int? newDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      final RenderBox? overlay = Overlay.of(context)
                          .context
                          .findRenderObject() as RenderBox?;
                      if (overlay != null) {
                        await showMenu(
                          color: Colors.white,
                          context: context,
                          position: RelativeRect.fromRect(
                            Offset(
                                  MediaQuery.of(context).size.width - 70,
                                  90,
                                ) &
                                const Size(40, 40),
                            Offset.zero & overlay.size,
                          ),
                          items: [
                            PopupMenuItem(
                              onTap: () {
                                Get.to(() => const SettingsPage());
                              },
                              value: 'Settings',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    IconlyLight.setting,
                                    color: Color(
                                      0xFF10275A,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Settings',
                                    style: regularFont.copyWith(
                                      fontSize: 16,
                                      color: const Color(
                                        0xFF10275A,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Log Out",
                                        style: semiBold,
                                      ),
                                      content: Text(
                                        "Clear all Settings and Log Out",
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
                                            Hive.box('userSettings').clear();
                                            Get.to(() => const LogInPage());
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              value: 'Log Out',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    IconlyLight.logout,
                                    color: Color(
                                      0xFF10275A,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Log Out',
                                    style: regularFont.copyWith(
                                      fontSize: 16,
                                      color: const Color(
                                        0xFF10275A,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
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
                          IconlyLight.more_square,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Material(
                  elevation: 7,
                  shape: const CircleBorder(),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      IconlyBold.profile,
                      size: 35,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  username,
                  style: bold.copyWith(
                    fontSize: 25,
                    color: const Color(
                      0xFF10275A,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Center(
                child: Text(
                  'Student',
                  style: regularFont.copyWith(
                    fontSize: 14,
                    color: const Color(
                      0xFF10275A,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _taskBoxes1(),
              const SizedBox(
                height: 10,
              ),
              _taskBoxes2(),
            ],
          ),
        ),
      ),
    );
  }

  _taskBoxes1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => const MyTimeTable());
          },
          child: Container(
            height: 160,
            width: (MediaQuery.of(context).size.width / 2) - 30,
            decoration: BoxDecoration(
              color: const Color(0xFF858FE9).withOpacity(0.25),
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF858FE9),
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: const Icon(
                    IconlyLight.profile,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'My Time Table',
                  style: medium.copyWith(
                    fontSize: 14,
                    color: const Color(
                      0xFF10275A,
                    ),
                  ),
                ),
                Text(
                  'Task',
                  style: medium.copyWith(
                    fontSize: 12,
                    color: const Color(
                      0xFF12175D,
                    ).withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Get.to(() => const NotepadPage());
          },
          child: Container(
            height: 160,
            width: (MediaQuery.of(context).size.width / 2) - 30,
            decoration: BoxDecoration(
              color: const Color(0xFF7FC9E7).withOpacity(0.25),
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7FC9E7),
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: const Icon(
                    IconlyLight.work,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Homework',
                  style: medium.copyWith(
                    fontSize: 14,
                    color: const Color(
                      0xFF10275A,
                    ),
                  ),
                ),
                Text(
                  'Task',
                  style: medium.copyWith(
                    fontSize: 12,
                    color: const Color(
                      0xFF393939,
                    ).withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> setUserDefinedDay(BuildContext context) async {
    var box = Hive.box('userSettings');
    newDay = await promptUserForDay(context);

    if (newDay != null) {
      await box.put('Day', newDay);
      await box.put('lastUpdated', DateTime.now());
    }
  }

  Future<int?> promptUserForDay(BuildContext context) async {
    int? selectedDay;
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Set Current Day',
            style: semiBold.copyWith(
              fontSize: 24,
            ),
          ),
          content: TextField(
            controller: dayChangeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter day number",
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: primaryClr,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(
                  14,
                ),
              ),
            ),
            onChanged: (value) {
              selectedDay = int.tryParse(value);
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: medium,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'OK',
                style: bold.copyWith(
                  fontSize: 14,
                  color: primaryClr,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(selectedDay);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: CustomSnackbar(
                      title: 'Changed Day',
                      subTitle: 'You have changed day to $newDay',
                      color: primaryClr,
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  _taskBoxes2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setUserDefinedDay(context);
          },
          child: Container(
            height: 160,
            width: (MediaQuery.of(context).size.width / 2) - 30,
            decoration: BoxDecoration(
              color: const Color(0xFF81E89E).withOpacity(0.25),
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF81E89E),
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: const Icon(
                    IconlyLight.calendar,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Switch Day',
                  style: medium.copyWith(
                    fontSize: 14,
                    color: const Color(
                      0xFF10275A,
                    ),
                  ),
                ),
                Text(
                  'Task',
                  style: medium.copyWith(
                    fontSize: 12,
                    color: const Color(
                      0xFF393939,
                    ).withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Get.to(() => const AddTaskPage());
          },
          child: Container(
            height: 160,
            width: (MediaQuery.of(context).size.width / 2) - 30,
            decoration: BoxDecoration(
              color: const Color(0xFFF0A58E).withOpacity(0.25),
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0A58E),
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: const Icon(
                    IconlyLight.plus,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Create Time Table',
                  style: medium.copyWith(
                    fontSize: 14,
                    color: const Color(
                      0xFF10275A,
                    ),
                  ),
                ),
                Text(
                  'Task',
                  style: medium.copyWith(
                    fontSize: 12,
                    color: const Color(
                      0xFF393939,
                    ).withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
