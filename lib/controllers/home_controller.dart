import 'package:get/get.dart';

class HomeController extends GetxController {
  int _navigatorValue = 0;

  get navigatorValue => _navigatorValue;

  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    update();
  }
}
