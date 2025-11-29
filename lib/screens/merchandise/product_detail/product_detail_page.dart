import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/merchandise_item.dart';
import '../../../services/merchandise_service.dart';

class ProductDetailPage extends StatefulWidget {
  final int id;

  const ProductDetailPage({super.key, required this.id});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  MerchandiseItem? item;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadDetail();
  }

  Future<void> loadDetail() async {
    final service = MerchandiseService();
    final result = await service.getById(widget.id);

    setState(() {
      item = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (item == null) {
      return const Scaffold(body: Center(child: Text("Product not found")));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(item!.judul),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // IMAGE WITH SHADOW
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item!.gambar,
                  height: 320,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // DESCRIPTION
            Text(
              item!.deskripsi,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),

            const SizedBox(height: 40),

            // BUY BUTTON
            SizedBox(
              width: 180,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final url = Uri.parse(item!.redirectLink);

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                child: const Text(
                  "BUY",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
