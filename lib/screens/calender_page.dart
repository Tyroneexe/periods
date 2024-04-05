import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
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
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

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
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Day 1',
                  style: semiBold.copyWith(
                    color: const Color(
                      0xFF10275A,
                    ),
                    fontSize: 22,
                  ),
                ),
                Text(
                  'Switch Day',
                  style: medium.copyWith(
                    color: const Color(
                      0xFFA4A4A6,
                    ),
                    fontSize: 11,
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
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length, // The number of items in the list
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(items[index],
                        style: TextStyle(
                            fontSize: 18)), // Display each item in a container
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _searchBar() {
    return TextFormField(
      controller: searchController,
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

  void _loadItems() {
    var box = Hive.box('userSettings');
    var storedItems = box.get(1);
    if (storedItems != null) {
      setState(() {
        items = List<String>.from(storedItems);
      });
    }
  }
}
