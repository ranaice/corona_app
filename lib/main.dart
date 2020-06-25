import 'package:corona_app/app/repositories/data_repository.dart';
import 'package:corona_app/app/services/api.dart';
import 'package:corona_app/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(apiService: APIService(API.sandbox())),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Corona App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _accessToken = '';
  int _cases;

  void _updateAccessToken() async {
    final apiService = APIService(API.sandbox());
    final accessToken = await apiService.getAccessToken();
    final cases = await apiService.getEndpointData(accessToken: accessToken, endpoint: Endpoint.cases);
    setState(() {
      _accessToken = accessToken;
      _cases = cases;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_cases != null)
              Text(
                'Total cases: $_cases',
              ),
            Text(
              '$_accessToken',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateAccessToken,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
