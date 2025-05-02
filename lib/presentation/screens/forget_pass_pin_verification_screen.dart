import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/forgot_pass_pin_verification_controller.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/centered_circular_progress_bar.dart';
import 'login_screen.dart';
import 'set_password_screen.dart';
import '../widgets/screen_background.dart';
import '../widgets/bottom_texts.dart';

class ForgetPassPinVerificationScreen extends StatefulWidget {
  const ForgetPassPinVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<ForgetPassPinVerificationScreen> createState() =>
      _ForgetPassPinVerificationScreenState();
}

class _ForgetPassPinVerificationScreenState
    extends State<ForgetPassPinVerificationScreen> {
  final TextEditingController _pinCodeTEController = TextEditingController();

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
                      'PIN Verification',
                      style: TextTheme.of(context).headlineLarge,
                    ),
                    Text(
                      'A 6 digit verification pin has been send to your email address',
                      style: TextTheme.of(context).bodyMedium,
                    ),
                  ],
                ),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    activeColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  controller: _pinCodeTEController,
                  appContext: context,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    String pin = value?.trim() ?? '';
                    if (pin.length < 6) {
                      return '';
                    }
                    return null;
                  },
                ),
                GetBuilder<ForgotPassPinVerificationController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.verifyOtpInProgress == false,
                      replacement: CenteredCircularProgressBar(),
                      child: ElevatedButton(
                        onPressed: _onTapVerifyButton,
                        child: Text('Verify'),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
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

  void _onTapSignInButton() {
    Get.offAll(LoginScreen());
  }

  void _onTapVerifyButton() {
    if (_formKey.currentState!.validate()) {
      _verifyOTP();
    } else {
      showSnackBarMessage('Enter 6 digit pin', true);
    }
  }

  Future<void> _verifyOTP() async {
    final bool isVerified =
        await Get.find<ForgotPassPinVerificationController>().verifyOTP(
          widget.email.trim(),
          _pinCodeTEController.text.trim(),
        );

    if (isVerified) {
      Get.to(
        SetPasswordScreen(email: widget.email, otp: _pinCodeTEController.text),
      );
    } else {
      showSnackBarMessage(
        Get.find<ForgotPassPinVerificationController>().errorMessage!,
        true,
      );
    }
  }

  @override
  void dispose() {
    _pinCodeTEController.dispose();

    super.dispose();
  }
}
