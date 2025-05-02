import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/app.dart';
import '../controllers/auth_controller.dart';
import '../screens/login_screen.dart';
import '../screens/update_profile_screen.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromProfileScreen});
  final bool? fromProfileScreen;

  @override
  State<TMAppBar> createState() => _TMAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TMAppBarState extends State<TMAppBar> {
  @override
  Widget build(BuildContext context) {
    final bool? fromProfileScreen = widget.fromProfileScreen;
    return AppBar(
      title: GestureDetector(
        onTap: () {
          if (fromProfileScreen ?? false) {
            return;
          }
          _onTapProfileSection();
        },
        child: Row(
          spacing: 10,
          children: [
            CircleAvatar(
              backgroundImage:
                  _shouldShowImage(AuthController.userModel?.photo)
                      ? MemoryImage(
                        base64Decode(AuthController.userModel?.photo ?? ''),
                      )
                      : null,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthController.userModel?.fullName ?? '',
                    style: TextTheme.of(
                      context,
                    ).bodyLarge?.copyWith(color: Colors.white),
                  ),
                  Text(
                    AuthController.userModel!.email!,
                    style: TextTheme.of(
                      context,
                    ).bodySmall?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _onTapLogoutButton(),
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }

  void updateData() {
    setState(() {});
  }

  bool _shouldShowImage(String? photo) {
    return photo != null && photo.isNotEmpty;
  }

  void _onTapProfileSection() {
    Get.to(UpdateProfileScreen(updateData: updateData));
  }

  Future<void> _onTapLogoutButton() async {
    await AuthController.clearUserData();
    Get.offAll(LoginScreen());
  }
}
