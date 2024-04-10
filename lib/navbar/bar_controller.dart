import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:periods/main.dart';
import 'package:periods/screens/home_page.dart';

class NavBarController extends GetxController {
  var tabIndex = 0;

  get theme => null;
  void changeTabIndex(int index) {
    tabIndex = index;
    // _loadData();
    update();
  }

  void _loadData() {
    var box = Hive.box('userSettings');

    var storedItems = box.get(dayCounter);
    if (storedItems != null) {
      dayCounter = box.get('Day') as int;
      items = List<String>.from(storedItems);
    }
  }
}
