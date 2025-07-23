# Flutter Google Sheets

A Flutter package for interacting with Google Sheets API v4, providing a simple interface to read, write, and manipulate Google Spreadsheets.

## Features

- Authenticate with Google Sheets API using service account or access token
- Create and retrieve spreadsheets
- Get, update, and append values to worksheets
- Resize worksheets (adjust row and column counts)
- Work with individual cells with convenient notation

## Getting started

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  google_sheets: ^0.0.1
```

Then run:

```bash
flutter pub get
```

### Prerequisites

1. Create a Google Cloud project and enable the Google Sheets API
2. Set up authentication (service account or OAuth)

## Usage

### Authentication

Using a service account:

```dart
import 'package:google_sheets/google_sheets.dart';

// Initialize with service account credentials
final credentials = ServiceAccountCredentials.fromJson(
  {...} // Your JSON service account key
);
final gsheets = await GoogleSheets.withServiceAccount(credentials);
```

Using an access token:

```dart
// Initialize with an OAuth access token
final gsheets = GoogleSheets.withAccessToken('your-access-token');
```

### Working with Spreadsheets

```dart
// Create a new spreadsheet
final spreadsheet = await gsheets.createSpreadsheet('My Spreadsheet');
final spreadsheetId = spreadsheet.spreadsheetId;

// Or access an existing spreadsheet
final existingSheet = await gsheets.getSpreadsheet('spreadsheetId');
```

### Working with Worksheets

```dart
import 'package:googleapis/sheets/v4.dart';
import 'package:google_sheets/google_sheets.dart';

// Create a SpreadsheetManager
final api = SheetsApi(yourAuthenticatedClient);
final spreadsheetManager = SpreadsheetManager(api, 'spreadsheetId');

// Add a worksheet
await spreadsheetManager.addWorksheet('Sheet1');

// Create a worksheet instance (assuming you know the sheetId)
final worksheet = Worksheet(spreadsheetManager, 'Sheet1', sheetId);

// Get values from the worksheet
final values = await worksheet.getValues(range: 'A1:C10');

// Update values in a range
await worksheet.updateValues('A1:B2', [
  ['Name', 'Score'],
  ['John', 95]
]);

// Append rows
await worksheet.appendRows([
  ['Jane', 98],
  ['Bob', 85]
]);

// Resize a worksheet
await worksheet.resize(rowCount: 100, columnCount: 26);
```

### Working with Individual Cells

```dart
// Create a cell
final cell = Cell(worksheet, 1, 1, 'Initial Value');

// Get cell reference in A1 notation
final a1Reference = cell.a1Notation; // e.g., "Sheet1!A1"

// Update a cell value
await cell.update('New Value');
```

## Additional information

- This package uses the official [googleapis](https://pub.dev/packages/googleapis) package for API access
- Authentication is handled via [googleapis_auth](https://pub.dev/packages/googleapis_auth)
- Report issues on [GitHub](https://github.com/vishalxtyagi/flutter_google_sheets/issues)
- Contributions are welcome!

## License

This package is available under the MIT License.
