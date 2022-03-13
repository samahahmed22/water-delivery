import 'package:get/get.dart';

import '../controllers/location_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import './local_storage_helper.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<LocationController>(() => LocationController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<LocalStorageHelper>(() => LocalStorageHelper());
  }
}
