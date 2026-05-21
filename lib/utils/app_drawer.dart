import 'package:flutter/material.dart';
import 'package:ppkd_b6/extension/navigator.dart';

class AppDrawer extends StatelessWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;

  const AppDrawer({
    super.key,
    required this.onItemTapped,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          AppDrawerTile(
            title: "Input Widget",
            isSelected: selectedIndex == 0,
            onTap: () {
              onItemTapped(0);
              context.pop();
            },
          ),
          AppDrawerTile(
            title: "Business",
            isSelected: selectedIndex == 1,
            onTap: () {
              onItemTapped(1);
              context.pop();
            },
          ),
          AppDrawerTile(
            title: "Profile",
            isSelected: selectedIndex == 2,
            onTap: () {
              onItemTapped(2);
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}

class AppDrawerTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const AppDrawerTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.blue : Colors.black,
        ),
      ),
      selected: isSelected,
      onTap: onTap,
    );
  }
}
