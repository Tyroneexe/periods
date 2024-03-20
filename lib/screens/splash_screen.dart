import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:periods/screens/login_page.dart';
import 'package:periods/themes/colors.dart';
import 'package:periods/themes/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 52,
              ),
              child: Image.asset(
                "assets/clock.png",
                height: 293,
              ),
            ),
            const SizedBox(
              height: 65,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Periods',
                  style: bold.copyWith(
                    fontSize: 32,
                    color: primaryClr,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  '.',
                  style: bold.copyWith(
                    fontSize: 42,
                    color: secondaryClr,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Get notified about your upcoming periods\nfor the day and much more',
                    style: regularFont,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextButton(
                onPressed: () {
                  Get.to(() => const LogInPage());
                },
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    semiBold.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    primaryClr,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        14,
                      ),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(
                      MediaQuery.of(context).size.width,
                      55,
                    ),
                  ),
                ),
                child: const Text('Get Started'),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

}
