import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final Function(String) onTap;

  const BottomNavigation({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: 'Back'),
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Account',
        ),
      ],
      onTap: (index) {
        if (index == 0) onTap('back');
        if (index == 1) onTap('home');
        if (index == 2) onTap('user');
      },
    );
  }
}
