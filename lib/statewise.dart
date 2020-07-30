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
    home: Statewise(),
  ));
}

class Statewise extends StatefulWidget {
  @override
  _StatewiseState createState() => _StatewiseState();
}

class _StatewiseState extends State<Statewise> {
  Walls allState;
  Map statedata;
  Future<String> getStateData() async {
    http.Response response = await http.get(
        Uri.encodeFull("https://disease.sh/v3/covid-19/gov/India"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      statedata = json.decode(response.body);
      allState = Walls.fromJson(statedata);
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
      body: allState == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: allState == null ? 0 : allState.states.length,
              itemBuilder: (BuildContext context, int index) {
                return StatesCard(
                  stateName: Text(
                    allState.states[index].state,
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                  totalIcon: Icon(
                    Icons.all_inclusive,
                    color: Colors.yellow,
                  ),
                  totalInfected: Text(
                    allState.states[index].cases.toString(),
                  ),
                  totalDeathsIcon: Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.red,
                  ),
                  totalDeaths: Text(allState.states[index].deaths.toString()),
                  totalRecoveryIcon: Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.green,
                  ),
                  totalRecovered:
                      Text(allState.states[index].recovered.toString()),
                );
              }),
    ));
  }
}
