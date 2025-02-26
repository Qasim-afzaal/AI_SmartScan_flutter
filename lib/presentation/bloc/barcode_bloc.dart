part of 'barcode_scanner_bloc.dart';

abstract class BarcodeScannerEvent {
  const BarcodeScannerEvent();
}

class InitCameraEvent extends BarcodeScannerEvent {}
class ScanImageEvent extends BarcodeScannerEvent {}
class PickImageEvent extends BarcodeScannerEvent {}

abstract class BarcodeScannerState {
  const BarcodeScannerState();
}

class CameraInitializing extends BarcodeScannerState {}
class CameraReady extends BarcodeScannerState {
  final CameraController controller;
  const CameraReady(this.controller);
}
class BarcodeDetected extends BarcodeScannerState {
  final List<BarcodeEntity> barcodes;
  const BarcodeDetected(this.barcodes);
}
class BarcodeError extends BarcodeScannerState {
  final String message;
  const BarcodeError(this.message);
}