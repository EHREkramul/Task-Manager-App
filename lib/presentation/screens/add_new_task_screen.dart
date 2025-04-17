import 'package:flutter/material.dart';

import '../../app/app.dart';
import '../../data/service/network_client.dart';
import '../../data/service/network_response.dart';
import '../../data/utils/urls.dart';
import '../utils/snack_bar_message.dart';
import '../widgets/centered_circular_progress_bar.dart';
import '../widgets/screen_background.dart';
import '../widgets/tm_app_bar.dart';
import 'home_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.only(left: 51.3, right: 51.3),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  Text(
                    'Add New Task',
                    style: TextTheme.of(context).headlineLarge,
                  ),
                  TextFormField(
                    controller: _subjectTEController,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'Subject'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Subject can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      alignLabelWithHint: true,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? false) {
                        return 'Description can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  Visibility(
                    visible: _addNewTaskInProgress == false,
                    replacement: CenteredCircularProgressBar(),
                    child: ElevatedButton(
                      onPressed: () => _onTapSubmitButton(context),
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

  void _onTapSubmitButton(context) {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    setState(() {
      _addNewTaskInProgress = true;
    });

    Map<String, dynamic> requestBody = {
      "title": _subjectTEController.text,
      "description": _descriptionTEController.text,
      "status": "New",
    };

    setState(() {
      _addNewTaskInProgress = true;
    });

    final NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.addNewTaskUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      _subjectTEController.clear();
      _descriptionTEController.clear();
      showSnackBarMessage('New task added');
      Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    } else {
      showSnackBarMessage(response.errorMessage!, true);
    }
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
