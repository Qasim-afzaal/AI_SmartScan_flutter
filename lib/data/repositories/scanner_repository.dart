import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:http/http.dart' as http;

class ScannerRepository {
  
  ScannerRepository(this._mlKitDataSource, this._imagePickerDataSource);

  Future<String?> pickImage() => _imagePickerDataSource.pickImage();
  
  Future<List<Barcode>> scanBarcode(String imagePath) => 
      _mlKitDataSource.scanBarcodes(imagePath);

  Future<List<ImageLabel>> identifyObjects(String imagePath) => 
      _mlKitDataSource.identifyObjects(imagePath);

  Future<String> getObjectInfo(String objectName) async {
    final response = await http.get(Uri.parse(
      'https://en.wikipedia.org/api/rest_v1/page/summary/$objectName'
    ));
    return response.body;
  }
}