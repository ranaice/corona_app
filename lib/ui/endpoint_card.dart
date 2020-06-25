import 'package:flutter/material.dart';

import 'package:corona_app/app/services/api.dart';

class EndpointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int value;

  const EndpointCard({Key key, this.endpoint, this.value}) : super(key: key);

  static Map<Endpoint, EndpointCardData> _cardsData = {
    Endpoint.cases: EndpointCardData(title: 'Cases', color: Color(0xFFFFF492), assetName: 'assets/suspect.png'),
    Endpoint.todayCases:
        EndpointCardData(title: 'New Cases Today', color: Color(0xFFEEDA28), assetName: 'assets/fever.png'),
    Endpoint.deaths: EndpointCardData(title: 'Deaths', color: Color(0xFFE99600), assetName: 'assets/count.png'),
    Endpoint.todayDeaths:
        EndpointCardData(title: 'New Deaths Today', color: Color(0xFFE40000), assetName: 'assets/death.png'),
    Endpoint.recovered: EndpointCardData(title: 'Recovered', color: Color(0xFF70A901), assetName: 'assets/patient.png'),
  };

  @override
  Widget build(BuildContext context) {
    final cardData = _cardsData[endpoint];

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
                    cardData.title,
                    style: Theme.of(context).textTheme.headline6.copyWith(color: cardData.color),
                  ),
                  SizedBox(height: 12.0),
                  Image.asset(
                    cardData.assetName,
                    height: 48,
                    color: cardData.color,
                  ),
                ],
              ),
              Text(
                value?.toString() ?? '',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: cardData.color.withOpacity(0.9), fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EndpointCardData {
  final String title;
  final String assetName;
  final Color color;
  EndpointCardData({
    this.title,
    this.assetName,
    this.color,
  });
}
