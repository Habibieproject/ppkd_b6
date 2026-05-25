import 'package:flutter/material.dart';
import 'package:ppkd_b6/day_15/input_widget.dart';
import 'package:ppkd_b6/day_16/views/list.dart';
import 'package:ppkd_b6/day_16/views/list_with_model.dart';
import 'package:ppkd_b6/day_16/views/map.dart';
import 'package:ppkd_b6/utils/app_drawer.dart';

class MainScreenDrawerDay15 extends StatefulWidget {
  const MainScreenDrawerDay15({
    super.key,
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
  @override
  State<MainScreenDrawerDay15> createState() => _MainScreenDrawerDay15State();
}

class _MainScreenDrawerDay15State extends State<MainScreenDrawerDay15> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    InputWidgetDay15(),
    ListDataDay16(),
    MapDataDay16(),
    ListWithModelDataDay16(),
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
      endDrawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(widget.email), Text(widget.password)],
        ),
      ),
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
