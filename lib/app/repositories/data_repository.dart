import 'package:corona_app/app/models/endpoints_model.dart';
import 'package:corona_app/app/services/api.dart';
import 'package:corona_app/app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  final APIService apiService;
  DataRepository({@required this.apiService});

  String _accessToken;

  Future<int> getEndpointData(Endpoint endpoint) async {
    return _getDataRefreshingToken<int>(
        onGetData: () => apiService.getEndpointData(accessToken: _accessToken, endpoint: endpoint));
  }

  Future<EndpointsModel> getAllEndpointsData() async {
    return _getDataRefreshingToken<EndpointsModel>(onGetData: _getAllEndpointsData);
  }

  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }

      return onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return onGetData();
      }
      rethrow;
    }
  }

  Future<EndpointsModel> _getAllEndpointsData() async {
    final values = await Future.wait([
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.todayCases),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.todayDeaths),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.recovered),
    ]);

    return EndpointsModel(values: {
      Endpoint.cases: values[0],
      Endpoint.todayCases: values[1],
      Endpoint.deaths: values[2],
      Endpoint.todayDeaths: values[3],
      Endpoint.recovered: values[4],
    });
  }
}
