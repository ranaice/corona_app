import 'dart:convert';

import 'package:corona_app/app/models/endpoint_data.dart';
import 'package:corona_app/app/models/endpoints_model.dart';
import 'package:corona_app/app/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheService {
  DataCacheService({@required this.sharedPreferences});

  final SharedPreferences sharedPreferences;
  static String endpointValueKey(Endpoint endpoint) => '$endpoint/value';
  static String endpointDateKey(Endpoint endpoint) => '$endpoint/date';
  static String endpointsJsonKey = 'ENDPOINTS_KEY';

  Future<void> saveData(EndpointsModel data) async {
    data.values.forEach((endpoint, endpointData) async {
      await sharedPreferences.setInt(endpointValueKey(endpoint), endpointData.value);
      await sharedPreferences.setString(endpointDateKey(endpoint), endpointData.date.toIso8601String());
    });
  }

  EndpointsModel retrieveDataFromPrimitives() {
    Map<Endpoint, EndpointData> values = {};
    Endpoint.values.forEach((endpoint) {
      final value = sharedPreferences.getInt(endpointValueKey(endpoint));
      final dateString = sharedPreferences.getString(endpointDateKey(endpoint));

      if (value != null && dateString != null) {
        final date = DateTime.tryParse(dateString);
        values[endpoint] = EndpointData(value: value, date: date);
      }
    });

    return EndpointsModel(values: values);
  }
}
