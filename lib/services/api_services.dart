import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class FetchData {
  String countryUrl;
  String statesUrl;
  FetchData({this.countryUrl, this.statesUrl});

  Future getCountryData() async {
    http.Response response = await http.get(Uri.encodeFull(countryUrl),
        headers: {"Accept": "application/json"});
    var data = response.body;
    return data;
  }

  Future getStateData() async {
    http.Response response = await http.get(Uri.encodeFull(statesUrl),
        headers: {"Accept": "application/json"});
    var stateData = response.body;
    var decodedStateData = json.decode(stateData);
    return decodedStateData;
  }
}
