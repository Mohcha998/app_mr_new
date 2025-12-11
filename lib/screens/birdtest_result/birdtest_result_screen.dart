import 'package:flutter/material.dart';
import '../../services/birdtest_result_service.dart';
import '../../session/user_session.dart';
import 'widgets/error_card.dart';
import 'widgets/loading_card.dart';
import 'widgets/result_card.dart';

class BirdtestResultScreen extends StatefulWidget {
  const BirdtestResultScreen({super.key});

  @override
  State<BirdtestResultScreen> createState() => _BirdtestResultScreenState();
}

class _BirdtestResultScreenState extends State<BirdtestResultScreen> {
  bool isLoading = false;
  String errorMessage = '';
  Map<String, dynamic>? result;
  String nama = '';

  final BirdtestResultService _service = BirdtestResultService();

  @override
  void initState() {
    super.initState();
    if (UserSession.name.isNotEmpty) {
      nama = UserSession.name;
    }
    fetchTestResult();
  }

  void fetchTestResult() async {
    final email = UserSession.email;
    if (email.isEmpty) {
      setState(() => errorMessage = 'Email tidak ditemukan.');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
      result = null;
    });

    try {
      final response = await _service.getTestResult(email);

      if (response == null ||
          response['status'] != true ||
          response['data'] == null) {
        setState(() {
          errorMessage = 'Data tidak ditemukan.';
          isLoading = false;
        });
        return;
      }

      final data = response['data'];
      final scores = {
        'peacock': int.tryParse(data['peacock'].toString()) ?? 0,
        'dove': int.tryParse(data['dove'].toString()) ?? 0,
        'owl': int.tryParse(data['owl'].toString()) ?? 0,
        'eagle': int.tryParse(data['eagle'].toString()) ?? 0,
      };

      // Hitung hasil tertinggi
      var sortedBirds = scores.entries.where((e) => e.value > 0).toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      var highestBirds = [sortedBirds[0].key];
      int highestScore = sortedBirds[0].value;
      if (sortedBirds.length > 1 && sortedBirds[1].value == highestScore) {
        highestBirds.add(sortedBirds[1].key);
      }

      String? extremeType = highestScore > 10
          ? 'Extreme ${highestBirds[0]}'
          : null;

      final birdIcons = {
        'peacock': "assets/icon/P.png",
        'dove': "assets/icon/D.png",
        'owl': "assets/icon/O.png",
        'eagle': "assets/icon/E.png",
      };

      final combinationIcons = {
        "peacock-dove": "assets/icon/PD.png",
        "peacock-owl": "assets/icon/PO.png",
        "peacock-eagle": "assets/icon/PE.png",
        "dove-owl": "assets/icon/DO.png",
        "dove-eagle": "assets/icon/ED.png",
        "owl-eagle": "assets/icon/EO.png",
      };

      final extremeIcons = {
        "Extreme peacock": "assets/icon/P.png",
        "Extreme dove": "assets/icon/D.png",
        "Extreme owl": "assets/icon/O.png",
        "Extreme eagle": "assets/icon/E.png",
      };

      final birdDetails = {
        'peacock': {
          'strength':
              "Anda antusias, ambisius, dramatis, ramah dan mudah menstimulasi.",
          'weakness':
              "Anda dapat menjadi terlalu bersemangat, tampak seperti orang yang manipulatif, agak egois dan terkadang tidak disiplin.",
        },
        'dove': {
          'strength':
              "Dove adalah tipe yang mendukung penuh penghargaan, dapat diandalkan, mudah setuju dan berkemauan untuk melakukan apa yang diperlukan agar pekerjaan berjalan dengan baik.",
          'weakness':
              "Dove adalah tipe yang cenderung untuk patuh, dapat menjadi ragu-ragu, terkadang terlalu tergantung pada orang lain, memiliki kecenderungan kecanggungan, dan terkadang mudah dipengaruhi oleh lingkungan yang memiliki pengaruh lebih kuat.",
        },
        'owl': {
          'strength':
              "Anda rajin, teratur, sangat teliti, gigih dan biasanya sangat serius.",
          'weakness':
              "Anda dapat menjadi terlalu kritis, umumnya ragu - ragu, kadang - kadang kaku, terlalu pemilih, dan kadang - kadang dapat menekan.",
        },
        'eagle': {
          'strength':
              "Anda berkemauan keras, mandiri, praktis, tegas dan efisien.",
          'weakness':
              "Anda kadang - kadang terlalu mendominasi, tangguh, memaksa dan kasar.",
        },
      };

      String icon = '';
      String description = '';
      String strength = '';
      String weakness = '';

      if (extremeType != null) {
        description = extremeType;
        icon = extremeIcons[extremeType]!;
        strength = birdDetails[highestBirds[0]]!['strength']!;
        weakness = birdDetails[highestBirds[0]]!['weakness']!;
      } else {
        String key = highestBirds.join('-');
        if (combinationIcons.containsKey(key)) {
          icon = combinationIcons[key]!;
        } else {
          icon = birdIcons[highestBirds[0]]!;
        }
        description = key;
        strength = birdDetails[highestBirds[0]]!['strength']!;
        weakness = birdDetails[highestBirds[0]]!['weakness']!;
      }

      setState(() {
        result = {
          'description': description,
          'strength': strength,
          'weakness': weakness,
          'icon': icon,
        };
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Gagal memuat data.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text('Bird Test'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (isLoading) const LoadingCard(),
            if (errorMessage.isNotEmpty) ErrorCard(message: errorMessage),
            if (result != null) ResultCard(result: result!, nama: nama),
          ],
        ),
      ),
    );
  }
}
