import 'package:flutter/material.dart';
import './model.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import './StatesCard.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  runApp(MaterialApp(
    color: Colors.black,
    home: Statewise(),
  ));
}

class Statewise extends StatefulWidget {
  @override
  _StatewiseState createState() => _StatewiseState();
}

class _StatewiseState extends State<Statewise> {
  Walls _allState;
  Map _statedata;
  Future<String> getStateData() async {
    http.Response response = await http.get(
        Uri.encodeFull("https://disease.sh/v3/covid-19/gov/India"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      _statedata = json.decode(response.body);
      _allState = Walls.fromJson(_statedata);
    });

    return "Success !";
  }

  @override
  void initState() {
    this.getStateData();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: _allState == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _allState == null ? 0 : _allState.states.length,
              itemBuilder: (BuildContext context, int index) {
                return StatesCard(
                  stateName: Text(
                    _allState.states[index].state,
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                  totalIcon: Icon(
                    Icons.all_inclusive,
                    color: Colors.yellow,
                  ),
                  totalInfected: Text(
                    _allState.states[index].cases.toString(),
                  ),
                  totalDeathsIcon: Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.red,
                  ),
                  totalDeaths: Text(_allState.states[index].deaths.toString()),
                  totalRecoveryIcon: Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.green,
                  ),
                  totalRecovered:
                      Text(_allState.states[index].recovered.toString()),
                );
              }),
    ));
  }
}
