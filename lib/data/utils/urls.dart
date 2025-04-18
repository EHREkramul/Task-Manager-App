class Urls {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';

  static const String registerUrl = '$_baseUrl/Registration';
  static const String loginUrl = '$_baseUrl/Login';
  static const String updateProfileUrl = '$_baseUrl/ProfileUpdate';
  static const String profileDetailsUrl = '$_baseUrl/ProfileDetails';
  static const String addNewTaskUrl = '$_baseUrl/createTask';
  static const String taskStatusCountUrl = '$_baseUrl/taskStatusCount';

  static const String newTaskUrl = '$_baseUrl/listTaskByStatus/New';
  static const String completedTaskUrl = '$_baseUrl/listTaskByStatus/Completed';
  static const String canceledTaskUrl = '$_baseUrl/listTaskByStatus/Canceled';
  static const String progressTaskUrl = '$_baseUrl/listTaskByStatus/Progress';

  static String deleteTaskUrl(String taskId) => '$_baseUrl/deleteTask/$taskId';
  static String verifyEmailUrl(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';
  static String verifyOtpUrl(String email, String pin) =>
      '$_baseUrl/RecoverVerifyOtp/$email/$pin';
  static String updateTaskStatusUrl(String taskId, String newStatus) =>
      '$_baseUrl/updateTaskStatus/$taskId/$newStatus';
  static const String resetPasswordUrl = '$_baseUrl/RecoverResetPassword';
}
