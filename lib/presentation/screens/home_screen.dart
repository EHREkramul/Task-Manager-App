import 'package:flutter/material.dart';

import '../screens/canceled_task_screen.dart';
import '../screens/completed_task_screen.dart';
import '../screens/new_task_screen.dart';
import '../screens/progress_task_screen.dart';
import '../widgets/tm_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        backgroundColor: Colors.white,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.sticky_note_2_outlined),
            label: 'New Task',
          ),
          NavigationDestination(icon: Icon(Icons.done_all), label: 'Completed'),
          NavigationDestination(
            icon: Icon(Icons.free_cancellation),
            label: 'Canceled',
          ),
          NavigationDestination(
            icon: Icon(Icons.downloading),
            label: 'Progress',
          ),
        ],
      ),
      body: _screens[_selectedIndex],
    );
  }
}
