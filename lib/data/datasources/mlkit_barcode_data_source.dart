import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class MLKitBarcodeDataSource {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();

  Future<List<Barcode>> scanBarcodes(InputImage image) async {
    return await _barcodeScanner.processImage(image);
  }

  void close() => _barcodeScanner.close();
}