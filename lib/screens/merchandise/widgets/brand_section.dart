import 'package:flutter/material.dart';
import 'brand_item.dart';
import '../../../services/merchandise_service.dart';
import '../category_detail/category_detail_page.dart';

class BrandSection extends StatelessWidget {
  const BrandSection({super.key});

  // =============================
  // OPEN MR SHOP
  // =============================
  Future<void> _openMrs(BuildContext context) async {
    _showLoading(context);

    try {
      final products = await MerchandiseService().getMrsFlat();

      if (!context.mounted) return;
      _closeLoading(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              CategoryDetailPage(title: "MR Shop", products: products),
        ),
      );
    } catch (_) {
      if (!context.mounted) return;
      _closeLoading(context);
      _showError(context);
    }
  }

  // =============================
  // OPEN MANZONE
  // =============================
  Future<void> _openManzone(BuildContext context) async {
    _showLoading(context);

    try {
      final products = await MerchandiseService().getMZFlat();

      if (!context.mounted) return;
      _closeLoading(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              CategoryDetailPage(title: "Manzone", products: products),
        ),
      );
    } catch (_) {
      if (!context.mounted) return;
      _closeLoading(context);
      _showError(context);
    }
  }

  // =============================
  // LOADING DIALOG
  // =============================
  void _showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          const Center(child: CircularProgressIndicator(color: Colors.black)),
    );
  }

  void _closeLoading(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  // =============================
  // ERROR SNACKBAR
  // =============================
  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Gagal memuat data produk"),
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Brands",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),

          Row(
            children: [
              BrandItem.image(
                "assets/images/mrshop.png",
                onTap: () => _openMrs(context),
              ),
              BrandItem.image(
                "assets/images/manzone.png",
                onTap: () => _openManzone(context),
              ),
              const BrandItem.comingSoon(),
            ],
          ),
        ],
      ),
    );
  }
}
