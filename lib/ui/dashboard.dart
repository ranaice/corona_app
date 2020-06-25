import 'package:corona_app/app/models/endpoints_model.dart';
import 'package:corona_app/app/repositories/data_repository.dart';
import 'package:corona_app/app/services/api.dart';
import 'package:corona_app/ui/endpoint_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsModel _cases;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final cases = await dataRepository.getAllEndpointsData();
    setState(() {
      _cases = cases;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Corona App'),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchData,
        child: ListView(
          children: <Widget>[
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _cases != null ? _cases.values[endpoint] : null,
              ),
          ],
        ),
      ),
    );
  }
}
