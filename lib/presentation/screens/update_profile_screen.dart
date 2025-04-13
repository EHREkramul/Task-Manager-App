import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager/data/models/user_model.dart';
import 'package:taskmanager/presentation/controllers/auth_controller.dart';
import 'package:taskmanager/presentation/widgets/centered_circular_progress_bar.dart';

import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/screen_background.dart';
import '../widgets/tm_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   bool _updateProfileInProgress = false;

  @override
  void initState() {
    UserModel userModel = AuthController.userModel!;
    _emailTEController.text = userModel.email!;
    _firstNameTEController.text = userModel.firstName!;
    _lastNameTEController.text = userModel.lastName!;
    _mobileTEController.text = userModel.mobile!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(fromProfileScreen: true),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.only(left: 51.3, right: 51.3),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    enabled: false,
                    controller: _emailTEController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: InputDecoration(labelText: 'First Name'),
                    keyboardType: TextInputType.name,
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
                    decoration: InputDecoration(labelText: 'Last Name'),
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      String firstName = value?.trim() ?? '';
                      if (firstName.isEmpty) {
                        return 'Last name is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _mobileTEController,
                    decoration: InputDecoration(labelText: 'Mobile'),
                    keyboardType: TextInputType.phone,
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
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    keyboardType: TextInputType.visiblePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      String pass = value ?? '';

                      /*final bool passValid = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                        ).hasMatch(pass);*/

                      if (pass.isNotEmpty && pass.length < 6) {
                        return 'Password length must be 6 or more';
                      }
                      return null;
                    },
                  ),
                  Visibility(
                    visible: _updateProfileInProgress == false,
                    replacement: CenteredCircularProgressBar(),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.white,
                        size: 21.12,
                      ),
                    ),
                  ),
                ],
              ),
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
            Text(_pickedImage?.name ?? 'Select Your Photo'),
          ],
        ),
      ),
    );
  }

  void _onTapPhotoPicker() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _updateUserProfile();
    }
  }

  Future<void> _updateUserProfile() async {
    setState(() {
      _updateProfileInProgress = true;
    });
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };
    if(_passwordTEController.text.isNotEmpty){
      requestBody ['password'] = _passwordTEController.text;
    }
    if(_pickedImage != null){
      List<int> imageBytes = await _pickedImage!.readAsBytes();
      String encodedImage = base64Encode(imageBytes);
      requestBody['photo'] = encodedImage;
    }
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );
    setState(() {
      _updateProfileInProgress = false;
    });
    if (response.isSuccess) {
      // TODO: Update app bar and profile text fields.
      _passwordTEController.clear();
      showSnackBarMessage(context, 'User Info Updated Successfully');
    } else {
      showSnackBarMessage(context, response.errorMessage!, true);
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
