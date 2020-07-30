// To parse this JSON data, do
//
//     final walls = wallsFromJson(jsonString);

import 'dart:convert';

Walls wallsFromJson(String str) => Walls.fromJson(json.decode(str));

String wallsToJson(Walls data) => json.encode(data.toJson());

class Walls {
  Walls({
    this.updated,
    this.total,
    this.states,
  });

  int updated;
  Total total;
  List<Total> states;

  factory Walls.fromJson(Map<String, dynamic> json) => Walls(
        updated: json["updated"],
        total: Total.fromJson(json["total"]),
        states: List<Total>.from(json["states"].map((x) => Total.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "updated": updated,
        "total": total.toJson(),
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
      };
}

class Total {
  Total({
    this.state,
    this.active,
    this.recovered,
    this.deaths,
    this.cases,
    this.todayActive,
    this.todayRecovered,
    this.todayDeaths,
    this.todayCases,
  });

  String state;
  int active;
  int recovered;
  int deaths;
  int cases;
  int todayActive;
  int todayRecovered;
  int todayDeaths;
  int todayCases;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        state: json["state"] == null ? null : json["state"],
        active: json["active"],
        recovered: json["recovered"],
        deaths: json["deaths"],
        cases: json["cases"],
        todayActive: json["todayActive"],
        todayRecovered: json["todayRecovered"],
        todayDeaths: json["todayDeaths"],
        todayCases: json["todayCases"],
      );

  Map<String, dynamic> toJson() => {
        "state": state == null ? null : state,
        "active": active,
        "recovered": recovered,
        "deaths": deaths,
        "cases": cases,
        "todayActive": todayActive,
        "todayRecovered": todayRecovered,
        "todayDeaths": todayDeaths,
        "todayCases": todayCases,
      };
}
