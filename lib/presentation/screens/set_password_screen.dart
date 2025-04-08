import 'package:flutter/material.dart';

import '../widgets/screen_background.dart';
import '../widgets/bottom_texts.dart';
import 'login_screen.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPassTEController =
      TextEditingController();

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
                    style: TextTheme.of(context).bodyMedium,
                  ),
                ],
              ),
              TextFormField(
                controller: _passwordTEController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              TextFormField(
                controller: _confirmPassTEController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(labelText: 'Confirm Password'),
              ),
              ElevatedButton(
                onPressed: _onTapSubmitButton,
                child: Text('Confirm'),
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
    );
  }

  void _onTapSubmitButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
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
