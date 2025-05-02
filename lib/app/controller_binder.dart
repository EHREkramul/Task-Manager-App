import 'package:get/get.dart';

import '../presentation/controllers/login_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
