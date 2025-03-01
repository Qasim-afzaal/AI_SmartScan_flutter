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
  late CameraController _controller;
  bool _isCameraReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.medium,
    );
    
    await _controller.initialize();
    setState(() => _isCameraReady = true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ScanViewModel>(context);
    
    return Scaffold(
      body: Stack(
        children: [
          if (_isCameraReady) CameraPreview(_controller),
          if (vm.isLoading)
            const Center(child: CircularProgressIndicator()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: FloatingActionButton(
                onPressed: _captureImage,
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _captureImage() async {
    final vm = Provider.of<ScanViewModel>(context, listen: false);
    try {
      final image = await _controller.takePicture();
      await vm.processImage(File(image.path));
      if (vm.result != null) {
        Navigator.pushNamed(context, '/result');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}