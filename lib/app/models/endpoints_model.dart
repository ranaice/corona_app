import 'package:corona_app/app/models/endpoint_data.dart';
import 'package:flutter/foundation.dart';

import 'package:corona_app/app/services/api.dart';

class EndpointsModel {
  final Map<Endpoint, EndpointData> values;

  EndpointsModel({@required this.values});

  EndpointData get cases => values[Endpoint.cases];
  EndpointData get todayCases => values[Endpoint.todayCases];
  EndpointData get deaths => values[Endpoint.deaths];
  EndpointData get todayDeaths => values[Endpoint.todayDeaths];
  EndpointData get recovered => values[Endpoint.recovered];

  @override
  String toString() => 'EndpointsModel(values: $values)';
}
