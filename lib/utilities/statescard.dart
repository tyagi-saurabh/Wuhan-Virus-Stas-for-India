import 'package:flutter/material.dart';

class StatesCard extends StatelessWidget {
  final Widget stateName;
  final Widget totalIcon;
  final Widget totalInfected;
  final Widget totalRecoveryIcon;
  final Widget totalRecovered;
  final Widget totalDeathsIcon;
  final Widget totalDeaths;
  StatesCard(
      {this.stateName,
      this.totalIcon,
      this.totalInfected,
      this.totalRecoveryIcon,
      this.totalRecovered,
      this.totalDeathsIcon,
      this.totalDeaths});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              stateName,
              totalIcon,
              totalInfected,
              totalRecoveryIcon,
              totalRecovered,
              totalDeathsIcon,
              totalDeaths
            ],
          ),
        ),
      ),
    );
  }
}
