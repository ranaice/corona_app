import 'package:corona_app/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

// Lists all endpoints
class API {
  final String apiKey;

  API({@required this.apiKey});

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  static final String host = 'apigw.nubentos.com';
  static final int port = 443;

  Uri tokenUri() {
    return Uri(
      scheme: 'https',
      host: host,
      port: port,
      path: 'token',
      queryParameters: {'grant_type': 'client_credentials'},
    );
  }
}
