import 'package:flutter/material.dart';
import 'package:ppkd_b6/day_13/splash_screen.dart';
import 'package:ppkd_b6/day_14/home_screen.dart';

class MainScreenDay15 extends StatefulWidget {
  const MainScreenDay15({super.key});

  @override
  State<MainScreenDay15> createState() => _MainScreenDay15State();
}

class _MainScreenDay15State extends State<MainScreenDay15> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreenDay14(),
    Text('Index 1: Business'),
    SplashScreenDay13(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('BottomNavigationBar Sample')),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
