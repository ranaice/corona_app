import 'package:flutter/foundation.dart';

import 'package:corona_app/app/services/api.dart';

class EndpointsModel {
  final Map<Endpoint, int> values;

  EndpointsModel({@required this.values});

  int get cases => values[Endpoint.cases];
  int get todayCases => values[Endpoint.todayCases];
  int get deaths => values[Endpoint.deaths];
  int get todayDeaths => values[Endpoint.todayDeaths];
  int get recovered => values[Endpoint.recovered];

  @override
  String toString() => 'EndpointsModel(values: $values)';
}
