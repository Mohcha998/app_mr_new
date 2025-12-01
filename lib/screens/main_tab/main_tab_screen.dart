import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../home/home_screen.dart';
import '../gift/gift_screen.dart';
import '../account/account_screen.dart';
import 'bottom_navbar.dart';

class MainTabScreen extends StatefulWidget {
  final User user;

  const MainTabScreen({super.key, required this.user});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(user: widget.user),
      GiftScreen(user: widget.user),
      AccountScreen(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: MainTabBottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
