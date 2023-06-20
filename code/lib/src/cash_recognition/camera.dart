import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/camera.dart';
import '../bloc/classifier_bloc.dart';
import 'package:image_picker/image_picker.dart';
class CashCamera extends CameraApp {
  /// Camera Widget for Cash Recognition component inheriting from CameraApp
  @override
  _CashCameraState createState() => _CashCameraState();
}

class _CashCameraState extends CameraAppState {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initController,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    cameraWidget(context),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: FloatingActionButton(
                          onPressed: captureAndClassify,
                          child: Icon(Icons.camera),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<void> captureAndClassify() async {
    /// Capture an image and classify
    try {
      String path = await captureImage();
      classifyImage(path);
    } catch (e) {
      print(e);
    }
  }
}
