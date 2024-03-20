import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:periods/themes/colors.dart';
import 'package:periods/themes/text_styles.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

TextEditingController numPeriodsController = TextEditingController();

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController dayController = TextEditingController();
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
          ],
        ),
      ),
    );
  }
}

class PeriodsDialog extends StatefulWidget {
  const PeriodsDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PeriodsDialogState createState() => _PeriodsDialogState();
}

class _PeriodsDialogState extends State<PeriodsDialog> {
  final List<TextEditingController> _controllers =
      List.generate(8, (i) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Periods'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            for (int i = 0; i < int.parse(numPeriodsController.text); i++)
              TextFormField(
                controller: _controllers[i],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Period ${i + 1}",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final number = int.tryParse(value);
                  if (number == null) {
                    return 'Only numbers are allowed';
                  }
                  return null;
                },
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Submit'),
          onPressed: () {
            // Implement your submission logic here
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
