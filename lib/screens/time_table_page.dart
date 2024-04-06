import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:periods/main.dart';
import 'package:periods/themes/colors.dart';
import 'package:periods/themes/text_styles.dart';

class MyTimeTable extends StatefulWidget {
  const MyTimeTable({super.key});

  @override
  State<MyTimeTable> createState() => _MyTimeTableState();
}

class _MyTimeTableState extends State<MyTimeTable>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<String> itemsTable = [];
  int _currentIndex = 0; // Add this line

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: totalDays, vsync: this);
    _loadData();

    _tabController!.addListener(() {
      if (!_tabController!.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController!.index;
          _loadData();
        });
      }
    });
  }

  void _loadData() {
    var box = Hive.box('userSettings');
    var storedItems = box.get(_currentIndex + 1);
    if (storedItems != null) {
      setState(() {
        itemsTable = List<String>.from(storedItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs =
        List.generate(totalDays, (index) => Tab(text: "${index + 1}"));

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Time Table'),
        bottom: TabBar(
          indicatorColor: primaryClr,
          labelColor: primaryClr,
          unselectedLabelColor: const Color(0xFFC8CDD9),
          controller: _tabController,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(totalDays, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                _periodList(),
              ],
            ),
          );
        }),
      ),
    );
  }

  _periodList() {
    return Expanded(
      child: ListView.builder(
        itemCount: itemsTable.length,
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
              top: 10,
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
                        (itemsTable[index]).toUpperCase(),
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
}
