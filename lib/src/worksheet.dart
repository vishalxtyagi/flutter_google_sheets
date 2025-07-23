import 'package:googleapis/sheets/v4.dart';
import 'spreadsheet.dart';

class Worksheet {
  final SpreadsheetManager _spreadsheet;
  final String _name;
  final int _sheetId;

  Worksheet(this._spreadsheet, this._name, this._sheetId);

  String get title => _name;
  int get id => _sheetId;

  Future<List<List<Object?>>> getValues({String? range}) async {
    final fullRange = range != null ? '$_name!$range' : _name;
    final response = await _spreadsheet.getValues(fullRange);
    return response.values ?? [];
  }

  Future<void> updateValues(
      String range,
      List<List<Object?>> values, {
        String valueInputOption = 'USER_ENTERED',
      }) {
    return _spreadsheet.updateValues(
      '$_name!$range',
      ValueRange(values: values),
      valueInputOption: valueInputOption,
    );
  }

  Future<void> appendRows(List<List<Object?>> rows) {
    return _spreadsheet.appendValues(
      _name,
      ValueRange(values: rows),
    );
  }

  Future<void> resize({int? rowCount, int? columnCount}) async {
    await _spreadsheet.batchUpdate([
      Request(updateSheetProperties: UpdateSheetPropertiesRequest(
        properties: SheetProperties(
          sheetId: _sheetId,
          gridProperties: GridProperties(
            rowCount: rowCount,
            columnCount: columnCount,
          ),
        ),
        fields: 'gridProperties(rowCount,columnCount)',
      )),
    ]);
  }
}