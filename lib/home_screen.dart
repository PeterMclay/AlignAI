import 'package:align_ai/main.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:camera/camera.dart';

import 'main_screen.dart';
import 'workouts.dart';

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  HomeScreen(this.cameras);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    MainScreen(cameras),
    WorkOutPage(),
    Image.asset('images/construction.PNG'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //fixedColor: Colors.white,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(LineAwesomeIcons.universal_access),
            label: 'Align',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(LineAwesomeIcons.burn),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(LineAwesomeIcons.user),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Color(0xFFFE7C7C),
        iconSize: 36.0,
        elevation: 0.0,
        onTap: _onItemTapped,
      ),
    );
  }
}
