import 'package:brandfarmdemo/models/weather/weather_model.dart';
import 'package:flutter/cupertino.dart';
//import 'package:friendlyeats/src/model/filter.dart';
import 'package:meta/meta.dart';

class WeatherState {
  final bool isLoading;
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

  WeatherState(
      {@required this.isLoading,
        @required this.short_precip,
        @required this.short_precip_type,
        @required this.short_temp,
        @required this.short_humidity,
        @required this.short_sky,
        @required this.short_eastToWest_wind,
        @required this.short_southToNorth_wind,
        @required this.long_probOfPrecip,
        @required this.long_maxTemp,
        @required this.long_minTemp,
      });

  factory WeatherState.empty() {
    return WeatherState(
      isLoading: false,
      short_precip: [],
      short_precip_type: [],
      short_temp: [],
      short_humidity: [],
      short_sky: [],
      short_eastToWest_wind: [],
      short_southToNorth_wind: [],
      long_probOfPrecip: [],
      long_maxTemp: [],
      long_minTemp: [],
    );
  }

  WeatherState copyWith({
    bool isLoading,
    List<Weather> short_precip,
    List<Weather> short_precip_type,
    List<Weather> short_temp,
    List<Weather> short_humidity,
    List<Weather> short_sky,
    List<Weather> short_eastToWest_wind,
    List<Weather> short_southToNorth_wind,
    List<Weather> long_probOfPrecip,
    List<Weather> long_maxTemp,
    List<Weather> long_minTemp,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      short_precip: short_precip ?? this.short_precip,
      short_precip_type: short_precip_type ?? this.short_precip_type,
      short_temp: short_temp ?? this.short_temp,
      short_humidity: short_humidity ?? this.short_humidity,
      short_sky: short_sky ?? this.short_sky,
      short_eastToWest_wind: short_eastToWest_wind ?? this.short_eastToWest_wind,
      short_southToNorth_wind: short_southToNorth_wind ?? this.short_southToNorth_wind,
      long_probOfPrecip: long_probOfPrecip ?? this.long_probOfPrecip,
      long_maxTemp: long_maxTemp ?? this.long_maxTemp,
      long_minTemp: long_minTemp ?? this.long_minTemp,
    );
  }

  WeatherState update({
    bool isLoading,
    List<Weather> short_precip,
    List<Weather> short_precip_type,
    List<Weather> short_temp,
    List<Weather> short_humidity,
    List<Weather> short_sky,
    List<Weather> short_eastToWest_wind,
    List<Weather> short_southToNorth_wind,
    List<Weather> long_probOfPrecip,
    List<Weather> long_maxTemp,
    List<Weather> long_minTemp,
  }) {
    return copyWith(
      isLoading: isLoading,
      short_precip: short_precip,
      short_precip_type: short_precip_type,
      short_temp: short_temp,
      short_humidity: short_humidity,
      short_sky: short_sky,
      short_eastToWest_wind: short_eastToWest_wind,
      short_southToNorth_wind: short_southToNorth_wind,
      long_probOfPrecip: long_probOfPrecip,
      long_maxTemp: long_maxTemp,
      long_minTemp: long_minTemp,
    );
  }

  @override
  String toString() {
    return '''WeatherState{
    isLoading: $isLoading,
    short_precip: ${short_precip.length},
    short_precip_type: ${short_precip_type.length},
    short_temp: ${short_temp.length},
    short_humidity: ${short_humidity.length},
    short_sky: ${short_sky.length},
    short_eastToWest_wind: ${short_eastToWest_wind.length},
    short_southToNorth_wind: ${short_southToNorth_wind.length},
    long_probOfPrecip: ${long_probOfPrecip.length},
    long_maxTemp: ${long_maxTemp.length},
    long_minTemp: ${long_minTemp.length},
    ''';
  }
}
