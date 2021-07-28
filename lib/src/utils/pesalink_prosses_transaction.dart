import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:coopbank_pesalink/coopbank_pesalink.dart';
import 'package:http/io_client.dart';

const String testUrl = 'https://openapi-sandbox.co-opbank.co.ke';
const String prodUrl = 'https://openapi-sit.co-opbank.co.ke';

Future<BankReponse> pesalinkProcessTransaction(
    String url,
    Map<String, String> headers,
    Map<String, dynamic> payload,
    ApplicationMode applicationMode) async {
  String finalUrl = url;
  if (applicationMode == ApplicationMode.production) {
    finalUrl = '$prodUrl$url';
  } else {
    finalUrl = '$testUrl$url';
  }

  try {
    const bool trustSelfSigned = true;
    final HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    final IOClient ioClient = IOClient(httpClient);

    final http.Response _res = await ioClient.post(Uri.parse(finalUrl),
        headers: headers, body: json.encode(payload));
    dynamic _body;
    Map<String, dynamic>? _bodyAsmap;
    try {
      _body = json.decode(_res.body);
      _bodyAsmap = _body as Map<String, dynamic>?;
    } catch (e) {
      _body = _res.body;
    }

    var _bankReponse = BankReponse.fromMap(_bodyAsmap ?? {});
    _bankReponse.statusCode = _res.statusCode;

    return _bankReponse;
  } catch (e) {
    rethrow;
  }
}
