import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:periods/navbar/navbar.dart';
import 'package:periods/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive Storage Initialization
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox('userSettings');

  //Open storage and check if user is logged in
  var box = Hive.box('userSettings');
  String? loadedUsername = box.get('username');
  bool isLoggedIn = loadedUsername != null;

  updateDayCounter();
  totalDays = countCalendarDays();

  printEntireHiveBox();

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'periods',
        channelName: 'Periods',
        channelDescription: 'Check Periods',
      )
    ],
    debug: true,
  );

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

int? dayCounter = 1;
int? totalDays;

//! Remove
void printEntireHiveBox() {
  final box = Hive.box('userSettings');

  for (var key in box.keys) {
    var value = box.get(key);
    // ignore: avoid_print
    print('Key: $key, Value: $value');
  }
}

Future<void> updateDayCounter() async {
  var box = Hive.box('userSettings');
  DateTime now = DateTime.now();
  DateTime startOfToday = DateTime(now.year, now.month, now.day);

  // Check if 'lastUpdated' exists
  var lastUpdatedValue = box.get('lastUpdated');
  DateTime lastUpdated;

  if (lastUpdatedValue == null) {
    lastUpdated = startOfToday.subtract(const Duration(days: 1));
    await box.put('lastUpdated', lastUpdated);
  } else {
    lastUpdated = DateTime.parse(lastUpdatedValue.toString());
  }

  if (startOfToday.difference(lastUpdated).inDays != 0) {
    dayCounter = box.get('Day') as int? ?? 1;
    dayCounter ??= (dayCounter ?? 1) % 6 + 1;
    await box.put('Day', dayCounter);
    await box.put('lastUpdated', startOfToday);
  }

  Timer.periodic(
    const Duration(minutes: 1),
    (Timer t) async {
      DateTime newNow = DateTime.now();
      DateTime lastDateCheck =
          box.get('lastUpdated', defaultValue: DateTime.now()) as DateTime;

      if (newNow.difference(lastDateCheck).inDays != 0) {
        dayCounter = ((box.get('Day', defaultValue: 1) as int) % 6) + 1;

        await box.put('Day', dayCounter);
        await box.put(
            'lastUpdated', DateTime(newNow.year, newNow.month, newNow.day));
      }
    },
  );
}

int countCalendarDays() {
  final box = Hive.box('userSettings');
  int dayCount = 0;

  for (var key in box.keys) {
    if (int.tryParse(key.toString()) != null) {
      dayCount++;
    }
  }

  return dayCount;
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Periods',
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const NavBar() : const SplashScreen(),
    );
  }
}
