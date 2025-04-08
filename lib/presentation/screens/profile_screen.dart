import 'package:flutter/material.dart';

import '../widgets/screen_background.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 10,
          children: [
            CircleAvatar(child: Icon(Icons.account_circle, size: 40)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ekramul Haque', style: TextStyle(fontSize: 18)),
                Text('ehr.ekramul@gmail.com', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.only(left: 51.3, right: 51.3),
          child: Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update Profile',
                style: TextTheme.of(context).headlineLarge,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                keyboardType: TextInputType.name,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                keyboardType: TextInputType.name,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mobile'),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                keyboardType: TextInputType.visiblePassword,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.white,
                  size: 21.12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
