import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromProfileScreen});

  final bool? fromProfileScreen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          if (fromProfileScreen ?? false) {
            return;
          }
          _onTapProfileSection(context);
        },
        child: Row(
          spacing: 10,
          children: [
            CircleAvatar(child: Icon(Icons.account_circle, size: 40)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ekramul Haque',
                    style: TextTheme.of(
                      context,
                    ).bodyLarge?.copyWith(color: Colors.white),
                  ),
                  Text(
                    'ehr.ekramul@gmail.com',
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
          onPressed: () => _onTapLogoutButton(context),
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }

  void _onTapProfileSection(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
    );
  }

  void _onTapLogoutButton(context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
