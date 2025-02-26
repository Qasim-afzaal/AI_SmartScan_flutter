import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class MLKitDataSource {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  final ImageLabeler _imageLabeler = ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.7));

  Future<List<Barcode>> scanBarcodes(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    return _barcodeScanner.processImage(inputImage);
  }

  Future<List<ImageLabel>> identifyObjects(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    return _imageLabeler.processImage(inputImage);
  }

  void dispose() {
    _barcodeScanner.close();
    _imageLabeler.close();
  }
}