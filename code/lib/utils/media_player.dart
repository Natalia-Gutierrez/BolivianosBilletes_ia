import 'package:audioplayers/audioplayers.dart';

class MediaPlayer {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static final AudioCache _audioCache = AudioCache();

  static Future<void> playAudio(String path) async {
    await stopAudio();
    await _audioPlayer.play(path as Source);
  }

  static Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }
}
