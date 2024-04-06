import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:periods/main.dart';
import 'package:periods/screens/home_page.dart';
import 'package:periods/themes/colors.dart';
import 'package:periods/themes/text_styles.dart';

class OnGoingPage extends StatefulWidget {
  const OnGoingPage({super.key});

  @override
  State<OnGoingPage> createState() => _OnGoingPageState();
}

class _OnGoingPageState extends State<OnGoingPage> {
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
                    'On Going Periods',
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
              'Today: Day $dayCounter',
              style: semiBold.copyWith(
                fontSize: 24,
                color: const Color(
                  0xFF12175E,
                ),
              ),
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
}
