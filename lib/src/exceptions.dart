class GoogleSheetsException implements Exception {
  final String message;
  GoogleSheetsException(this.message);

  @override
  String toString() => 'GoogleSheetsException: $message';
}