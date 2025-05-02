import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/centered_circular_progress_bar.dart';
import 'forgot_pass_verify_email_screen.dart';
import 'home_screen.dart';
import 'sign_up_screen.dart';
import '../utils/assets_paths.dart';
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
  bool _passwordObscure = true;
  String _iconName = AssetsPath.openEyePNG;
  final LoginController _loginController = Get.find<LoginController>();

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
                  controller: _passwordTEController,
                  keyboardType: TextInputType.visiblePassword,
                  obscuringCharacter: '*',
                  obscureText: _passwordObscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordObscure = !_passwordObscure;
                          _iconName =
                              _passwordObscure
                                  ? AssetsPath.openEyePNG
                                  : AssetsPath.hideEyePNG;
                        });
                      },
                      icon: ImageIcon(AssetImage(_iconName), size: 25.0),
                    ),
                  ),
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
                GetBuilder<LoginController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.loginInProgress == false,
                      replacement: CenteredCircularProgressBar(),
                      child: ElevatedButton(
                        onPressed: _onTapLoginButton,
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                          size: 21.12,
                        ),
                      ),
                    );
                  },
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

  void _onTapForgotPasswordButton() {
    Get.to(ForgotPassVerifyEmailScreen());
  }

  void _onTapSignUpButton() {
    Get.to(SignUpScreen());
  }

  void _onTapLoginButton() {
    if (_formKey.currentState!.validate()) {
      _loginUser();
    }
  }

  void _clearTEControllers() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  Future<void> _loginUser() async {
    final bool isSuccess = await _loginController.loginUser(
      _emailTEController.text.trim(),
      _passwordTEController.text,
    );
    if (isSuccess) {
      _clearTEControllers();
      Get.offAll(HomeScreen());
    } else {
      showSnackBarMessage(_loginController.errorMessage!, true);
    }
  }
}
