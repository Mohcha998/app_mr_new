import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/quote_model.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({super.key});

  @override
  State<EditImagePage> createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  final List<String> _assetImages = [
    "assets/images/1.jpg",
    "assets/images/6.jpg",
    "assets/images/7.jpg",
    "assets/images/9.jpg",
    "assets/images/10.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
    "assets/images/4.jpg",
    "assets/images/5.jpg",
    "assets/images/8.jpg",
  ];

  File? _pickedImage;
  String? _selectedAsset;
  bool _isPreview = false;

  final ImagePicker _picker = ImagePicker();

  Quote? quote; // ✅ Model Quote dari API atau JSON

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Ambil argumen dari Navigator.pushNamed()
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && quote == null) {
      // Jika args adalah Map (misal dikirim dari Navigator)
      if (args is Map<String, dynamic>) {
        final quoteData = args['quote'];

        // ✅ Cek apakah sudah dalam bentuk Quote
        if (quoteData is Quote) {
          quote = quoteData;
        }
        // ✅ Jika masih Map, ubah jadi Quote
        else if (quoteData is Map<String, dynamic>) {
          quote = Quote.fromJson(quoteData);
        }
        // ✅ Jika bukan keduanya, tampilkan warning di log
        else {
          debugPrint("⚠️ Invalid quote data type: ${quoteData.runtimeType}");
        }
      }
      // Jika args dikirim langsung sebagai Quote (bukan Map)
      else if (args is Quote) {
        quote = args;
      } else {
        debugPrint("⚠️ Unexpected args type: ${args.runtimeType}");
      }
    }
  }

  Future<void> _pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
        _selectedAsset = null;
        _isPreview = true;
      });
    }
  }

  Widget _buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      padding: const EdgeInsets.all(8),
      children: [
        // Pilih dari gallery
        GestureDetector(
          onTap: _pickFromGallery,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: const Center(
              child: Icon(Icons.photo_library, size: 40, color: Colors.black54),
            ),
          ),
        ),

        // Pilih dari aset lokal
        for (final asset in _assetImages)
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedAsset = asset;
                _pickedImage = null;
                _isPreview = true;
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(asset, fit: BoxFit.cover),
            ),
          ),
      ],
    );
  }

  Widget _buildPreview() {
    final imageWidget = _pickedImage != null
        ? Image.file(_pickedImage!, fit: BoxFit.cover)
        : (_selectedAsset != null
              ? Image.asset(_selectedAsset!, fit: BoxFit.cover)
              : const SizedBox());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ✅ Preview gambar
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: AspectRatio(aspectRatio: 3 / 4, child: imageWidget),
        ),

        // ✅ Tombol Choose Image
        ElevatedButton(
          onPressed: () {
            final imagePath = _pickedImage?.path ?? _selectedAsset;

            if (imagePath != null && quote != null) {
              Navigator.pushReplacementNamed(
                context,
                '/quote_editor_page',
                arguments: {
                  'imagePath': imagePath,
                  'quote': quote!.text, // ✅ Kirim objek Quote
                },
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please select an image first.")),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text("Choose Image", style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 16),

        // ✅ Tombol Cancel
        TextButton(
          onPressed: () {
            setState(() {
              _isPreview = false;
              _pickedImage = null;
              _selectedAsset = null;
            });
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasQuote = quote != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Choose Image"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: hasQuote
          ? AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isPreview ? _buildPreview() : _buildGridView(),
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Loading quote..."),
                ],
              ),
            ),
    );
  }
}
