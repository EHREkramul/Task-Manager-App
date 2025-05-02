import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/centered_circular_progress_bar.dart';
import 'login_screen.dart';
import '../widgets/screen_background.dart';
import '../widgets/bottom_texts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignUpController signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.only(left: 51.3, right: 51.3),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    Text(
                      'Join With Us',
                      style: TextTheme.of(context).headlineLarge,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      textInputAction: TextInputAction.next,
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
                    TextFormField(
                      controller: _firstNameTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: 'First Name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        String firstName = value?.trim() ?? '';
                        if (firstName.isEmpty) {
                          return 'First name is required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lastNameTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: 'Last Name'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        String lastName = value?.trim() ?? '';
                        if (lastName.isEmpty) {
                          return 'Last name is required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _mobileTEController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: 'Mobile'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        String phone = value?.trim() ?? '';

                        final bool phoneValid = RegExp(
                          r"^(?:\+?88)?01[13-9]\d{8}$",
                        ).hasMatch(phone);

                        if (!phoneValid) {
                          return 'Enter a valid phone';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(labelText: 'Password'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        String pass = value ?? '';

                        /*final bool passValid = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                        ).hasMatch(pass);*/

                        if (pass.isEmpty || pass.length < 6) {
                          return 'Password length must be 6 or more';
                        }
                        return null;
                      },
                    ),
                    GetBuilder<SignUpController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller.registrationInProgress == false,
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
                    SizedBox(height: 20),
                    BottomTexts(
                      directionText: 'Already have an account?',
                      buttonText: 'Sign In',
                      onClick: _onTapSignInButton,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    Get.offAll(LoginScreen(), predicate: (route) => route.isCurrent);
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _registerUser();
    }
  }

  void _clearTEControllers() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  Future<void> _registerUser() async {
    final bool isSuccess = await signUpController.registerUser(
      _emailTEController.text,
      _firstNameTEController.text,
      _lastNameTEController.text,
      _mobileTEController.text,
      _passwordTEController.text,
    );
    if (isSuccess) {
      showSnackBarMessage('User Registered Successfully');
      _clearTEControllers();
      Get.offAll(LoginScreen());
    } else {
      showSnackBarMessage(signUpController.errorMessage!, true);
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();

    super.dispose();
  }
}
