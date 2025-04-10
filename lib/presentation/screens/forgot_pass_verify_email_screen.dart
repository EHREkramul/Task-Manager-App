import 'package:flutter/material.dart';

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
                children: [
                  Text(
                    'Your Email Address',
                    style: TextTheme.of(context).headlineLarge,
                  ),
                  Text(
                    'A 6 digit verification pin will send to your email address',
                    style: TextTheme.of(context).bodyMedium,
                  ),
                ],
              ),
              TextFormField(
                controller: _emailTEController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              ElevatedButton(
                onPressed: _onTapSubmitButton,
                child: Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.white,
                  size: 21.12,
                ),
              ),
              SizedBox(height: 20),
              BottomTexts(
                directionText: 'Have account?',
                buttonText: 'Sign in',
                onClick: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassPinVerificationScreen(),));
  }

  @override
  void dispose() {
    _emailTEController.dispose();

    super.dispose();
  }
}
