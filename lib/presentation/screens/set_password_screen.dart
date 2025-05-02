import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/set_password_controller.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/centered_circular_progress_bar.dart';
import '../widgets/screen_background.dart';
import '../widgets/bottom_texts.dart';
import 'login_screen.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key, required this.email, required this.otp});
  final String email;
  final String otp;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPassTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.only(left: 51.3, right: 51.3),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Set Password',
                      style: TextTheme.of(context).headlineLarge,
                    ),
                    Text(
                      'Minimum length password 8 character with Latter and number combination',
                      style: TextTheme.of(context).bodyMedium,
                    ),
                  ],
                ),
                TextFormField(
                  controller: _passwordTEController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(labelText: 'Password'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    String pass = value ?? '';
                    if (pass.length < 6) {
                      return 'Password must be 6 digit long';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPassTEController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    String cPass = value ?? '';
                    if (cPass.length < 6) {
                      return 'Password must be 6 digit long';
                    } else if (cPass != _passwordTEController.text) {
                      return 'Confirm Password did not matched';
                    }
                    return null;
                  },
                ),
                GetBuilder<SetPasswordController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.resetPassInProgress == false,
                      replacement: CenteredCircularProgressBar(),
                      child: ElevatedButton(
                        onPressed: _onTapSubmitButton,
                        child: Text('Confirm'),
                      ),
                    );
                  },
                ),
                SizedBox(height: 25),
                BottomTexts(
                  directionText: 'Have account?',
                  buttonText: 'Sign in',
                  onClick: _onTapSignInButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _resetPassword();
    }
  }

  Future<void> _resetPassword() async {
    final bool isResetSuccess = await Get.find<SetPasswordController>()
        .resetPassword(
          widget.email,
          widget.otp,
          _confirmPassTEController.text.trim(),
        );

    if (isResetSuccess) {
      showSnackBarMessage('Password reset successfully');

      Get.offAll(LoginScreen());
    } else {
      showSnackBarMessage(
        Get.find<SetPasswordController>().errorMessage!,
        true,
      );
    }
  }

  void _onTapSignInButton() {
    Get.offAll(LoginScreen());
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPassTEController.dispose();

    super.dispose();
  }
}
