import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../../models/user_model.dart';

class GiftScreen extends StatefulWidget {
  final User user;
  final bool isActive;

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
        autoPlay: false, // <-- autoplay dimatikan
        looping: false,
      );

      // Jika halaman aktif saat pertama dibuka → langsung play
      if (widget.isActive) {
        _videoController.play();
      }

      setState(() {});
    });
  }

  // Stop / play berdasarkan tab aktif
  @override
  void didUpdateWidget(covariant GiftScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive && !_videoController.value.isPlaying) {
      _videoController.play(); // <-- play saat tab aktif
    } else if (!widget.isActive && _videoController.value.isPlaying) {
      _videoController.pause(); // <-- pause saat tab tidak aktif
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Boost"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),

          if (_chewieController != null && _videoController.value.isInitialized)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
