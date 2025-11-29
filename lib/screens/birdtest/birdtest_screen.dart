import 'package:flutter/material.dart';

class BirdtestPage extends StatelessWidget {
  const BirdtestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Bird Test",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),

        // ✅ BACK "<"
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 32),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      // ================= BODY =================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Pengertian Bird Test",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Tes ini merupakan salah satu alat penilaian diri yang dirancang "
                    "untuk meningkatkan kesadaran diri dan pemahaman diri, dan hasilnya, "
                    "akan memberikan berbagai wawasan yang berguna, yang dapat digunakan "
                    "untuk membantu pertumbuhan pribadi dan professional.",
                    style: TextStyle(height: 1.6, color: Colors.black),
                  ),

                  SizedBox(height: 24),

                  Text(
                    "Cara melakukan Bird Test",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12),

                  Text(
                    "Tidak ada batas waktu untuk menjawab pertanyaan-pertanyaan ini, "
                    "tapi Anda mungkin dapat menyelesaikannya dalam waktu sekitar "
                    "sepuluh menit.",
                    style: TextStyle(height: 1.6, color: Colors.black),
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Tidak ada jawaban yang benar ataupun salah. Jika Anda lebih setuju "
                    "daripada tidak setuju dengan sebuah pernyataan, atau jika Anda "
                    "merasa bahwa pernyataan itu menggambarkan Anda dengan cukup baik "
                    "maka Anda cukup memilih pernyataan itu.",
                    style: TextStyle(height: 1.6, color: Colors.black),
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Jika Anda lebih tidak setuju daripada setuju dengan pernyataan tersebut, "
                    "atau jika Anda merasa bahwa pernyataan itu tidak menggambarkan diri Anda, "
                    "maka lanjutkan ke pernyataan berikutnya.",
                    style: TextStyle(height: 1.6, color: Colors.black),
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Jangan berpikir terlalu lama dan tidak perlu menganalisa terlalu detail "
                    "untuk setiap pernyataan.",
                    style: TextStyle(height: 1.6, color: Colors.black),
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Pilihan Anda harus diberikan ke paling sedikit 24 pernyataan dan "
                    "paling banyak 36 pernyataan.",
                    style: TextStyle(height: 1.6, color: Colors.black),
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Sebagai panduan untuk menjawab tes, fokuskanlah diri Anda terhadap "
                    "lingkungan atau skenario tertentu.",
                    style: TextStyle(height: 1.6, color: Colors.black),
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Kadang-kadang dunia memaksa kita untuk menjadi orang yang berbeda "
                    "pada saat yang berbeda.",
                    style: TextStyle(height: 1.6, color: Colors.black),
                  ),
                  SizedBox(height: 10),

                  Text(
                    "Jujurlah pada diri sendiri. Jangan memilih jawaban yang Anda pikir "
                    "HARUS, AKAN, atau BISA.",
                    style: TextStyle(height: 1.6, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ================= BUTTON =================
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/birdtest-test");
            },
            child: const Text(
              "Ambil Test",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
