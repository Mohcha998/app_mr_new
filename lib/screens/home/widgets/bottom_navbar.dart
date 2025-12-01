import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../home/home_screen.dart';
import '../../gift/gift_screen.dart';
import '../../account/account_screen.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final User user;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.user,
  });

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(user: user)),
        );
        break;

      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => GiftScreen(user: user)),
        );
        break;

      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => AccountScreen(user: user)),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (i) => _onTap(context, i),
      selectedItemColor: Colors.red,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: "Gift"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
      ],
    );
  }
}
