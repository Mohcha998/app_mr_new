import 'package:flutter/material.dart';
import '../../models/personality_model.dart';
import '../../services/personality_service.dart';
import '../birdtest_result/birdtest_result_screen.dart';
import '../../session/user_session.dart';
import '../birdtest/birdtest_screen.dart';
import 'widgets/personality_card.dart';

class PersonalityPage extends StatefulWidget {
  const PersonalityPage({super.key});

  @override
  State<PersonalityPage> createState() => _PersonalityPageState();
}

class _PersonalityPageState extends State<PersonalityPage> {
  final PersonalityService service = PersonalityService();
  late final String email;

  final List<PersonalityTrait> traits = [
    PersonalityTrait(
      title: "Bird Test",
      description:
          "Tes ini merupakan salah satu alat penilaian diri yang dirancang "
          "untuk meningkatkan kesadaran diri dan pemahaman diri.",
      icon: "assets/icon/box_icon.png",
    ),
  ];

  @override
  void initState() {
    super.initState();
    email = UserSession.email;
  }

  Future<void> goToPage(String title) async {
    if (title != "Bird Test") return;

    // ✅ VALIDASI EMAIL
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Session login tidak ditemukan, silakan login ulang"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final isBirdtest = await service.getBirdtestStatus(email);

      if (!mounted) return;

      if (isBirdtest == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BirdtestResultScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BirdtestPage()),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        // ✅ BACK BUTTON "<"
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 32),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          "Personality Test",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: traits.length,
          itemBuilder: (context, index) {
            return PersonalityCard(
              trait: traits[index],
              onTap: () => goToPage(traits[index].title),
            );
          },
        ),
      ),
    );
  }
}
