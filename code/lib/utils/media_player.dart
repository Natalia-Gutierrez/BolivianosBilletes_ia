import 'package:audioplayers/audioplayers.dart';

class MediaPlayer {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static final AudioCache _audioCache = AudioCache(fixedPlayer: _audioPlayer);

  static Future<void> playAudio(String path) async {
    await stopAudio();
    await _audioCache.play(path);
  }

  static Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }
}
