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

  Quote? quote;

  // =============================
  // GET ARGUMENT
  // =============================
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && quote == null) {
      if (args is Map<String, dynamic>) {
        final quoteData = args['quote'];

        if (quoteData is Quote) {
          quote = quoteData;
        } else if (quoteData is Map<String, dynamic>) {
          quote = Quote.fromJson(quoteData);
        } else {
          debugPrint("⚠️ Invalid quote data type: ${quoteData.runtimeType}");
        }
      } else if (args is Quote) {
        quote = args;
      }
    }
  }

  // =============================
  // PICK IMAGE FROM GALLERY
  // =============================
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

  // =============================
  // GRID VIEW
  // =============================
  Widget _buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      padding: const EdgeInsets.all(8),
      children: [
        // Pick from gallery
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

        // Assets image
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

  // =============================
  // PREVIEW IMAGE
  // =============================
  Widget _buildPreview() {
    final imageWidget = _pickedImage != null
        ? Image.file(_pickedImage!, fit: BoxFit.cover)
        : Image.asset(_selectedAsset!, fit: BoxFit.cover);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image Preview
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

        // ✅ Choose Image → Editor
        ElevatedButton(
          onPressed: () async {
            final imagePath = _pickedImage?.path ?? _selectedAsset;

            if (imagePath != null && quote != null) {
              await Navigator.pushNamed(
                context,
                '/quote_editor_page',
                arguments: {'imagePath': imagePath, 'quote': quote!.text},
              );

              // ✅ Saat kembali dari editor
              setState(() {
                _isPreview = true;
              });
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

        // ✅ Cancel → back to grid
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

  // =============================
  // BUILD
  // =============================
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
              duration: const Duration(milliseconds: 250),
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
