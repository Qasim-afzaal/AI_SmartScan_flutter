import 'package:camera/camera.dart';

class CameraDataSource {
  late CameraController _controller;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
    );
    return _controller.initialize();
  }

  CameraController get controller => _controller;
  
  Future<void> dispose() async => _controller.dispose();
}