import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/scanner_view_model.dart';

class ScannerView extends StatelessWidget {
  const ScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ScannerViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('AI Scanner')),
      body: _buildBody(vm),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scanImage(context),
        child: const Icon(Icons.camera),
      ),
    );
  }

  Widget _buildBody(ScannerViewModel vm) {
    if (vm.isLoading) return const Center(child: CircularProgressIndicator());
    if (vm.errorMessage != null) return Center(child: Text(vm.errorMessage!));
    
    return Column(
      children: [
        Expanded(
          child: vm.cameraController != null
              ? CameraPreview(vm.cameraController!)
              : const Placeholder(),
        ),
        ElevatedButton(
          onPressed: () => _scanImage(context),
          child: const Text('Scan Object')),
      ],
    );
  }

  void _scanImage(BuildContext context) async {
    final vm = context.read<ScannerViewModel>();
    final imagePath = await vm.pickImage();
    if (imagePath != null) {
      final barcodes = await vm.scanBarcode(imagePath);
      // Handle results
    }
  }
}