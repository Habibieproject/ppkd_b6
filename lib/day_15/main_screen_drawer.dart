import 'package:flutter/material.dart';
import 'package:ppkd_b6/day_13/splash_screen.dart';
import 'package:ppkd_b6/day_15/input_widget.dart';
import 'package:ppkd_b6/utils/app_drawer.dart';

class MainScreenDrawerDay15 extends StatefulWidget {
  const MainScreenDrawerDay15({super.key});

  @override
  State<MainScreenDrawerDay15> createState() => _MainScreenDrawerDay15State();
}

class _MainScreenDrawerDay15State extends State<MainScreenDrawerDay15> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    InputWidgetDay15(),
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
      // appBar: ,
      drawer: AppDrawer(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
      endDrawer: const Drawer(),
      appBar: AppBar(title: const Text('Drawer')),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Business',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.amber[800],
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
