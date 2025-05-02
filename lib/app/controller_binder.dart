import 'package:get/get.dart';

import '../presentation/controllers/login_controller.dart';
import '../presentation/controllers/new_task_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(NewTaskController());
  }
}
