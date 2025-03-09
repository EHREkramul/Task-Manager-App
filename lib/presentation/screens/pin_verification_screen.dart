import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../widgets/screen_background.dart';
import '../widgets/bottom_texts.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
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
                    'A 6 digit verification pin will send to your email address',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              PinCodeTextField(
                appContext: context,
                keyboardType: TextInputType.number,
                length: 6, // 6-digit OTP
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  activeColor: Colors.blueAccent, // Border color when typing
                  inactiveColor: Colors.grey, // Default border color
                ),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
              ),
              ElevatedButton(onPressed: () {}, child: Text('Verify')),
              SizedBox(height: 20),
              BottomTexts(
                directionText: 'Have account?',
                buttonText: 'Sign in',
                onClick: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
