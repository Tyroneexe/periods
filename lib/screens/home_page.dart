import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:periods/themes/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String? username;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Hello, $username',
              style: bold.copyWith(fontSize: 38),
            ),
          ),
        ],
      ),
    );
  }

  void _loadData() {
    var box = Hive.box('userSettings');
    String? loadedUsername = box.get('username');

    setState(() {
      username = loadedUsername;
    });
  }
}
