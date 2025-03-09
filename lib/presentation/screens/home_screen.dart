import 'package:flutter/material.dart';

import '../widgets/home_card.dart';
import '../widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color.fromARGB(255, 33, 191, 115),
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 30),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(color: Colors.black),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_rounded),
            label: 'New Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_rounded),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_rounded),
            label: 'Canceled',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_rounded),
            label: 'Progress',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          spacing: 10,
          children: [
            Row(
              children: [
                HomeCard(count: '09', status: 'Canceled'),
                HomeCard(count: '10', status: 'Completed'),
                HomeCard(count: '12', status: 'Progress'),
                HomeCard(count: '02', status: 'New Task'),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder:
                    (context, index) => TaskItem(
                      index: index,
                      status: 'Completed',
                      title: 'Lorem Ipsum is simply dummy',
                      date: DateTime.now(),
                      description:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
