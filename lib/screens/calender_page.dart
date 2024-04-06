import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:periods/main.dart';
import 'package:periods/screens/home_page.dart';
import 'package:periods/themes/colors.dart';
import 'package:periods/themes/text_styles.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DatePickerController dateController = DatePickerController();
  TextEditingController searchController = TextEditingController();
  TextEditingController changeDayController = TextEditingController();

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
              height: 50,
            ),
            _searchBar(),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Periods',
              style: bold.copyWith(
                color: const Color(
                  0xFF10275A,
                ),
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DatePicker(
              DateTime.now(),
              controller: dateController,
              height: 90,
              selectionColor: primaryClr,
              dateTextStyle: medium.copyWith(fontSize: 16),
              initialSelectedDate: DateTime.now(),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Day $dayCounter',
                  style: semiBold.copyWith(
                    color: const Color(
                      0xFF10275A,
                    ),
                    fontSize: 22,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setUserDefinedDay(context);
                  },
                  child: Text(
                    'Switch Day',
                    style: medium.copyWith(
                      color: const Color(
                        0xFFA4A4A6,
                      ),
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Color(
                0xFFA4A4A6,
              ),
              thickness: 1,
            ),
            _periodList(),
          ],
        ),
      ),
    );
  }

  Future<void> setUserDefinedDay(BuildContext context) async {
    var box = Hive.box('userSettings');
    int? newDay = await promptUserForDay(context);

    if (newDay != null) {
      await box.put('Day', newDay);
      await box.put('lastUpdated', DateTime.now());
    }
  }

  Future<int?> promptUserForDay(BuildContext context) async {
    int? selectedDay;
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Set Current Day',
            style: semiBold.copyWith(
              fontSize: 24,
            ),
          ),
          content: TextField(
            controller: changeDayController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter day number",
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
            onChanged: (value) {
              selectedDay = int.tryParse(value);
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: medium,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'OK',
                style: bold.copyWith(
                  fontSize: 14,
                  color: primaryClr,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(selectedDay);
              },
            ),
          ],
        );
      },
    );
  }

  _periodList() {
    var filteredItems = items
        .where((item) =>
            item.toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();

    return Expanded(
      child: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          Color backgroundColor;
          switch (index % 3) {
            case 0:
              backgroundColor = primaryClr;
              break;
            case 1:
              backgroundColor = accentClr;
              break;
            case 2:
            default:
              backgroundColor = secondaryClr;
              break;
          }

          String periodSuffix(int number) {
            int tens = number % 100;
            if (tens >= 11 && tens <= 13) {
              return 'th';
            }
            switch (number % 10) {
              case 1:
                return 'st';
              case 2:
                return 'nd';
              case 3:
                return 'rd';
              default:
                return 'th';
            }
          }

          return Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(
                  0xFFF9FAFD,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Container(
                      width: 3,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(
                          3,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filteredItems[index].toUpperCase(),
                        style: medium.copyWith(
                          fontSize: 16,
                          color: const Color(
                            0xFF2C406E,
                          ),
                        ),
                      ),
                      Text(
                        "${index + 1}${periodSuffix(index + 1)} Period",
                        style: regularFont.copyWith(
                          fontSize: 14,
                          color: const Color(
                            0xFF9AA8C7,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      //
                    },
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _searchBar() {
    return TextFormField(
      controller: searchController,
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(
          0xFFF6F6F6,
        ),
        prefixIcon: Icon(
          IconlyLight.search,
          color: primaryClr.withOpacity(0.5),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            searchController.text = '';
          },
          child: Icon(
            IconlyBold.close_square,
            color: primaryClr.withOpacity(0.5),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
            14,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
            14,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
            14,
          ),
        ),
        hintText: "Search for a period",
        hintStyle: regularFont.copyWith(
          fontSize: 14,
          color: const Color(
            0xFFCED0E7,
          ),
        ),
      ),
    );
  }
}
