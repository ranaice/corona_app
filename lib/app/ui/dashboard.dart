import 'dart:io';

import 'package:corona_app/app/models/endpoints_model.dart';
import 'package:corona_app/app/repositories/data_repository.dart';
import 'package:corona_app/app/services/api.dart';
import 'package:corona_app/app/ui/show_alert_dialog.dart';
import 'package:corona_app/app/ui/widgets/endpoint_card.dart';
import 'package:corona_app/app/ui/widgets/last_updated_status_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsModel _endpointsData;

  @override
  void initState() {
    super.initState();
    _endpointsData = Provider.of<DataRepository>(context, listen: false).getAllEndpointsCachedData();
    _fetchData();
  }

  Future<void> _fetchData() async {
    // What Errors to Handle when making network calls?
    // Connectivity errors (offline)
    // Server Errors (API Not Working)
    // Parsing Errors (missing/incorrect data in API Response)
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    try {
      final cases = await dataRepository.getAllEndpointsData();
      setState(() {
        _endpointsData = cases;
      });
    } on SocketException catch (_) {
      showAlertDialog(
        context: context,
        title: 'Connection Error',
        content: 'Could not retrieve data. Please try again later.',
        defaultActionText: 'OK',
      );
    } catch (_) {
      // Generic catch block will handle 4xx/5xx errors and parsing errors
      // In a real app, remember to add specific erro handling for each scenario
      showAlertDialog(
          context: context,
          title: 'Unknown Error',
          content: 'Please contact support or try again later',
          defaultActionText: 'OK');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
        lastUpdated: _endpointsData != null ? _endpointsData.values[Endpoint.cases]?.date : null);
    return Scaffold(
      appBar: AppBar(
        title: Text('Corona App'),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchData,
        child: ListView(
          children: <Widget>[
            LastUpdatedStatusText(
              text: formatter.lastUpdatedStatusText(),
            ),
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData != null ? _endpointsData.values[endpoint]?.value : null,
              ),
          ],
        ),
      ),
    );
  }
}
