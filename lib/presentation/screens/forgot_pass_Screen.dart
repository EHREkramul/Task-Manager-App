import 'package:flutter/material.dart';

import '../widgets/screen_background.dart';
import '../widgets/bottom_texts.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
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
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              ElevatedButton(
                onPressed: () {},
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
                onClick: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
