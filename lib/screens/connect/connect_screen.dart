import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectWithMerryPage extends StatelessWidget {
  const ConnectWithMerryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // 🔙 HEADER WITH BACK BUTTON + TITLE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    // BACK BUTTON
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),

                    const Expanded(
                      child: Center(
                        child: Text(
                          "Connect with Merry Riana",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // agar title tetap center (icon invisible)
                    const Opacity(
                      opacity: 0,
                      child: Icon(Icons.arrow_back_ios), // dummy
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // BIG IMAGE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/mr.png",
                    height: 260,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Find Merry on Social Media",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    socialCard(
                      icon: FontAwesomeIcons.instagram,
                      label: "Instagram",
                      color: Colors.pinkAccent,
                      url: "https://www.instagram.com/merryriana/",
                    ),
                    socialCard(
                      icon: FontAwesomeIcons.xTwitter,
                      label: "Twitter",
                      color: Colors.black,
                      url: "https://twitter.com/MerryRiana",
                    ),
                    socialCard(
                      icon: FontAwesomeIcons.tiktok,
                      label: "TikTok",
                      color: Colors.black,
                      url: "https://www.tiktok.com/@merryriana",
                    ),
                    socialCard(
                      icon: FontAwesomeIcons.youtube,
                      label: "YouTube",
                      color: Colors.red,
                      url: "https://www.youtube.com/@MerryRiana",
                    ),
                    socialCard(
                      icon: FontAwesomeIcons.facebook,
                      label: "Facebook",
                      color: Colors.blue,
                      url: "https://www.facebook.com/merryriana",
                    ),
                    socialCard(
                      icon: FontAwesomeIcons.linkedin,
                      label: "LinkedIn",
                      color: Colors.blueAccent,
                      url: "https://www.linkedin.com/in/merryriana/",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // SOCIAL MEDIA CARD
  Widget socialCard({
    required IconData icon,
    required String label,
    required Color color,
    required String url,
  }) {
    return InkWell(
      onTap: () =>
          launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, size: 36, color: color),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
