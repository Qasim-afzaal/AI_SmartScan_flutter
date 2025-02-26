import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import '../../data/repositories/scanner_repository.dart';

class ScannerViewModel with ChangeNotifier {
  final ScannerRepository _repository;
  CameraController? _cameraController;
  bool _isLoading = false;
  String? _errorMessage;

  ScannerViewModel(this._repository);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  CameraController? get cameraController => _cameraController;

  Future<void> initializeCamera() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final cameras = await availableCameras();
      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.medium,
      );
      await _cameraController!.initialize();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Camera initialization failed: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> pickImage() async {
    try {
      return await _repository.pickImage();
    } catch (e) {
      _errorMessage = 'Image pick failed: ${e.toString()}';
      notifyListeners();
      return null;
    }
  }

  Future<List<Barcode>> scanBarcode(String imagePath) async {
    try {
      _isLoading = true;
      notifyListeners();
      return await _repository.scanBarcode(imagePath);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}