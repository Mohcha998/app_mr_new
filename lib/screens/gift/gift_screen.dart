import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../../models/user_model.dart';

class GiftScreen extends StatefulWidget {
  final User user;
  final bool isActive; // <-- penting

  const GiftScreen({super.key, required this.user, required this.isActive});

  @override
  State<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> with WidgetsBindingObserver {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _videoController = VideoPlayerController.networkUrl(
      Uri.parse("https://cdn.jwplayer.com/videos/WSalnFpu.mp4"),
    );

    _videoController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: false,
        looping: false,
      );
      setState(() {});
    });
  }

  // stop saat tab diganti (isActive berubah)
  @override
  void didUpdateWidget(covariant GiftScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.isActive) {
      _videoController.pause();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_videoController.value.isInitialized) {
      if (state == AppLifecycleState.paused ||
          state == AppLifecycleState.inactive) {
        _videoController.pause();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoController.pause();
    _chewieController?.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Boost"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // <-- bikin full width
        children: [
          const SizedBox(height: 10),

          if (_chewieController != null && _videoController.value.isInitialized)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ), // <-- kiri kanan rata
              child: AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: Chewie(controller: _chewieController!),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
