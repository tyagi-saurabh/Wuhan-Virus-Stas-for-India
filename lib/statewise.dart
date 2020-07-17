import 'package:flutter/material.dart';
import './model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import './StatesCard.dart';

void main() {
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
  States allState;
  Map statedata;
  Future<String> getStateData() async {
    http.Response response = await http.get(
        Uri.encodeFull("https://disease.sh/v3/covid-19/gov/India"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      statedata = json.decode(response.body);
      allState = States.fromJson(statedata);
    });

    return "Success !";
  }

  @override
  void initState() {
    this.getStateData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
          itemCount: allState == null ? 0 : allState.states.length,
          itemBuilder: (BuildContext context, int index) {
            return StatesCard(
              stateName: Text(
                allState == null ? "Updating" : allState.states[index].state,
                style: TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.bold),
              ),
              totalIcon: Icon(
                Icons.all_inclusive,
                color: Colors.yellow,
              ),
              totalInfected: Text(
                allState == null
                    ? "Updating"
                    : allState.states[index].total.toString(),
              ),
              totalDeathsIcon: Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.red,
              ),
              totalDeaths: Text(allState == null
                  ? "Updating"
                  : allState.states[index].deaths.toString()),
              totalRecoveryIcon: Icon(
                Icons.sentiment_satisfied,
                color: Colors.green,
              ),
              totalRecovered: Text(allState == null
                  ? "Updating"
                  : allState.states[index].recovered.toString()),
            );
          }),
    );
  }
}
