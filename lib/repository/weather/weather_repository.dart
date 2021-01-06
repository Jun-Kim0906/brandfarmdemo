

import 'dart:convert';

import 'package:brandfarmdemo/models/weather/weather_model.dart';
import 'package:http/http.dart' as http;

Future<List<Weather>> fetchWeatherInfo(http.Response response) async {
  List responseJson = json.decode(response.body)['response']['body']['items'];
  return responseJson.map((item) => new Weather.fromJson(item)).toList();
}