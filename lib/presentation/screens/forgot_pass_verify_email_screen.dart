import 'package:flutter/material.dart';

import '../../app/app.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/centered_circular_progress_bar.dart';
import 'forget_pass_pin_verification_screen.dart';
import '../widgets/screen_background.dart';
import '../widgets/bottom_texts.dart';

class ForgotPassVerifyEmailScreen extends StatefulWidget {
  const ForgotPassVerifyEmailScreen({super.key});

  @override
  State<ForgotPassVerifyEmailScreen> createState() =>
      _ForgotPassVerifyEmailScreenState();
}

class _ForgotPassVerifyEmailScreenState
    extends State<ForgotPassVerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _verifyEmailInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.only(left: 51.3, right: 51.3),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Email Address',
                  style: TextTheme.of(context).headlineLarge,
                ),
                Text(
                  'A 6 digit verification pin will send to your email address',
                  style: TextTheme.of(context).bodyMedium,
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    String email = value?.trim() ?? '';

                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(email);

                    if (!emailValid) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                Visibility(
                  visible: _verifyEmailInProgress == false,
                  replacement: CenteredCircularProgressBar(),
                  child: ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.white,
                      size: 21.12,
                    ),
                  ),
                ),
                SizedBox(height: 35),
                BottomTexts(
                  directionText: 'Have account?',
                  buttonText: 'Sign in',
                  onClick: () => Navigator.pop(context),
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
      _verifyEmail();
    }
  }

  Future<void> _verifyEmail() async {
    setState(() {
      _verifyEmailInProgress = true;
    });

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.verifyEmailUrl(_emailTEController.text),
    );

    if (response.isSuccess) {
      Navigator.push(
        TaskManagerApp.navigatorKey.currentContext!,
        MaterialPageRoute(
          builder:
              (context) => ForgetPassPinVerificationScreen(
                email: _emailTEController.text,
              ),
        ),
      );
    }else{
      showSnackBarMessage(response.errorMessage!, true);
    }

    setState(() {
      _verifyEmailInProgress = false;
    });
  }

  @override
  void dispose() {
    _emailTEController.dispose();

    super.dispose();
  }
}
