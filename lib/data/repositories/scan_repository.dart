import 'dart:convert';
import 'dart:io';
import 'package:barcode_scanner/core/constants.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:http/http.dart' as http;

class ScanRepository {
  Future<String> processImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    final imageLabeler = GoogleMlKit.vision.imageLabeler();
    final labels = await imageLabeler.processImage(inputImage);
    imageLabeler.close();
    
    if (labels.isEmpty) throw Exception('No objects detected');
    return labels.first.label;
  }

  Future<String> getObjectInfo(String objectName) async {
    final response = await http.get(
      Uri.parse('${AppConstants.wikipediaApiUrl}$objectName'),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['query']['search'].isNotEmpty) {
        return data['query']['search'][0]['snippet'];
      }
    }
    throw Exception('Information not found');
  }
}