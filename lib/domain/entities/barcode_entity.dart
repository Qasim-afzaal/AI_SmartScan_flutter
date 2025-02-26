class BarcodeEntity {
  final String value;
  final BarcodeFormat format;
  final Rect? boundingBox;

  BarcodeEntity({
    required this.value,
    required this.format,
    this.boundingBox,
  });
}