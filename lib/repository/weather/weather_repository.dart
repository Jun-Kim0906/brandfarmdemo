

import 'dart:convert';

import 'package:BrandFarm/models/weather/weather_model.dart';
import 'package:http/http.dart' as http;

Weather _data;
void setWeatherData(Weather data) async {
_data = data;
}

Weather getWeatherData() {
return _data;
}

Future<List<Weather>> fetchWeatherInfo(http.Response response) async {
  List<Weather> info = [];
  json
      .decode(response.body)['response']['body']['items']['item']
      .forEach((dynamic data) {
    info.add(Weather.fromJson(data));
  });
  return info;
}

// Future<List<Weather>> fetchWeatherInfo(http.Response response) async {
//   List responseJson = json.decode(response.body);
//   return responseJson.map((item) => new Weather.fromJson(item)).toList();
// }