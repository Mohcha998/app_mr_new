import 'package:flutter/material.dart';
// import '../home/widgets/bottom_navbar.dart';
import '../../models/user_model.dart'; // pastikan path benar

class GiftScreen extends StatelessWidget {
  final User user;

  const GiftScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: BottomNavbar(currentIndex: 1, user: user),
      appBar: AppBar(
        title: const Text(
          "Gift",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.card_giftcard_rounded,
              size: 80,
              color: Colors.red.shade700,
            ),
            const SizedBox(height: 20),
            const Text(
              "No Gift Available Yet",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              "Stay tuned for upcoming rewards!",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
