import 'package:Covid_19_Stats/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../utilities/model.dart';
import 'package:flutter/services.dart';
import '../utilities/statescard.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.black),
  );
  runApp(
    MaterialApp(
      color: Colors.black,
      home: Statewise(),
    ),
  );
}

class Statewise extends StatefulWidget {
  final stateRawData;

  const Statewise({Key key, this.stateRawData}) : super(key: key);
  @override
  _StatewiseState createState() => _StatewiseState();
}

class _StatewiseState extends State<Statewise> {
  Walls _allState;

  void updateUI(dynamic stateData) {
    _allState = Walls.fromJson(stateData);
  }

  @override
  void initState() {
    super.initState();
    this.updateUI(widget.stateRawData);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: _allState.states.length,
          itemBuilder: (BuildContext context, int index) {
            return StatesCard(
              stateName: Text(
                _allState.states[index].state,
                style: stateTextStyle,
              ),
              totalIcon: Icon(
                Icons.all_inclusive,
                color: Colors.yellow,
                size: 35,
              ),
              totalInfected: Text(
                _allState.states[index].cases.toString(),
                style: headingsTextStyle,
              ),
              totalDeathsIcon: Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.red,
                size: 35,
              ),
              totalDeaths: Text(
                _allState.states[index].deaths.toString(),
                style: headingsTextStyle,
              ),
              totalRecoveryIcon: Icon(
                Icons.sentiment_satisfied,
                color: Colors.green,
                size: 35,
              ),
              totalRecovered: Text(
                _allState.states[index].recovered.toString(),
                style: headingsTextStyle,
              ),
            );
          },
        ),
      ),
    );
  }
}
