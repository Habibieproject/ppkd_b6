import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:ppkd_b6/day_13/splash_screen.dart';
import 'package:ppkd_b6/day_14/home_screen.dart';

class MainScreen2Day15 extends StatefulWidget {
  const MainScreen2Day15({super.key});

  @override
  State<MainScreen2Day15> createState() => _MainScreen2Day15State();
}

class _MainScreen2Day15State extends State<MainScreen2Day15> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        // hideNavigationBar: true,
        // handleAndroidBackButtonPress: true,
        // gestureNavigationEnabled: true,
        tabs: [
          PersistentTabConfig(
            screen: HomeScreenDay14(),
            item: ItemConfig(icon: Icon(Icons.home), title: "Home"),
          ),
          PersistentTabConfig(
            screen: HomeScreenDay14(),
            item: ItemConfig(
              icon: Icon(Icons.qr_code),
              title: "QRIS",
              inactiveForegroundColor: Colors.black,
              activeColorSecondary: Colors.black,
              activeForegroundColor: Colors.blue,
              inactiveBackgroundColor: Colors.white,
            ),
          ),
          PersistentTabConfig(
            screen: SplashScreenDay13(),
            item: ItemConfig(icon: Icon(Icons.settings), title: "Settings"),
          ),
        ],
        navBarBuilder: (navBarConfig) =>
            Style13BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
