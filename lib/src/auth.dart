import 'dart:async';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class GoogleSheets {
  final Future<AutoRefreshingAuthClient>? _serviceAccountClient;
  final String? _accessToken;
  final SheetsApi _api;

  GoogleSheets._({
    Future<AutoRefreshingAuthClient>? serviceAccountClient,
    String? accessToken,
    required SheetsApi api,
  })  : _serviceAccountClient = serviceAccountClient,
        _accessToken = accessToken,
        _api = api;

  static Future<GoogleSheets> withServiceAccount(
      ServiceAccountCredentials credentials, {
        List<String> scopes = const [SheetsApi.spreadsheetsScope],
      }) async {
    final client = clientViaServiceAccount(credentials, scopes);
    final authenticatedClient = await client;
    return GoogleSheets._(
      serviceAccountClient: client,
      api: SheetsApi(authenticatedClient),
    );
  }

  factory GoogleSheets.withAccessToken(String accessToken) {
    final client = _AccessTokenClient(accessToken);
    return GoogleSheets._(
      accessToken: accessToken,
      api: SheetsApi(client),
    );
  }

  Future<Spreadsheet> createSpreadsheet(String title) async {
    final spreadsheet = Spreadsheet(properties: SpreadsheetProperties(title: title));
    return _api.spreadsheets.create(spreadsheet);
  }

  Future<Spreadsheet> getSpreadsheet(String spreadsheetId) async {
    return _api.spreadsheets.get(spreadsheetId);
  }

  Future<void> dispose() async {
    if (_serviceAccountClient != null) {
      final client = await _serviceAccountClient;
      client.close();
    }
  }
}

class _AccessTokenClient extends http.BaseClient {
  final String _token;
  final http.Client _inner = http.Client();

  _AccessTokenClient(this._token);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = 'Bearer $_token';
    return _inner.send(request);
  }
}