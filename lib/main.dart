import 'package:apptimizm/screens/task_first.dart';
import 'package:apptimizm/screens/task_third.dart';
import 'package:apptimizm/screens/task_second.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavigationDemo(),
    );
  }
}

class BottomNavigationDemo extends StatefulWidget {
  @override
  _BottomNavigationDemoState createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    TaskFirstPage(title: "Задание 1"),
    TaskSecondPage(title: "Задание 2"),
    TaskThirdPage(title: "Задание 3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            label: 'Задание 1',
            icon: Container(),
          ),
          BottomNavigationBarItem(
            label: 'Задание 2',
            icon: Container(),
          ),
          BottomNavigationBarItem(
            label: 'Задание 3',
            icon: Container(),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

