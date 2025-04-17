import 'package:flutter/material.dart';
import 'package:taskmanager/app/app.dart';
import 'package:taskmanager/data/service/network_client.dart';
import 'package:taskmanager/data/service/network_response.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/presentation/utils/snack_bar_message.dart';
import 'package:taskmanager/presentation/widgets/centered_circular_progress_bar.dart';

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
  bool _resetPassInProgress = false;

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
                Visibility(
                  visible: _resetPassInProgress == false,
                  replacement: CenteredCircularProgressBar(),
                  child: ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: Text('Confirm'),
                  ),
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
    setState(() {
      _resetPassInProgress = true;
    });

    Map<String, dynamic> requestBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _confirmPassTEController.text,
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.resetPasswordUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      showSnackBarMessage('Password reset successfully');

      Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    } else {
      showSnackBarMessage(response.errorMessage!, true);
    }

    setState(() {
      _resetPassInProgress = false;
    });
  }

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPassTEController.dispose();

    super.dispose();
  }
}
