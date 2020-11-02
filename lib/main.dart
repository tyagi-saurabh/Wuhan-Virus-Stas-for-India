import 'package:Covid_19_Stats/services/api_services.dart';
import 'package:Covid_19_Stats/screens/statewise.dart';
import 'package:Covid_19_Stats/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'utilities/mycard.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'screens/statewise.dart';
import 'package:time_formatter/time_formatter.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.black),
  );
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: CovidStats(),
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
  dynamic _countryData;
  dynamic _stateData;
  void getData() async {
    dynamic rawCountryData =
        await FetchData(countryUrl: countryDataUrl).getCountryData();
    setState(() {
      _countryData = json.decode(rawCountryData);
    });
  }

  void getStateData() async {
    _stateData = await FetchData(statesUrl: stateDataUrl).getStateData();
  }

  @override
  void initState() {
    super.initState();
    this.getData();
    this.getStateData();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _countryData == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Last Updated" +
                                  ":" +
                                  " " +
                                  (formatTime(_countryData['updated'])),
                              style: mainHeadingsTextStyle,
                            ),
                          ),
                          MyCard(
                            title: Text(
                              "New Cases",
                              style: headingsTextStyle,
                            ),
                            icon: Icon(
                              Icons.arrow_upward,
                              color: Colors.orange,
                              size: 35,
                            ),
                            number: Text(
                              _countryData['todayCases'].toString(),
                              style: headingsTextStyle,
                            ),
                          ),
                          MyCard(
                            title: Text(
                              "Death's Today",
                              style: headingsTextStyle,
                            ),
                            icon: Icon(
                              Icons.warning,
                              color: Colors.red,
                              size: 35,
                            ),
                            number: Text(
                              _countryData['todayDeaths'].toString(),
                              style: headingsTextStyle,
                            ),
                          ),
                          MyCard(
                            title: Text(
                              "Recovered Today",
                              style: headingsTextStyle,
                            ),
                            icon: Icon(
                              Icons.autorenew,
                              color: Colors.green,
                              size: 35,
                            ),
                            number: Text(
                              _countryData['todayRecovered'].toString(),
                              style: headingsTextStyle,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Overall",
                              style: headingsTextStyle,
                            ),
                          ),
                          MyCard(
                            title: Text(
                              "Total Cases",
                              style: headingsTextStyle,
                            ),
                            icon: Icon(
                              Icons.all_inclusive,
                              color: Colors.yellow,
                              size: 35,
                            ),
                            number: Text(
                              _countryData['cases'].toString(),
                              style: headingsTextStyle,
                            ),
                          ),
                          MyCard(
                            title: Text(
                              "Total Deaths",
                              style: headingsTextStyle,
                            ),
                            icon: Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.red,
                              size: 35,
                            ),
                            number: Text(
                              _countryData['deaths'].toString(),
                              style: headingsTextStyle,
                            ),
                          ),
                          MyCard(
                            title: Text(
                              "Total Recovered",
                              style: headingsTextStyle,
                            ),
                            icon: Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.green,
                              size: 35,
                            ),
                            number: Text(
                              _countryData['recovered'].toString(),
                              style: headingsTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                                size: 25,
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Statewise(
                                      stateRawData: _stateData,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
