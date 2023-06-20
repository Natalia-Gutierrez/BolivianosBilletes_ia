import 'dart:async';
import 'package:flutter/services.dart';

import '../utils/media_player.dart';
import '../cash_recognition/models/note_model.dart';
import '../db/database_helper.dart';
import 'package:flutter_pytorch/flutter_pytorch.dart';
import 'package:flutter_pytorch/pigeon.dart';

String audiofile = "assets/sounds";
String _modelPath = "assets/cash_recognition/models/nrs_model/model.tflite";
String _labelPath = "assets/labels/labels.txt";
late ModelObjectDetection _objectModel;
bool objectDetection = false;
List<ResultObjectDetection?> objDetect = [];
void classifyImage(String imagePath) {
  loadModel();
 
}

Future<void> playAudio(String note) async {
  // play an audio feedback corresponding the classified note
  await MediaPlayer.playAudio(audiofile + note + '.mp3');
}

Future loadModel() async {
    String pathObjectDetectionModel = _modelPath;
    try {
      _objectModel = await FlutterPytorch.loadObjectDetectionModel(
          pathObjectDetectionModel, 80, 640, 640,
          labelPath: _labelPath);
      if(_objectModel!= null){
        var output;
        String result = output[0]["label"];
        // print(result + ' ' + output[0]["confidence"].toString());
        String note = result.substring(2);
        Note noteObj = Note(label: note);
        await DatabaseHelper.instance.insert(noteObj);
        playAudio(note);
      }
      else {
        await MediaPlayer.playAudio(audiofile + 'wrong.mp3');
      }
    } catch (e) {
      if (e is PlatformException) {
        print("only supported for android, Error is $e");
      } else {
        print("Error is $e");
      }
    }
  }