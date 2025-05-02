import 'package:get/get.dart';

import '../presentation/controllers/change_task_status_controller.dart';
import '../presentation/controllers/delete_task_controller.dart';
import '../presentation/controllers/forgot_pass_pin_verification_controller.dart';
import '../presentation/controllers/forgot_pass_verify_email_controller.dart';
import '../presentation/controllers/add_new_task_controller.dart';
import '../presentation/controllers/canceled_task_controller.dart';
import '../presentation/controllers/completed_task_controller.dart';
import '../presentation/controllers/login_controller.dart';
import '../presentation/controllers/new_task_controller.dart';
import '../presentation/controllers/progress_task_controller.dart';
import '../presentation/controllers/set_password_controller.dart';
import '../presentation/controllers/sign_up_controller.dart';
import '../presentation/controllers/update_user_profile_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(NewTaskController());
    Get.put(CanceledTaskController());
    Get.put(CompletedTaskController());
    Get.put(ProgressTaskController());
    Get.put(AddNewTaskController());
    Get.put(SignUpController());
    Get.put(ForgotPassVerifyEmailController());
    Get.put(ForgotPassPinVerificationController());
    Get.put(SetPasswordController());
    Get.put(UpdateUserProfileController());
    Get.put(DeleteTaskController());
    Get.put(ChangeTaskStatusController());
  }
}
