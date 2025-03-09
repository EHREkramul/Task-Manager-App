import 'package:flutter/material.dart';

import '../widgets/screen_background.dart';
import '../widgets/bottom_texts.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
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
                    'Set Password',
                    style: TextTheme.of(context).headlineLarge,
                  ),
                  Text(
                    'Minimum length password 8 character with Latter and number combination',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(labelText: 'Confirm Password'),
              ),
              ElevatedButton(onPressed: () {}, child: Text('Confirm')),
              SizedBox(height: 25),
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
