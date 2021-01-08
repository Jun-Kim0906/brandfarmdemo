import 'package:BrandFarm/models/weather/weather_model.dart';
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
  List<Weather> long_precip = []; // R06
  List<Weather> long_precip_type = []; // PTY
  List<Weather> long_temp = []; // T3H
  List<Weather> long_humidity = []; // REH
  List<Weather> long_sky = []; // SKY
  List<Weather> long_wind_dir = []; // VEC
  List<Weather> long_wind_sp = []; // WSD

  Map midFcstInfoList = {};
  Map midFcstLandInfoList = {};

  String curr_temp;
  String sky;
  String max_temp;
  String min_temp;
  String precip_type;
  String prob_of_precip;
  String precip;
  String humidity;
  String windSP;
  String windDIR;
  String sunrise;
  String sunset;

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
        @required this.long_precip,
        @required this.long_precip_type,
        @required this.long_humidity,
        @required this.long_sky,
        @required this.long_wind_dir,
        @required this.long_wind_sp,
        @required this.long_temp,
        @required this.curr_temp,
        @required this.sky,
        @required this.max_temp,
        @required this.min_temp,
        @required this.precip_type,
        @required this.prob_of_precip,
        @required this.precip,
        @required this.humidity,
        @required this.windSP,
        @required this.windDIR,
        @required this.sunrise,
        @required this.sunset,
        @required this.midFcstInfoList,
        @required this.midFcstLandInfoList,
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
      long_precip: [],
      long_precip_type: [],
      long_temp: [],
      long_humidity: [],
      long_sky: [],
      long_wind_dir: [],
      long_wind_sp: [],
      midFcstInfoList: {},
      midFcstLandInfoList: {},
      curr_temp: '',
      sky: '',
      max_temp: '',
      min_temp: '',
      precip_type: '',
      prob_of_precip: '',
      precip: '',
      humidity: '',
      windSP: '',
      windDIR: '',
      sunrise: '',
      sunset: '',
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
    List<Weather> long_precip,
    List<Weather> long_precip_type,
    List<Weather> long_temp,
    List<Weather> long_humidity,
    List<Weather> long_sky,
    List<Weather> long_wind_dir,
    List<Weather> long_wind_sp,
    Map midFcstInfoList,
    Map midFcstLandInfoList,
    String curr_temp,
    String sky,
    String max_temp,
    String min_temp,
    String precip_type,
    String prob_of_precip,
    String precip,
    String humidity,
    String windSP,
    String windDIR,
    String sunrise,
    String sunset,
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
      long_precip: long_precip ?? this.long_precip,
      long_precip_type: long_precip_type ?? this.long_precip_type,
      long_temp: long_temp ?? this.long_temp,
      long_humidity: long_humidity ?? this.long_humidity,
      long_sky: long_sky ?? this.long_sky,
      long_wind_dir: long_wind_dir ?? this.long_wind_dir,
      long_wind_sp: long_wind_sp ?? this.long_wind_sp,
      curr_temp: curr_temp ?? this.curr_temp,
      sky: sky ?? this.sky,
      max_temp: max_temp ?? this.max_temp,
      min_temp: min_temp ?? this.min_temp,
      precip_type: precip_type ?? this.precip_type,
      prob_of_precip: prob_of_precip ?? this.prob_of_precip,
      precip: precip ?? this.precip,
      humidity: humidity ?? this.humidity,
      windSP: windSP ?? this.windSP,
      windDIR: windDIR ?? this.windDIR,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      midFcstInfoList: midFcstInfoList ?? this.midFcstInfoList,
      midFcstLandInfoList: midFcstLandInfoList ?? this.midFcstLandInfoList,
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
    List<Weather> long_precip,
    List<Weather> long_precip_type,
    List<Weather> long_temp,
    List<Weather> long_humidity,
    List<Weather> long_sky,
    List<Weather> long_wind_dir,
    List<Weather> long_wind_sp,
    Map midFcstInfoList,
    Map midFcstLandInfoList,
    String curr_temp,
    String sky,
    String max_temp,
    String min_temp,
    String precip_type,
    String prob_of_precip,
    String precip,
    String humidity,
    String windSP,
    String windDIR,
    String sunrise,
    String sunset,
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
      long_precip: long_precip,
      long_precip_type: long_precip_type,
      long_temp: long_temp,
      long_humidity: long_humidity,
      long_sky: long_sky,
      long_wind_dir: long_wind_dir,
      long_wind_sp: long_wind_sp,
      curr_temp: curr_temp,
      sky: sky,
      max_temp: max_temp,
      min_temp: min_temp,
      precip_type: precip_type,
      prob_of_precip: prob_of_precip,
      precip: precip,
      humidity: humidity,
      windSP: windSP,
      windDIR: windDIR,
      sunrise: sunrise,
      sunset: sunset,
      midFcstInfoList: midFcstInfoList,
      midFcstLandInfoList: midFcstLandInfoList,
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
    long_precip: ${long_precip.length},
    long_precip_type: ${long_precip_type.length},
    long_temp: ${long_temp.length},
    long_humidity: ${long_humidity.length},
    long_sky: ${long_sky.length},
    long_wind_dir: ${long_wind_dir.length},
    long_wind_sp: ${long_wind_sp.length},
    midFcstInfoList: ${midFcstInfoList.length},
    midFcstLandInfoList: ${midFcstLandInfoList.length},
    curr_temp: ${curr_temp},
    sky: ${sky},
    max_temp: ${max_temp},
    min_temp: ${min_temp},
    precip_type: ${precip_type},
    prob_of_precip: ${prob_of_precip},
    precip: ${precip},
    humidity: ${humidity},
    windSP: ${windSP},
    windDIR: ${windDIR},
    sunrise: ${sunrise},
    sunset: ${sunset},
    ''';
  }
}
