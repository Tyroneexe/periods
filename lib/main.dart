import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:periods/screens/login_page.dart';
import 'package:periods/screens/home_page.dart';

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

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Periods',
      debugShowCheckedModeBanner: false,
      home: isLoggedIn
          ? const HomePage()
          : const LogInPage(), // Conditional initial route
    );
  }
}
