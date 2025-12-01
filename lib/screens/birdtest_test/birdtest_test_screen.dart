import 'package:flutter/material.dart';
import 'widgets/bird_progress.dart';
import 'widgets/question_card.dart';
import 'widgets/navigation_buttons.dart';
import 'widgets/bottom_nav.dart';
import '../birdtest_result/birdtest_result_screen.dart';
import '../../services/birdtest_service.dart';
import '../../session/user_session.dart';

class BirdtestScreen extends StatefulWidget {
  const BirdtestScreen({super.key});

  @override
  State<BirdtestScreen> createState() => _BirdtestScreenState();
}

class _BirdtestScreenState extends State<BirdtestScreen> {
  int currentPage = 0;
  final int questionsPerPage = 5;

  int selectedCount = 0;
  double progress = 0;

  final Map<int, int> answers = {for (int i = 1; i <= 80; i++) i: 0};

  final BirdtestService _service = BirdtestService();

  // Daftar 80 pertanyaan lengkap
  final List<Map<String, dynamic>> questions = [
    {1: 'Saya lebih suka bekerja sendiri daripada bekerja dengan orang lain.'},
    {
      2: 'Ketika saya bersama teman, saya lebih suka membuat lelucon daripada mendengarkan lelucon mereka.',
    },
    {
      3: 'Saya ingin mendapatkan informasi sebanyak mungkin sebelum membuat keputusan.',
    },
    {
      4: 'Saya cenderung tertawa lebih keras dari sebagian besar orang di sekitar saya.',
    },
    {
      5: 'Saya cenderung mengatakan apa yang saya pikirkan walau mungkin menyinggung perasaan orang lain.',
    },
    {
      6: 'Saya bisa digambarkan sebagai pribadi yang percaya diri, hangat banyak bicara dan populer.',
    },
    {
      7: 'Saya selalu mempertimbangkan pendapat orang lain sebelum menyatakan pendapat saya.',
    },
    {8: 'Saya mencermati detail yang ada sebelum menarik kesimpulan.'},
    {
      9: 'Kadang-kadang orang lain bisa merasa kalau saya cenderung suka memberikan perintah.',
    },
    {
      10: 'Teman-teman saya merasa bahwa saya sangat persuasif dan bisa menjual es kepada Eskimo.',
    },
    {
      11: 'Saya bisa digambarkan sebagai pribadi yang punya disiplin diri dan berorientasi pada hasil.',
    },
    {
      12: 'Saya dapat bersikap kritis terhadap orang-orang yang tidak mengambil pendekatan yang logis.',
    },
    {13: 'Saya khawatir ketika saya harus dikejar deadline.'},
    {14: 'Saya lebih suka menyendiri daripada bekerja dengan orang lain.'},
    {15: 'Saya orang yang tenang dan peduli terhadap perasaan orang lain.'},
    {
      16: 'Saya suka bekerja di lingkungan yang dapat di prediksi dan sistematis sehingga tidak merasa terburu-buru.',
    },
    {17: 'Saya pandai membujuk orang untuk melihat dari sudut pandang saya.'},
    {18: 'Saya adalah seseorang yang perfeksionis.'},
    {
      19: 'Memiliki wewenang dan jabatan yang jelas merupakan hal yang penting bagi saya.',
    },
    {
      20: 'Alasan dan logika merupakan hal yang lebih penting dalam jangka panjang daripada emosi.',
    },
    {
      21: 'Saya mengemukakan ide-ide saya dengan kuat bahkan jika orang lain tidak menyukainya.',
    },
    {22: 'Saya bisa digambarkan sebagai seseorang yang stabil dan analitis.'},
    {
      23: 'Saya lebih tertarik pada ide-ide yang menantang dan tidak biasa daripada suatu yang praktis.',
    },
    {24: 'Ketika saya berada didalam kelompok saya lebih banyak berbicara.'},
    {25: 'Saya bisa digambarkan sebagai pribadi yang tenang.'},
    {
      26: 'Orang mungkin melihat saya sebagai pribadi yang dingin dan menarik diri.',
    },
    {27: 'Ketika saya berada dalam sebuah tim, saya ingin menjadi pemimpinnya.'},
    {
      28: 'Saya cenderung untuk menarik diri dari orang-orang yang agresif dan tegas.',
    },
    {
      29: 'Kebanyakan orang melihat saya sangat pengertian dan siap untuk mendengar keluh-kesah mereka.',
    },
    {30: 'Saya cenderung menahan diri untuk mengungkapkan perasaan saya.'},
    {
      31: 'Saya dikenal sebagai pribadi yang hangat, ramah dan pendengar yang baik.',
    },
    {
      32: 'Saya tidak punya masalah dalam mengekspresikan perasaan & pendapat dalam pertemuan atau diskusi.',
    },
    {
      33: 'Saya lebih memilih untuk diam dan mendengarkan daripada lebih banyak berbicara.',
    },
    {
      34: 'Berdiri dan berbicara di depan orang lain merupakan hal yang sangat menyenangkan.',
    },
    {
      35: 'Hasil merupkan hal yang terpenting, terlepas dari bagaimana perasaan orang tentang hal itu.',
    },
    {
      36: 'Saya adalah pendengar yang baik dan bersedia untuk mendengar masalah orang lain.',
    },
    {
      37: 'Saya mengandalkan keputusan saya sendiri daripada pendapat orang lain.',
    },
    {
      38: 'Saya banyak menggunakan tangan dalam berbicara ketika saya merasa senang.',
    },
    {39: 'Saya tidak terlalu percaya diri ketika bertemu dengan orang lain.'},
    {
      40: 'Saya cenderung membesar-besarkan cerita ketika berbicara kepada teman-teman saya.',
    },
    {
      41: 'Saya biasanya bersedia untuk memberikan apa yang orang lain inginkan dari saya.',
    },
    {42: 'Saya cenderung menghindari keputusan yang sulit.'},
    {43: 'Ketika saya marah semua orang dapat mendengar saya.'},
    {
      44: 'Saya cenderung untuk mengendalikan situasi ketika saya berada bersama orang lain.',
    },
    {
      45: 'Saya memiliki reputasi sebagai orang yang berani mencoba sesuatu yang baru.',
    },
    {46: 'Saya cenderung menjadi pengikut daripada pemimpin.'},
    {47: 'Struktur, aturan dan prosedur merupakan hal yang penting bagi saya.'},
    {
      48: 'Saya berkembang dengan pesat pada saat menangani sesuatu yang baru, berbeda dan menantang.',
    },
    {49: 'Saya sangat kompetitif.'},
    {50: 'Saya merupakan pribadi yang membuat keputusan secara cepat.'},
    {
      51: 'Saya bisa digambarkan sebagai pribadi yang tenang, hati-hati, logis dan konservatif.',
    },
    {52: 'Saya cenderung pemalu dan pendiam.'},
    {
      53: 'Saya ingin mencoba hal-hal baru terutama hal-hal yang sangat berisiko.',
    },
    {54: 'Saya yakin pada diri sendiri dalam situasi apapun.'},
    {
      55: 'Saya cenderung takut dalam bertindak dan takut dalam membuat keputusan sendiri.',
    },
    {
      56: 'Saya tidak punya masalah dalam membuat keputusan yang penting dan cepat.',
    },
    {57: 'Saya seorang yang fanatik terhadap detail.'},
    {58: 'Saya ingin menjadi pusat perhatian dalam sebuah kelompok.'},
    {
      59: 'Saat diskusi, saya fokus pada topik utama tanpa membuang waktu walau orang lain tidak menyukainya.',
    },
    {60: 'Saya cenderung menyembunyikan perasaan saya ketika saya tersinggung.'},
    {
      61: 'Saya kurang senang pada orang-orang yang menyepelekan situasi yang serius.',
    },
    {
      62: 'Saya memiliki reputasi sebagai pribadi yang lembut dan mudah bergaul.',
    },
    {
      63: 'Saya adalah pribadi yang rapi dan terorganisir di hampir semua yang saya lakukan.',
    },
    {64: 'Saya selalu bisa menghidupkan suasana dalam sebuah acara.'},
    {65: 'Saya orang yang memegang kontrol, percaya diri, dan berani.'},
    {66: 'Saya cenderung terpengaruh oleh ide-ide dan saran dari orang lain.'},
    {
      67: 'Saya merasa kesal terhadap orang-orang yang membuat saya merasa terburu-buru.',
    },
    {68: 'Saya lebih suka untuk membaca daripada berbicara.'},
    {69: 'Saya lebih suka bekerja keras.'},
    {
      70: 'Perasaan orang lain tidak terlalu penting dibandingkan dengan menyelesaikan pekerjaan tepat waktu.',
    },
    {
      71: 'Saya sangat baik dalam memainkan drama di atas panggung atau di sebuah film.',
    },
    {
      72: 'Saya bisa digambarkan sebagai pribadi yang optimis, antusias, dan asertif.',
    },
    {
      73: 'Kadang-kadang beberapa orang mengatakan saya terlalu blak-blakan dan tidak diplomatik.',
    },
    {
      74: 'Saya suka berdebat tentang hal yang diberitakan di radio atau TV saat ada sesuatu yang tidak saya setujui.',
    },
    {
      75: 'Kadang saya digambarkan oleh beberapa orang sebagai pribadi yang terlalu berhati-hati & konservatif.',
    },
    {
      76: 'Saya bisa dilihat oleh beberapa orang sebagai pribadi yang tidak yakin pada diri sendiri & sedikit lemah.',
    },
    {77: 'Saya suka mengikuti nilai-nilai, tradisi dan praktek yang umum.'},
    {
      78: 'Saya lebih suka berurusan dengan fakta dan angka ketimbang berurusan dengan orang lain.',
    },
    {
      79: 'Kadang-kadang saya dapat dilihat sebagai pribadi yang terlalu ramah dan suka berbicara.',
    },
    {
      80: 'Saya bisa digambarkan sebagai pribadi yang kuat, tegas, teguh dan blak-blakan.',
    },
  ].map((e) => {"id": e.keys.first, "text": e.values.first}).toList();

  List<Map<String, dynamic>> get paginatedQuestions {
    return questions
        .skip(currentPage * questionsPerPage)
        .take(questionsPerPage)
        .toList();
  }

  void selectAnswer(int id) {
    setState(() {
      answers[id] = answers[id] == 1 ? 0 : 1;
      selectedCount = answers.values.where((v) => v == 1).length;
      progress = ((selectedCount / 36) * 100).clamp(0, 100);
    });
  }

  int sum(List<int> keys) => keys.fold(0, (s, k) => s + (answers[k] ?? 0));

  Map<String, int> calculateScore() {
    final peacock =
        sum([
          2,
          4,
          10,
          17,
          23,
          24,
          32,
          34,
          38,
          40,
          43,
          45,
          48,
          58,
          64,
          71,
          74,
          79,
        ]) +
        2 * sum([6, 72]);
    final dove =
        sum([
          7,
          13,
          15,
          16,
          28,
          29,
          31,
          33,
          36,
          39,
          41,
          46,
          52,
          60,
          62,
          66,
          67,
          76,
        ]) +
        2 * sum([25, 55]);
    final owl =
        sum([
          1,
          3,
          8,
          12,
          14,
          18,
          20,
          26,
          30,
          42,
          47,
          57,
          61,
          63,
          68,
          75,
          77,
          78,
        ]) +
        2 * sum([22, 51]);
    final eagle =
        sum([
          5,
          9,
          11,
          19,
          21,
          27,
          35,
          37,
          49,
          50,
          53,
          54,
          56,
          59,
          65,
          69,
          70,
          73,
        ]) +
        2 * sum([44, 80]);
    return {"peacock": peacock, "dove": dove, "owl": owl, "eagle": eagle};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("Bird Test", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BirdProgress(progress: progress),
            const SizedBox(height: 10),
            Text("$selectedCount / 80"),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: paginatedQuestions.map((q) {
                  return QuestionCard(
                    text: q['text'],
                    selected: answers[q['id']] == 1,
                    onTap: () => selectAnswer(q['id']),
                  );
                }).toList(),
              ),
            ),
            NavigationButtons(
              currentPage: currentPage,
              isLastPage:
                  (currentPage + 1) * questionsPerPage >= questions.length,
              onBack: () {
                setState(() {
                  currentPage--;
                });
              },
              onNext: () {
                setState(() {
                  currentPage++;
                });
              },
              onSubmit: () async {
                if (selectedCount < 24 || selectedCount > 36) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        selectedCount < 24
                            ? "Minimal pilih 24 jawaban"
                            : "Maksimal pilih 36 jawaban",
                      ),
                    ),
                  );
                  return;
                }

                final scores = calculateScore();

                try {
                  await _service.submitTest(
                    nama: UserSession.name,
                    email: UserSession.email,
                    phone: UserSession.phone,
                    scores: scores,
                    answers: answers,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Berhasil submit birdtest")),
                  );

                  // Navigasi ke halaman hasil
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BirdtestResultScreen(),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Gagal submit birdtest")),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BirdBottomNav(),
    );
  }
}
