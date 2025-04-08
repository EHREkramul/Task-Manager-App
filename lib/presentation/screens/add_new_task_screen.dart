import 'package:flutter/material.dart';
import '../widgets/screen_background.dart';

class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({super.key});

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
              Text('Add New Task', style: TextTheme.of(context).headlineLarge),
              TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Subject'),
              ),
              TextFormField(
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                ),
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
