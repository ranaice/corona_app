import 'package:corona_app/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum Endpoint {
  cases,
  todayCases,
  deaths,
  todayDeaths,
  recovered,
}

// Lists all endpoints
class API {
  final String apiKey;

  API({@required this.apiKey});

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  static final String host = 'apigw.nubentos.com';
  static final int port = 443;
  static final String basePath = '/t/nubentos.com/ncovapi/2.0.0';

  Uri tokenUri() {
    return Uri(
      scheme: 'https',
      host: host,
      port: port,
      path: 'token',
      queryParameters: {'grant_type': 'client_credentials'},
    );
  }

  Uri endpointUri(Endpoint endpoint) => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: '$basePath/${_paths[endpoint]}',
      );

  static Map<Endpoint, String> _paths = {
    Endpoint.cases: 'cases',
    Endpoint.todayCases: 'todayCases',
    Endpoint.deaths: 'deaths',
    Endpoint.todayDeaths: 'todayDeaths',
    Endpoint.recovered: 'recovered',
  };
}
