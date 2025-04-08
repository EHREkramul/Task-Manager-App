import 'package:flutter/material.dart';
import 'package:taskmanager/presentation/screens/forgot_pass_verify_email_screen.dart';
import 'package:taskmanager/presentation/screens/sign_up_screen.dart';

import '../widgets/screen_background.dart';
import '../widgets/bottom_texts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
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
                Text(
                  'Get Started With',
                  style: TextTheme.of(context).headlineLarge,
                ),
                TextFormField(
                  controller: _emailTEController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: _passwordTEController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                    size: 21.12,
                  ),
                ),
                SizedBox(height: 25),
                Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _onTapForgotPasswordButton,
                      child: Text(
                        'Forget Password ?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    BottomTexts(
                      directionText: 'Don\'t have account?',
                      buttonText: 'Sign Up',
                      onClick: _onTapSignUpButton,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapForgotPasswordButton() => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ForgotPassVerifyEmailScreen()),
  );

  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();

    super.dispose();
  }
}
