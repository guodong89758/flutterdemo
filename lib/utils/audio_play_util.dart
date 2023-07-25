handle_error_utils.dart
json_transform_util.dart
image_util.dart
device_util.dart
refresh_util.dart
object_util.dart
log_utils.dart
screen_util.dart
screen_helper.dartimport 'package:audioplayers/audioplayers.dart';
import 'package:bitfrog/constant/config.dart';
import 'package:bitfrog/utils/sp_util.dart';

class AudioPlayUtil {
  factory AudioPlayUtil() => _ins();

  static AudioPlayUtil get instance => _ins();

  static AudioPlayUtil? _instance;

  late AudioPlayer audioPlayer;

  List<String> paths = [
    'sounds/alert1.mp3',
    'sounds/alert2.mp3',
    'sounds/alert3.mp3',
    'sounds/alert4.mp3',
    'sounds/alert5.mp3'
  ];

  AudioPlayUtil._internal() {
    audioPlayer = AudioPlayer();
    audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  static AudioPlayUtil _ins() {
    _instance ??= AudioPlayUtil._internal();
    return _instance!;
  }

  Future play(int index) async {
    if (audioPlayer.state == PlayerState.playing) {
      await audioPlayer.stop();
    }
    await audioPlayer.setSourceAsset(paths[index]);
    await audioPlayer.resume();
  }

  Future playAlert() async {
    var index = SpUtil.getInt(Config.keyUserRinging, defValue: 0) ?? 0;
    await audioPlayer.setSourceAsset(paths[index]);
    await audioPlayer.resume();
  }

  Future stop() async {
    await audioPlayer.stop();
  }

}
