import 'dart:convert';

import 'package:corona_app/app/models/endpoint_data.dart';
import 'package:corona_app/app/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// Make requests and parse responses
class APIService {
  final API api;

  APIService(this.api);

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );

    if (response.statusCode == 200) {
      final accessToken = jsonDecode(response.body)['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print('Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');

    throw response;
  }

  Future<EndpointData> getEndpointData({@required String accessToken, @required Endpoint endpoint}) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(uri.toString(), headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final finalResult = data[0]['data'];
        final DateTime date = DateTime.tryParse(data[0]['date']);
        if (finalResult != null) {
          return EndpointData(value: finalResult, date: date);
        }
      }
    }

    print('Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }
}
