import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'jw_player_view.dart';

class ConnectWithMerryPage extends StatefulWidget {
  const ConnectWithMerryPage({super.key});

  @override
  State<ConnectWithMerryPage> createState() => _ConnectWithMerryPageState();
}

class _ConnectWithMerryPageState extends State<ConnectWithMerryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
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
                    const Opacity(
                      opacity: 0,
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // IMAGE HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/img_head.png",
                    height: 260,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // SOCIAL MEDIA TITLE
              const Center(
                child: Text(
                  "Merry Riana on Social media",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(height: 15),

              const SocialMediaRow(),

              const SizedBox(height: 30),

              // BODY CONTENT
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: const [
                    SizedBox(height: 10),

                    SectionText(
                      "Merry Riana adalah seorang Entrepreneur, Investor, "
                      "Content Creator, dan Staf Khusus Menteri Koordinator "
                      "Bidang Infrastruktur dan Pembangunan Kewilayahan.",
                    ),

                    SizedBox(height: 20),
                    ProfileImage("assets/images/putih.png"),
                    SizedBox(height: 15),

                    SectionText(
                      "Merry Riana telah membuktikan bahwa mimpi besar bisa "
                      "diwujudkan lewat tekad dan kerja keras. Di usia 26 tahun, "
                      "Merry Riana meraih pendapatan 1 juta dolar, sebuah pencapaian "
                      "fenomenal yang diabadikan menjadi film biografi terlaris di "
                      "tahun 2015 dan menginspirasi jutaan orang.",
                    ),

                    SizedBox(height: 25),
                    ProfileImage("assets/images/chelsea.jpeg"),
                    SizedBox(height: 15),

                    SectionText(
                      "Melalui Merry Riana Group, ia membangun ekosistem edukasi yang "
                      "berdampak luas. Di bawah kepemimpinannya, PT Merry Riana Edukasi "
                      "Tbk berhasil menjadi perusahaan edukasi pertama yang melantai di Bursa Efek Indonesia. "
                      "Perusahaan ini menaungi berbagai program pengembangan diri serta puluhan Merry Riana Learning "
                      "Centre yang tersebar di seluruh Indonesia, dan telah membantu transformasi ribuan anak dan remaja",
                    ),

                    SizedBox(height: 25),
                    ProfileImage("assets/images/bawah.png"),
                    SizedBox(height: 15),

                    ReadMoreLink(),

                    SizedBox(height: 25),

                    SectionText(
                      "Sebagai Content Creator, Merry Riana juga membagikan inspirasi dan motivasi "
                      "setiap harinya kepada jutaan subscribers dan followers beliau.",
                    ),

                    SizedBox(height: 20),

                    SectionText(
                      "Sebagai bentuk dedikasinya untuk Indonesia, selain sebagai Duta Kesehatan "
                      "Kementerian Kesehatan RI dan Duta Sahabat Perempuan dan Anak Kementerian PPPA, "
                      "Merry Riana ditunjuk sebagai Staf Khusus Menteri Koordinator Bidang Infrastruktur "
                      "dan Pembangunan Kewilayahan",
                    ),

                    SizedBox(height: 20),

                    SectionText(
                      "Saat ini, Merry Riana fokus Menciptakan Dampak Positif dari Indonesia untuk Dunia. "
                      "Seperti yang disampaikan oleh Presiden RI ke-6, 'Indonesia butuh anak muda inspiratif seperti Merry Riana.'",
                    ),

                    SizedBox(height: 40),
                  ],
                ),
              ),

              // JWPLAYER VIDEO
              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: const JWPlayerView(videoId: '8jpQWGQS-vbU1wr9k'),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////
// SOCIAL MEDIA ROW
//////////////////////////////////////////////////////////////////////

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
            child: Center(
              child: SocialMediaIcon(
                icon: FontAwesomeIcons.instagram,
                url: "https://www.instagram.com/merryriana/",
                color: Color(0xFFE1306C),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SocialMediaIcon(
                icon: FontAwesomeIcons.facebookF,
                url: "https://www.facebook.com/merryriana",
                color: Color(0xFF1877F2),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SocialMediaIcon(
                icon: FontAwesomeIcons.tiktok,
                url: "https://www.tiktok.com/@merryriana",
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SocialMediaIcon(
                icon: FontAwesomeIcons.youtube,
                url: "https://www.youtube.com/Merryriana",
                color: Color(0xFFFF0000),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SocialMediaIcon(
                icon: FontAwesomeIcons.xTwitter,
                url: "https://twitter.com/MerryRiana",
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SocialMediaIcon(
                icon: FontAwesomeIcons.spotify,
                url:
                    "https://open.spotify.com/artist/67bYHBRT3EDL8o0EiiosOj?si=ZbDZWXteTf6ekzj6VtdW6w",
                color: Color(0xFF1DB954),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SocialMediaIcon(
                icon: FontAwesomeIcons.linkedinIn,
                url:
                    "https://www.linkedin.com/in/merry-riana/?originalSubdomain=id",
                color: Color(0xFF0A66C2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////
// SOCIAL MEDIA ICON
//////////////////////////////////////////////////////////////////////

class SocialMediaIcon extends StatelessWidget {
  final IconData icon;
  final String url;
  final Color color;

  const SocialMediaIcon({
    super.key,
    required this.icon,
    required this.url,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      child: FaIcon(icon, size: 32, color: color),
    );
  }
}

//////////////////////////////////////////////////////////////////////
// TEXT
//////////////////////////////////////////////////////////////////////

class SectionText extends StatelessWidget {
  final String text;
  const SectionText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, height: 1.45),
      textAlign: TextAlign.justify,
    );
  }
}

//////////////////////////////////////////////////////////////////////
// PROFILE IMAGE
//////////////////////////////////////////////////////////////////////

class ProfileImage extends StatelessWidget {
  final String path;
  const ProfileImage(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(path, width: double.infinity, fit: BoxFit.cover),
    );
  }
}

//////////////////////////////////////////////////////////////////////
// READ MORE
//////////////////////////////////////////////////////////////////////

class ReadMoreLink extends StatelessWidget {
  const ReadMoreLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {},
        child: const Text(
          "Read More >>",
          style: TextStyle(
            fontSize: 15,
            color: Colors.blue,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
