
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart';
import 'profile_screen.dart';
import 'history_screen.dart';

class MainScreen extends StatelessWidget {
  final _selectedIndex = 0.obs;

  final List<Widget> _pages = [
    HomePage(),
    ProfileScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: _pages[_selectedIndex.value], // Reactive body
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex.value,
            onTap: (index) {
              if (index >= 0 && index < _pages.length) {
                _selectedIndex.value = index; // Update index reactively
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
            ],
          ),
        ));
  }
}
