import 'package:corona_app/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget {
  final Color color;
  final Endpoint endpoint;
  final int value;

  const EndpointCard({Key key, @required this.color, this.endpoint, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Total Cases',
                    style: Theme.of(context).textTheme.headline5.copyWith(color: color),
                  ),
                  SizedBox(height: 12.0),
                  Icon(
                    Icons.clear,
                    size: 40,
                    color: color.withOpacity(0.7),
                  ),
                ],
              ),
              Text(
                value?.toString() ?? '500000',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: color.withOpacity(0.9), fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
