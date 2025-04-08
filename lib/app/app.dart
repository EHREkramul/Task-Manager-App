import 'package:flutter/material.dart';
import 'package:taskmanager/presentation/screens/add_new_task_screen.dart';
import 'package:taskmanager/presentation/screens/profile_screen.dart';

import '../presentation/screens/sign_up_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/set_password_screen.dart';
import '../presentation/screens/forget_pass_pin_verification_screen.dart';
import '../presentation/screens/forgot_pass_verify_email_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 33, 191, 115),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 33, 191, 115),
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Colors.grey),
          hintStyle: TextStyle(color: Colors.grey),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            backgroundColor: Color.fromARGB(255, 33, 191, 115),
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 46, 55, 79),
          ),
          bodyMedium: TextStyle(color: Colors.grey),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color.fromARGB(255, 33, 191, 115),
            padding: EdgeInsets.zero,
            minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
      title: 'Task Manager',
      home: SplashScreen(),
    );
  }
}
