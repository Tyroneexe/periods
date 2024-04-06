import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:periods/themes/colors.dart';
import 'package:periods/themes/text_styles.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

TextEditingController numPeriodsController = TextEditingController();
TextEditingController dayController = TextEditingController();
List<String> classes = [];

class _AddTaskPageState extends State<AddTaskPage> {
  bool isPersonal = false;
  bool isPrivate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
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
                      'Add Time Table',
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
                height: 20,
              ),
              Text(
                'Day',
                style: medium.copyWith(
                  fontSize: 14,
                  color: const Color(
                    0xFF8A8BB3,
                  ),
                ),
              ),
              TextFormField(
                controller: dayController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusColor: primaryClr,
                  labelText: "Which day do you want to add?",
                  labelStyle: medium.copyWith(
                    color: const Color(
                      0xFF10275A,
                    ),
                  ),
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
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the day';
                  }
                  final number = int.tryParse(value);
                  if (number == null) {
                    return 'Only the number of the day';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Periods',
                style: medium.copyWith(
                  fontSize: 14,
                  color: const Color(
                    0xFF8A8BB3,
                  ),
                ),
              ),
              TextFormField(
                controller: numPeriodsController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusColor: primaryClr,
                  labelText: "How many periods do you have?",
                  labelStyle: medium.copyWith(
                    color: const Color(
                      0xFF10275A,
                    ),
                  ),
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
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the day';
                  }
                  final number = int.tryParse(value);
                  if (number == null) {
                    return 'Only the number of the day';
                  }

                  return null;
                },
                onFieldSubmitted: (String? value) {
                  if (value != null) {
                    showDialog(
                      context: context,
                      builder: (context) => const PeriodsDialog(),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Type',
                style: medium.copyWith(
                  fontSize: 14,
                  color: const Color(
                    0xFF8A8BB3,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: primaryClr,
                          value: isPersonal,
                          onChanged: (bool? value) {
                            setState(() {
                              isPersonal = value!;
                            });
                          },
                        ),
                        Text(
                          'Personal',
                          style: regularFont.copyWith(
                            fontSize: 16,
                            color: const Color(
                              0xFF10275A,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: primaryClr,
                          value: isPrivate,
                          onChanged: (bool? value) {
                            setState(() {
                              isPrivate = value!;
                            });
                          },
                        ),
                        Text(
                          'Private',
                          style: regularFont.copyWith(
                            fontSize: 16,
                            color: const Color(
                              0xFF10275A,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Tags',
                style: medium.copyWith(
                  fontSize: 14,
                  color: const Color(
                    0xFF8A8BB3,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const TagSelect(),
              const SizedBox(
                height: 150,
              ),
              TextButton(
                onPressed: () {
                  if (dayController.text.isEmpty ||
                      numPeriodsController.text.isEmpty) {
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
                    dayController.text = '';
                    numPeriodsController.text = '';
                  }
                },
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    semiBold.copyWith(
                      fontSize: 18,
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
                child: const Text('Create'),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TagSelect extends StatefulWidget {
  const TagSelect({super.key});

  @override
  State<TagSelect> createState() => _TagSelectState();
}

class _TagSelectState extends State<TagSelect> {
  bool isTag1 = false;
  bool isTag2 = false;
  bool isTag3 = false;
  bool isTag4 = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isTag1 = !isTag1;
            });
          },
          child: Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(
                0xFFECEAFF,
              ),
              borderRadius: BorderRadius.circular(22),
              border: isTag1
                  ? Border.all(
                      color: const Color(0xFF8F81FE),
                      width: 2,
                    )
                  : null,
            ),
            child: Center(
              child: Text(
                'School',
                style: regularFont.copyWith(
                  fontSize: 14,
                  color: const Color(
                    0xFF8F81FE,
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isTag2 = !isTag2;
            });
          },
          child: Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(
                0xFFFFEFEB,
              ),
              borderRadius: BorderRadius.circular(22),
              border: isTag2
                  ? Border.all(
                      color: const Color(0xFFF0A58E),
                      width: 2,
                    )
                  : null,
            ),
            child: Center(
              child: Text(
                'Home',
                style: regularFont.copyWith(
                  fontSize: 14,
                  color: const Color(
                    0xFFF0A58E,
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isTag3 = !isTag3;
            });
          },
          child: Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(
                0xFFFFE9ED,
              ),
              borderRadius: BorderRadius.circular(22),
              border: isTag3
                  ? Border.all(
                      color: const Color(0xFFF57C96),
                      width: 2,
                    )
                  : null,
            ),
            child: Center(
              child: Text(
                'Urgent',
                style: regularFont.copyWith(
                  fontSize: 14,
                  color: const Color(
                    0xFFF57C96,
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isTag4 = !isTag4;
            });
          },
          child: Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(
                0xFFD1FEFF,
              ),
              borderRadius: BorderRadius.circular(22),
              border: isTag4
                  ? Border.all(
                      color: const Color(0xFF1EC1C3),
                      width: 2,
                    )
                  : null,
            ),
            child: Center(
              child: Text(
                'Work',
                style: regularFont.copyWith(
                  fontSize: 14,
                  color: const Color(
                    0xFF1EC1C3,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PeriodsDialog extends StatefulWidget {
  const PeriodsDialog({super.key});

  @override
  State<PeriodsDialog> createState() => _PeriodsDialogState();
}

class _PeriodsDialogState extends State<PeriodsDialog> {
  late List<TextEditingController> _controllers;
  late int numPeriods;

  @override
  void initState() {
    super.initState();

    numPeriods = int.parse(numPeriodsController.text);

    numPeriods = numPeriods > 10 ? 10 : numPeriods;

    _controllers = List.generate(numPeriods, (i) => TextEditingController());
  }

  @override
  void dispose() {
    // Dispose of all TextEditingController instances
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Enter Periods',
        style: semiBold.copyWith(
          fontSize: 22,
          color: Colors.black,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            for (int i = 0; i < _controllers.length; i++)
              TextFormField(
                controller: _controllers[i],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: "Period ${i + 1}",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onFieldSubmitted: (String value) {
                  if (value.isNotEmpty) {
                    // Assuming classes is defined elsewhere and accessible.
                    classes.add(_controllers[i].text);
                  }
                },
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Cancel',
            style: medium.copyWith(
              fontSize: 14,
            ),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Submit',
            style: semiBold.copyWith(
              fontSize: 16,
              color: const Color(0xFF10275A),
            ),
          ),
          onPressed: () {
            classes.clear();

            for (var controller in _controllers) {
              String text = controller.text.trim();
              if (text.isNotEmpty) {
                classes.add(text);
              }
            }
            int day = int.parse(dayController.text);
            saveUserPeriods(day, classes);

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Future<void> saveUserPeriods(int day, List<String> periods) async {
    var box = Hive.box('userSettings');
    await box.put(day, periods);
  }
}
