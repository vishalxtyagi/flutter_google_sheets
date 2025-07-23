import 'package:googleapis/sheets/v4.dart';

class SpreadsheetManager {
  final SheetsApi _api;
  final String spreadsheetId;

  SpreadsheetManager(this._api, this.spreadsheetId);

  Future<Spreadsheet> get() => _api.spreadsheets.get(spreadsheetId);

  Future<BatchUpdateSpreadsheetResponse> batchUpdate(
      List<Request> requests,
      ) {
    final batchUpdate = BatchUpdateSpreadsheetRequest(requests: requests);
    return _api.spreadsheets.batchUpdate(batchUpdate, spreadsheetId);
  }

  Future<ValueRange> getValues(String range) {
    return _api.spreadsheets.values.get(spreadsheetId, range);
  }

  Future<UpdateValuesResponse> updateValues(
      String range,
      ValueRange valueRange, {
        String valueInputOption = 'USER_ENTERED',
      }) {
    return _api.spreadsheets.values.update(
      valueRange,
      spreadsheetId,
      range,
      valueInputOption: valueInputOption,
    );
  }

  Future<AppendValuesResponse> appendValues(
      String range,
      ValueRange valueRange, {
        String valueInputOption = 'USER_ENTERED',
      }) {
    return _api.spreadsheets.values.append(
      valueRange,
      spreadsheetId,
      range,
      valueInputOption: valueInputOption,
    );
  }

  Future<void> addWorksheet(String title) async {
    await batchUpdate([
      Request(addSheet: AddSheetRequest(
        properties: SheetProperties(title: title),
      )),
    ]);
  }
}