import 'dart:async';
import '../utils/media_player.dart';
import '../cash_recognition/models/note_model.dart';
import '../db/database_helper.dart';
import 'package:flutter_pytorch/flutter_pytorch.dart';
import 'package:flutter_pytorch/pigeon.dart';

String audiofile = "cash_recognition/audio/nrs_audio/";
String _modelPath = "assets/cash_recognition/models/nrs_model/model.tflite";
String _labelPath = "assets/labels/labels.txt";
late ModelObjectDetection _objectModel;
bool objectDetection = false;
List<ResultObjectDetection?> objDetect = [];
void classifyImage(String imagePath) {
  loadModel();
 
}

Future<void> classifyImage(String imagePath) async {

  /// Classify the given image
  // load the tfltie model
  await Tflite.loadModel(model: _modelPath, labels: _labelPath);
  // Run the model on image
  // High threshold for better accuracy
  List<dynamic>? output = await (Tflite.runModelOnImage(
      path: imagePath,
      numResults: 2,
      threshold: 0.99,
      imageMean: 117.0,
      imageStd: 1.0,
      asynch: true));
  // Add classified note to database and play the corresponding audio feedback
  if (output != null && output.isNotEmpty) {
    String result = output[0]["label"];
    // print(result + ' ' + output[0]["confidence"].toString());
    String note = result.substring(2);
    Note noteObj = Note(label: note);
    await DatabaseHelper.instance.insert(noteObj);
    playAudio(note);
    if(HapticFeedback.canVibrate){
      Vibrate.feedback(FeedbackType.success);
    }
  }
  // else play [wrong.mp3]
  else {
    await MediaPlayer.playAudio(audiofile + 'wrong.mp3');
    if(HapticFeedback.canVibrate){
      Vibrate.feedback(FeedbackType.error);
    }
  }
}

Future<void> playAudio(String note) async {
  // play an audio feedback corresponding the classified note
  await MediaPlayer.playAudio(audiofile + note + '.mp3');
}

Future loadModel() async {
    String pathObjectDetectionModel = "assets/models/yolov5s.torchscript";
    try {
      _objectModel = await FlutterPytorch.loadObjectDetectionModel(
          pathObjectDetectionModel, 80, 640, 640,
          labelPath: "assets/labels/labels.txt");
    } catch (e) {
      if (e is PlatformException) {
        print("only supported for android, Error is $e");
      } else {
        print("Error is $e");
      }
    }
  }