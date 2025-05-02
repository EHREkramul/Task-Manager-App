import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/forgot_pass_verify_email_controller.dart';
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
                GetBuilder<ForgotPassVerifyEmailController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.verifyEmailInProgress == false,
                      replacement: CenteredCircularProgressBar(),
                      child: ElevatedButton(
                        onPressed: _onTapSubmitButton,
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                          size: 21.12,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 35),
                BottomTexts(
                  directionText: 'Have account?',
                  buttonText: 'Sign in',
                  onClick: () => Get.back(),
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
    final bool isVerified = await Get.find<ForgotPassVerifyEmailController>()
        .verifyEmail(_emailTEController.text.trim());

    if (isVerified) {
      Get.to(ForgetPassPinVerificationScreen(email: _emailTEController.text));
    } else {
      showSnackBarMessage(
        Get.find<ForgotPassVerifyEmailController>().errorMessage!,
        true,
      );
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();

    super.dispose();
  }
}
