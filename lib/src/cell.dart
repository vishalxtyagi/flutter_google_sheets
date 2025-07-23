import 'worksheet.dart';

class Cell {
  final Worksheet worksheet;
  final int row;
  final int column;
  final String? value;

  Cell(this.worksheet, this.row, this.column, this.value);

  String get a1Notation {
    final colLetter = _columnToLetter(column);
    return '${worksheet.title}!$colLetter$row';
  }

  Future<void> update(String newValue) {
    return worksheet.updateValues(
      _columnToLetter(column) + row.toString(),
      [[newValue]],
    );
  }

  String _columnToLetter(int column) {
    String letter = '';
    while (column > 0) {
      final remainder = (column - 1) % 26;
      letter = String.fromCharCode(65 + remainder) + letter;
      column = (column - 1) ~/ 26;
    }
    return letter;
  }
}