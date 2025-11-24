import '../models/audio_model.dart';

class AudioService {
  String playlistUrl =
      "https://castbox.fm/app/castbox/player/id2238870?v=8.10.3&autoplay=0";

  final List<AudioModel> audios = [
    AudioModel(
      id: "1",
      title: "SPOKEN WORD - Saya Pasti Bisa",
      urlAudio:
          "https://anchor.fm/merry-riana/embed/episodes/Spoken-Word---Saya-Pasti-Bisa-e4sfeb",
      date: "2025-10-03",
    ),
    AudioModel(
      id: "2",
      title: "Friends of Merry Riana HETIFAH SJAFUD...",
      urlAudio: "",
      date: "2025-09-26",
    ),
  ];

  List<AudioModel> getPlaylist() {
    return audios;
  }
}
