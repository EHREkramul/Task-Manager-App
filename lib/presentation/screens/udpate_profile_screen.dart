import 'package:flutter/material.dart';
import 'package:taskmanager/presentation/widgets/tm_app_bar.dart';

import '../widgets/screen_background.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(fromProfileScreen: true),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.only(left: 51.3, right: 51.3),
          child: SingleChildScrollView(
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 90),
                Text(
                  'Update Profile',
                  style: TextTheme.of(context).headlineLarge,
                ),
                photoPickerWidget(),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'ehr.ekramul@gmail.com',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    hintText: 'Ekramul',
                  ),
                  keyboardType: TextInputType.name,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    hintText: 'Haque',
                  ),
                  keyboardType: TextInputType.name,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                    hintText: '01772317392',
                  ),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'ehr123#',
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
                ElevatedButton(
                  onPressed: _onTapSubmitButton,
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
      ),
    );
  }

  Widget photoPickerWidget() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            Container(
              height: 55,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text('Photo', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 8),
            Text('Select Your Photo'),
          ],
        ),
      ),
    );
  }

  void _onTapPhotoPicker() {}

  void _onTapSubmitButton() {}
}
