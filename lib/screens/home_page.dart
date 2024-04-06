import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:periods/main.dart';
import 'package:periods/screens/account_page.dart';
import 'package:periods/screens/calender_page.dart';
import 'package:periods/screens/stats/completed_page.dart';
import 'package:periods/screens/stats/ongoing_page.dart';
import 'package:periods/screens/stats/pending_page.dart';
import 'package:periods/themes/colors.dart';
import 'package:periods/themes/text_styles.dart';
import 'package:periods/widgets/custom_snackbar.dart';

/*

  Update state so that the app is dynamic 
  Notification System
  
*/

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String username = 'Guest';
List<String> items = [];

class _HomePageState extends State<HomePage> {
  TextEditingController dayChangeController = TextEditingController();
  int? newDay;

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
                  'Today: Day $dayCounter',
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
                    style: regularFont.copyWith(
                      fontSize: 12,
                      color: const Color(
                        0xFF393F93,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _periodList(),
          ],
        ),
      ),
    );
  }

  _periodList() {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          Color backgroundColor;
          switch (index % 3) {
            case 0:
              backgroundColor = primaryClr;
              break;
            case 1:
              backgroundColor = accentClr;
              break;
            case 2:
            default:
              backgroundColor = secondaryClr;
              break;
          }

          String periodSuffix(int number) {
            int tens = number % 100;
            if (tens >= 11 && tens <= 13) {
              return 'th';
            }
            switch (number % 10) {
              case 1:
                return 'st';
              case 2:
                return 'nd';
              case 3:
                return 'rd';
              default:
                return 'th';
            }
          }

          return Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(
                  0xFFF9FAFD,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Container(
                      width: 3,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(
                          3,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (items[index]).toUpperCase(),
                        style: medium.copyWith(
                          fontSize: 16,
                          color: const Color(
                            0xFF2C406E,
                          ),
                        ),
                      ),
                      Text(
                        "${index + 1}${periodSuffix(index + 1)} Period",
                        style: regularFont.copyWith(
                          fontSize: 14,
                          color: const Color(
                            0xFF9AA8C7,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      //
                    },
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          );
        },
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
            GestureDetector(
              onTap: () {
                Get.to(() => const CompletedPage());
              },
              child: Container(
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
                            style: regularFont.copyWith(
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
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                setUserDefinedDay(context);
              },
              child: Container(
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
                            style: regularFont.copyWith(
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
            GestureDetector(
              onTap: () {
                Get.to(() => const PendingPage());
              },
              child: Container(
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
                            style: regularFont.copyWith(
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
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const OnGoingPage());
              },
              child: Container(
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
                            'On Going',
                            style: medium.copyWith(
                              fontSize: 16,
                              color: const Color(
                                0xFF12175E,
                              ),
                            ),
                          ),
                          Text(
                            'Tasks',
                            style: regularFont.copyWith(
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
            ),
          ],
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
      // ignore: use_build_context_synchronously
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
    }
  }

  Future<int?> promptUserForDay(BuildContext context) async {
    int? selectedDay;
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Cancel Today',
            style: semiBold.copyWith(
              fontSize: 24,
            ),
          ),
          content: TextField(
            controller: dayChangeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter new day number",
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
              },
            ),
          ],
        );
      },
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
              style: regularFont.copyWith(
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

    var storedItems = box.get(dayCounter);
    if (storedItems != null) {
      setState(() {
        items = List<String>.from(storedItems);
      });
    }
  }
}
