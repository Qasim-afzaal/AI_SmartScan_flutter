import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/barcode_scanner_bloc.dart';
import '../widgets/camera_preview.dart';
import '../widgets/barcode_result.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Scanner')),
      body: BlocConsumer<BarcodeScannerBloc, BarcodeScannerState>(
        listener: (context, state) {
          if (state is BarcodeErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is CameraReadyState) {
            return const CameraPreviewWidget();
          }
          if (state is BarcodeScanSuccessState) {
            return Column(
              children: [
                Image.file(File(state.imagePath)),
                BarcodeResultWidget(barcodes: state.barcodes),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<BarcodeScannerBloc>().add(CaptureAndScanEvent()),
        child: const Icon(Icons.camera),
      ),
    );
  }
}