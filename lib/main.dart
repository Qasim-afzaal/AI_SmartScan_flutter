import 'package:flutter/material.dart';

import 'package:barcode_scanner/data/datasources/camera_data_source.dart';
import 'package:barcode_scanner/data/datasources/image_picker_data_source.dart';
import 'package:barcode_scanner/data/datasources/mlkit_data_source.dart';

import 'package:barcode_scanner/presentation/view/scanner_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BarcodeRepository>(
          create: (context) => BarcodeRepositoryImpl(
            cameraDataSource: CameraDataSource(),
            imagePickerDataSource: ImagePickerDataSource(),
            mlKitDataSource: MLKitBarcodeDataSource(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BarcodeScannerBloc(
              context.read<BarcodeRepository>(),
            )..add(InitializeCameraEvent()),
        ],
        child: MaterialApp(
          title: 'Barcode Scanner',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const ScannerPage(),
        ),
      ),
    );
  }
}