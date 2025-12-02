import 'package:flutter/material.dart';
// import '../home/widgets/bottom_navbar.dart';
import '../../session/user_session.dart';
import '../../models/user_model.dart';

class AccountScreen extends StatelessWidget {
  final User user;

  const AccountScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Ambil data dari session
    final String name = UserSession.name;
    final String email = UserSession.email;
    final String phone = "+62${UserSession.phone}";

    return Scaffold(
      // bottomNavigationBar: BottomNavbar(
      //   currentIndex: 2,
      //   user: user, // <-- FIX: wajib kirim user
      // ),
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "My Account",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // PROFILE CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.red.shade700,
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),

                // USER DATA FROM SESSION
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.isNotEmpty ? name : "Unknown User",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      email.isNotEmpty ? email : "No email",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phone != "+62" ? phone : "No phone",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // MENU LIST
          _menuItem(Icons.lock_reset_rounded, "Change Password", () {
            Navigator.pushNamed(context, '/change-password');
          }),
          _menuItem(Icons.info_outline_rounded, "About App", () {}),
          _menuItem(Icons.support_agent_rounded, "Support", () {}),
          _menuItem(Icons.logout, "Logout", () {
            UserSession.clear();
            Navigator.pushReplacementNamed(context, '/login');
          }),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Icon(icon, size: 26, color: Colors.red.shade700),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
