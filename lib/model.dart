// To parse this JSON data, do
//
//     final states = statesFromJson(jsonString);

import 'dart:convert';

States statesFromJson(String str) => States.fromJson(json.decode(str));

String statesToJson(States data) => json.encode(data.toJson());

class States {
  States({
    this.updated,
    this.total,
    this.states,
  });

  int updated;
  Total total;
  List<Total> states;

  factory States.fromJson(Map<String, dynamic> json) => States(
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
    this.total,
  });

  String state;
  int active;
  int recovered;
  int deaths;
  int total;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        state: json["state"] == null ? null : json["state"],
        active: json["active"],
        recovered: json["recovered"],
        deaths: json["deaths"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "state": state == null ? null : state,
        "active": active,
        "recovered": recovered,
        "deaths": deaths,
        "total": total,
      };
}
