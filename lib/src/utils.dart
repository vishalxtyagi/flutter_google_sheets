import 'exceptions.dart';

String parseKey(dynamic key) {
  if (key is String) return key;
  if (key is num) return key.toString();
  throw GoogleSheetsException('Invalid key type: ${key.runtimeType}');
}

void checkIndex(String name, int value) {
  if (value < 1) {
    throw GoogleSheetsException('$name must be >= 1 (received $value)');
  }
}

List<List<String>> ensureEqualLength(List<List<dynamic>> data) {
  final maxLength = data.map((row) => row.length).reduce((a, b) => a > b ? a : b);
  return data.map((row) {
    return List<String>.from(row.map((e) => e?.toString() ?? ''))
      ..length = maxLength;
  }).toList();
}