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

  // await Hive.box('userSettings').clear();

  //Open storage and check if user is logged in
  var box = Hive.box('userSettings');
  String? loadedUsername = box.get('username');
  bool isLoggedIn = loadedUsername != null;

  printEntireHiveBox();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

//! Remove
void printEntireHiveBox() {
  final box = Hive.box('userSettings');

  for (var key in box.keys) {
    var value = box.get(key);
    // ignore: avoid_print
    print('Key: $key, Value: $value');
  }
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
