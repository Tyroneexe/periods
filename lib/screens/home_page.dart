import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:periods/screens/account_page.dart';
import 'package:periods/screens/calender_page.dart';
import 'package:periods/themes/text_styles.dart';

/*
Account page
insert time table
home page kla maak
task page
*/

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String username = 'Guest';

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

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
              height: 50,
            ),
            _topBar(),
            const SizedBox(
              height: 30,
            ),
            Text(
              'My Day',
              style: semiBold.copyWith(
                fontSize: 24,
                color: const Color(
                  0xFF12175E,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _myDayBoxes(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Today: Day 1',
                  style: semiBold.copyWith(
                    fontSize: 24,
                    color: const Color(
                      0xFF12175E,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const CalenderPage());
                  },
                  child: Text(
                    'View all',
                    style: regular.copyWith(
                      fontSize: 12,
                      color: const Color(
                        0xFF393F93,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _myDayBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: (MediaQuery.of(context).size.width / 2) - 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFF7DC8E7),
                    Color(0xFFA1D7F7),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 20,
                    child: Row(
                      children: [
                        Image.asset('assets/blueArrow.png'),
                        const SizedBox(width: 7),
                        Image.asset('assets/blueArrow.png'),
                      ],
                    ),
                  ),
                  const Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(
                      IconlyLight.arrow_right,
                      color: Color(0xFF12175E),
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/Mac.png',
                          height: 90,
                        ),
                        Text(
                          'Completed',
                          style: medium.copyWith(
                            fontSize: 16,
                            color: const Color(
                              0xFF12175E,
                            ),
                          ),
                        ),
                        Text(
                          'Tasks',
                          style: regular.copyWith(
                            fontSize: 14,
                            color: const Color(
                              0xFF12175E,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 120,
              width: (MediaQuery.of(context).size.width / 2) - 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  14,
                ),
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFFE77D7D),
                    Color(0xFFF7A5A5),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 20,
                    child: Row(
                      children: [
                        Image.asset('assets/redArrow.png'),
                        const SizedBox(width: 7),
                        Image.asset('assets/redArrow.png'),
                      ],
                    ),
                  ),
                  const Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(
                      IconlyLight.arrow_right,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 10),
                          child: Icon(
                            IconlyLight.close_square,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        Text(
                          'Canceled',
                          style: medium.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Tasks',
                          style: regular.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: (MediaQuery.of(context).size.width / 2) - 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  14,
                ),
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Color(0xFF7D88E7), Color(0xFF99A1F2)],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 20,
                    child: Row(
                      children: [
                        Image.asset('assets/purArrow.png'),
                        const SizedBox(width: 7),
                        Image.asset('assets/purArrow.png'),
                      ],
                    ),
                  ),
                  const Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(
                      IconlyLight.arrow_right,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 10),
                          child: Icon(
                            IconlyLight.time_square,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        Text(
                          'Pending',
                          style: medium.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Tasks',
                          style: regular.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 150,
              width: (MediaQuery.of(context).size.width / 2) - 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFF81E89E),
                    Color(0xFFC4FACD),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 20,
                    child: Row(
                      children: [
                        Image.asset('assets/greenArrow.png'),
                        const SizedBox(width: 7),
                        Image.asset('assets/greenArrow.png'),
                      ],
                    ),
                  ),
                  const Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(
                      IconlyLight.arrow_right,
                      color: Color(0xFF12175E),
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/Folder.png',
                          height: 90,
                        ),
                        Text(
                          'Completed',
                          style: medium.copyWith(
                            fontSize: 16,
                            color: const Color(
                              0xFF12175E,
                            ),
                          ),
                        ),
                        Text(
                          'Tasks',
                          style: regular.copyWith(
                            fontSize: 14,
                            color: const Color(
                              0xFF12175E,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _topBar() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, $username',
              style: bold.copyWith(
                fontSize: 28,
                color: const Color(
                  0xFF12175E,
                ),
              ),
            ),
            Text(
              "Let's check your time table",
              style: regular.copyWith(
                fontSize: 16,
                color: const Color(
                  0xFF575757,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Get.to(() => const AccountPage());
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
                IconlyLight.profile,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _loadData() {
    var box = Hive.box('userSettings');
    String? loadedUsername = box.get('username');

    setState(() {
      username = loadedUsername!;
    });
  }
}
