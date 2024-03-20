import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:periods/navbar/navbar.dart';
import 'package:periods/themes/colors.dart';
import 'package:periods/themes/text_styles.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController nameController = TextEditingController();
  String? typeSchool;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 120,
              ),
              Text(
                'Login',
                style: semiBold.copyWith(
                  fontSize: 36,
                  color: primaryClr,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              TextFormField(
                controller: nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    IconlyLight.profile,
                    size: 24,
                    color: greyClr,
                  ),
                  hintText: 'What would you like to be called?',
                  labelText: 'Name or User Name',
                  labelStyle: regularFont.copyWith(
                    color: const Color(
                      0xFFC6CEDD,
                    ),
                  ),
                  hintStyle: regularFont.copyWith(
                    color: const Color(
                      0xFFC6CEDD,
                    ),
                  ),
                  focusColor: primaryClr,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: primaryClr,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                      6,
                    ),
                  ),
                ),
                validator: (String? value) {
                  return value!.contains(' ') ? 'Do not use a space' : null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<String>(
                value: typeSchool,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    IconlyLight.home,
                    size: 24,
                    color: greyClr,
                  ),
                  hintText: 'Your Type of School',
                  labelText: 'Type of School',
                  labelStyle: regularFont.copyWith(
                    color: const Color(0xFFC6CEDD),
                  ),
                  hintStyle: regularFont.copyWith(
                    color: const Color(0xFFC6CEDD),
                  ),
                  focusColor: primaryClr,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: primaryClr, width: 2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    typeSchool = value;
                  });
                },
                validator: (value) {
                  return value == null ? 'Please select an option' : null;
                },
                items: <String>['Middle School', 'High School']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                icon: const Icon(
                  IconlyBold.arrow_down_2,
                  color: greyClr,
                  size: 24,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              TextButton(
                onPressed: () {
                  if (nameController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "Missing Information",
                            style: semiBold,
                          ),
                          content: Text(
                            "Please fill in fields",
                            style: regularFont,
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                "OK",
                                style: bold.copyWith(
                                  color: primaryClr,
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    _saveData(nameController.text);
                    Get.to(() => const NavBar());
                  }
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
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveData(String username) async {
    var box = Hive.box('userSettings');
    await box.put('username', username);
  }
}
