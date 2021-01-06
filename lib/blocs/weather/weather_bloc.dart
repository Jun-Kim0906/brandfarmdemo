import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:brandfarmdemo/blocs/weather/bloc.dart';
import 'package:brandfarmdemo/models/weather/weather_model.dart';
import 'package:brandfarmdemo/repository/weather/weather_repository.dart';
import 'package:brandfarmdemo/utils/weather/api_addr.dart';
import 'package:brandfarmdemo/utils/weather/convert_grid_gps.dart';
import 'package:http/http.dart' as http;

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState.empty());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeatherInfo) {
      yield* _mapGetWeatherInfoToState(event);
    } else if (event is Wait_Fetch_Weather) {
      yield* _mapWait_Fetch_WeatherToState();
    }
  }

  Stream<WeatherState> _mapWait_Fetch_WeatherToState() async* {
    yield state.update(isLoading: true);
  }

  Stream<WeatherState> _mapGetWeatherInfoToState(GetWeatherInfo event) async* {
    List<Weather> short_precip = []; // RN1
    List<Weather> short_precip_type = []; // PTY
    List<Weather> short_temp = []; // T1H
    List<Weather> short_humidity = []; // REH
    List<Weather> short_sky = []; // SKY
    List<Weather> short_eastToWest_wind = []; // UUU
    List<Weather> short_southToNorth_wind = []; // VVV

    List<Weather> long_probOfPrecip = []; // POP
    List<Weather> long_maxTemp = []; // TMX
    List<Weather> long_minTemp = []; // TMN

    // testing values
    String str_lat = '36.1031';
    String str_lon = '129.3884';
    String base_date = '20210106';
    String base_time = '0630';

    double num_lat = double.parse(str_lat);
    double num_lon = double.parse(str_lon);

    // 103, 96
    LatXLngY point = convertGridGPS(0, num_lat, num_lon);
    int gridX = point.x;
    int gridY = point.y;
    // print('$gridX, $gridY');

    http.Response shortWeatherInfo;

    shortWeatherInfo = await http.get(
        '$ultraSrtFcstHeader&base_date=$base_date&base_time=$base_time&nx=$gridX&ny=$gridY&');

    if (shortWeatherInfo.statusCode == 200) {
      json
          .decode(shortWeatherInfo.body)['response']['body']['items']['item']
          .forEach((dynamic data) {
        if (data['category'] == "RN1") {
          short_precip.add(Weather.fromJson(data));
        } else if (data['category'] == "PTY") {
          short_precip_type.add(Weather.fromJson(data));
        } else if (data['category'] == "T1H") {
          short_temp.add(Weather.fromJson(data));
        } else if (data['category'] == "REH") {
          short_humidity.add(Weather.fromJson(data));
        } else if (data['category'] == "SKY") {
          short_sky.add(Weather.fromJson(data));
        } else if (data['category'] == "UUU") {
          short_eastToWest_wind.add(Weather.fromJson(data));
        } else if (data['category'] == "VVV") {
          short_southToNorth_wind.add(Weather.fromJson(data));
        } else {
          ;
        }
      });
      // weather_info = await fetchWeatherInfo(weatherInfo);
    } else {
      throw Exception('Failed to fetch short weather info');
    }

    http.Response longWeatherInfo;

    longWeatherInfo = await http.get(
        '$villageFcstHeader&base_date=$base_date&base_time=$base_time&nx=$gridX&ny=$gridY&');

    if (shortWeatherInfo.statusCode == 200) {
      json
          .decode(shortWeatherInfo.body)['response']['body']['items']['item']
          .forEach((dynamic data) {
        if (data['category'] == "POP") {
          long_probOfPrecip.add(Weather.fromJson(data));
        } else if (data['category'] == "TMX") {
          long_maxTemp.add(Weather.fromJson(data));
        } else if (data['category'] == "TMN") {
          long_minTemp.add(Weather.fromJson(data));
        } else {
          ;
        }
      });
      // weather_info = await fetchWeatherInfo(weatherInfo);
    } else {
      throw Exception('Failed to fetch long weather info');
    }


    yield state.update(
      isLoading: false,
      short_eastToWest_wind: short_eastToWest_wind,
      short_humidity: short_humidity,
      short_precip: short_precip,
      short_precip_type: short_precip_type,
      short_sky: short_sky,
      short_southToNorth_wind: short_southToNorth_wind,
      short_temp: short_temp,
      long_maxTemp: long_maxTemp,
      long_minTemp: long_minTemp,
      long_probOfPrecip: long_probOfPrecip,
    );
  }
}
