import 'package:flutter/material.dart';
import 'package:periods/themes/text_styles.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'data',
            style: bold.copyWith(
              fontSize: 38,
            ),
          ),
        ],
      ),
    );
  }
}
