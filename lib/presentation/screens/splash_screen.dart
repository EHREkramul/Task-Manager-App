import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import '../utils/assets_paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isLoggedIn = await AuthController.checkIfUserLoggedIn();

    Get.off(() => isLoggedIn ? const HomeScreen() : const LoginScreen());
  }

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            AssetsPath.backgroundSVG,
            fit: BoxFit.fill,
            height: double.maxFinite,
          ),
          Center(child: SvgPicture.asset(AssetsPath.logoSVG)),
        ],
      ),
    );
  }
}
