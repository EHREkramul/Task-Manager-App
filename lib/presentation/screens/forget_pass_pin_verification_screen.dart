import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.only(left: 51.3, right: 51.3),
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
              ),
              ElevatedButton(
                onPressed: _onTapVerifyButton,
                child: Text('Verify'),
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
    );
  }

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  void _onTapVerifyButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SetPasswordScreen()),
    );
  }

  @override
  void dispose() {
    _pinCodeTEController.dispose();

    super.dispose();
  }
}
