import 'package:Covid_19_Stats/statewise.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import './MyCard.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import './statewise.dart';
import 'package:time_formatter/time_formatter.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  runApp(MaterialApp(
    home: CovidStats(),
    routes: <String, WidgetBuilder>{
      "/Statewise": (BuildContext context) => Statewise()
    },
    builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget),
        maxWidth: 2340,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.autoScale(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
        ],
        background: Container(color: Color(0xFFF5F5F5))),
    initialRoute: "/",
  ));
}

class CovidStats extends StatefulWidget {
  @override
  _CovidStatsState createState() => _CovidStatsState();
}

class _CovidStatsState extends State<CovidStats> {
  Map data;
  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull(
            "https://disease.sh/v3/covid-19/countries/India?yesterday=false&strict=true"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return "Success !";
  }

  @override
  void initState() {
    this.getData();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: data == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Today" + " " + (formatTime(data['updated'])),
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      ),
                    ),
                    MyCard(
                      title: Text("New Cases"),
                      icon: Icon(
                        Icons.arrow_upward,
                        color: Colors.orange,
                      ),
                      number: Text(data['todayCases'].toString()),
                    ),
                    MyCard(
                      title: Text("Death's Today"),
                      icon: Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                      number: Text(data['todayDeaths'].toString()),
                    ),
                    MyCard(
                      title: Text("Recovered Today"),
                      icon: Icon(
                        Icons.autorenew,
                        color: Colors.green,
                      ),
                      number: Text(data['todayRecovered'].toString()),
                    ),
                    Center(
                      child: Text(
                        "Overall",
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      ),
                    ),
                    MyCard(
                      title: Text("Total Cases"),
                      icon: Icon(
                        Icons.all_inclusive,
                        color: Colors.yellow,
                      ),
                      number: Text(data['cases'].toString()),
                    ),
                    MyCard(
                      title: Text("Total Deaths"),
                      icon: Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.red,
                      ),
                      number: Text(data['deaths'].toString()),
                    ),
                    MyCard(
                      title: Text("Total Recovered"),
                      icon: Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.green,
                      ),
                      number: Text(data['recovered'].toString()),
                    ),
                    RaisedButton(
                      child: Text(
                        "State Wise Data",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      color: Colors.cyan,
                      onPressed: () {
                        Navigator.of(context).pushNamed("/Statewise");
                      },
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
