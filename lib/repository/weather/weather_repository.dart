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

String regionCode({String region}) {
  switch (region) {
    case '서울':
      {
        return '11B10101';
      }
      break;
    case '인천':
      {
        return '11B20201';
      }
      break;
    case '수원':
      {
        return '11B20601';
      }
      break;
    case '파주':
      {
        return '11B20305';
      }
      break;
    case '춘천':
      {
        return '11D10301';
      }
      break;
    case '원주':
      {
        return '11D10401';
      }
      break;
    case '강릉':
      {
        return '11D20501';
      }
      break;
    case '대전':
      {
        return '11C20401';
      }
      break;
    case '서산':
      {
        return '11C20101';
      }
      break;
    case '세종':
      {
        return '11C20404';
      }
      break;
    case '서귀포':
      {
        return '11G00401';
      }
      break;
    case '광주':
      {
        return '11F20501';
      }
      break;
    case '목포':
      {
        return '21F20801';
      }
      break;
    case '여수':
      {
        return '11F20401';
      }
      break;
    case '전주':
      {
        return '11F10201';
      }
      break;
    case '군산':
      {
        return '21F10501';
      }
      break;
    case '부산':
      {
        return '11H20201';
      }
      break;
    case '울산':
      {
        return '11H20101';
      }
      break;
    case '창원':
      {
        return '11H20301';
      }
      break;
    case '대구':
      {
        return '11H10701';
      }
      break;
    case '청주':
      {
        return '11C10301';
      }
      break;
    case '제주':
      {
        return '11G00201';
      }
      break;
    case '안동':
      {
        return '11H10501';
      }
      break;
    case '포항':
      {
        return '11H10201';
      }
      break;
    default:
      {
        return '--';
      }
      break;
  }
}
