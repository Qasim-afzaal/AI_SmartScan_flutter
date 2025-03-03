import 'dart:io';

import 'package:barcode_scanner/domain/view_model/scan_viewmodel.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const ScanScreen({required this.cameras, super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameraController = CameraController(
      widget.cameras.first,
      ResolutionPreset.medium,
    );

    await _cameraController.initialize();
    setState(() => _isCameraInitialized = true);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanViewModel = Provider.of<ScanViewModel>(context);

    return Scaffold(
      body: Stack(
        children: [
          if (_isCameraInitialized) CameraPreview(_cameraController),
          if (scanViewModel.isLoading)
            const Center(child: CircularProgressIndicator()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: FloatingActionButton(
                onPressed: _onCapturePressed,
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onCapturePressed() async {
    final scanViewModel = Provider.of<ScanViewModel>(context, listen: false);
    try {
      final image = await _cameraController.takePicture();
      await scanViewModel.processImage(File(image.path));
      if (scanViewModel.result != null) {
        Navigator.pushNamed(context, '/result');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
    }
  }
}
