import 'package:flutter/material.dart';
import 'package:periods/drawer/drawer.dart';
import 'package:periods/themes/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const NavitionDrawer(),
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Todays Calender',
              style: bold.copyWith(fontSize: 38),
            ),
          ),
        ],
      ),
    );
  }
}
