import 'dart:io';
import 'package:barcode_scanner/data/repositories/scan_repository.dart';
import 'package:flutter/foundation.dart';

class ScanViewModel with ChangeNotifier {
  final ScanRepository _repo = ScanRepository();
  File? _image;
  String? _result;
  bool _isLoading = false;
  String? _error;

  File? get image => _image;
  String? get result => _result;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> processImage(File image) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final objectName = await _repo.processImage(image);
      final info = await _repo.getObjectInfo(objectName);
      
      _image = image;
      _result = info;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearResults() {
    _image = null;
    _result = null;
    _error = null;
    notifyListeners();
  }
}