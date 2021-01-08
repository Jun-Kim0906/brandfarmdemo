import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:BrandFarm/blocs/weather/bloc.dart';
import 'package:BrandFarm/models/weather/weather_model.dart';
import 'package:BrandFarm/repository/weather/weather_repository.dart';
import 'package:BrandFarm/utils/weather/api_addr.dart';
import 'package:BrandFarm/utils/weather/convert_grid_gps.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState.empty());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeatherInfo) {
      yield* _mapGetWeatherInfoToState();
    } else if (event is Wait_Fetch_Weather) {
      yield* _mapWait_Fetch_WeatherToState();
    }
  }

  Stream<WeatherState> _mapWait_Fetch_WeatherToState() async* {
    yield state.update(isLoading: true);
  }

  Stream<WeatherState> _mapGetWeatherInfoToState() async* {
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
    String max_temp;
    String min_temp;
    String sky;
    String precip_type;
    String prob_of_precip;
    String precip;
    String humidity;
    String windSP;
    String windDIR;
    String sun_rise;
    String sun_set;

    // testing values
    String str_lat = '36.1031';
    String str_lon = '129.3884';
    String location = '포항';
    // String lat_min = '3606';
    // String lon_min = '12923';
    String lat_min = '3601';
    String lon_min = '12920';
    String base_date = '20210108';
    String short_base_time = '0630';
    String long_base_time = '0500';
    // String regId = '11H10201';
    String regId = regionCode(region: '포항',);
    String dt = '202101080600';
    String regLnCode = regionLandCode(region: '경상북도');

    double num_lat = double.parse(str_lat);
    double num_lon = double.parse(str_lon);

    // 103, 96
    LatXLngY point = convertGridGPS(0, num_lat, num_lon);
    int gridX = point.x;
    int gridY = point.y;
    // print('$gridX, $gridY');

    http.Response shortWeatherInfo;

    shortWeatherInfo = await http.get(
        '$ultraSrtFcstHeader&base_date=$base_date&base_time=$short_base_time&nx=$gridX&ny=$gridY&');

    // print('$ultraSrtFcstHeader&base_date=$base_date&base_time=$short_base_time&nx=$gridX&ny=$gridY&');

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
        '$villageFcstHeader&base_date=$base_date&base_time=$long_base_time&nx=$gridX&ny=$gridY&');

    // print('$villageFcstHeader&base_date=$base_date&base_time=$long_base_time&nx=$gridX&ny=$gridY&');

    if (longWeatherInfo.statusCode == 200) {
      json
          .decode(longWeatherInfo.body)['response']['body']['items']['item']
          .forEach((dynamic data) {
        if (data['category'] == "POP") {
          long_probOfPrecip.add(Weather.fromJson(data));
        } else if (data['category'] == "TMX") {
          long_maxTemp.add(Weather.fromJson(data));
        } else if (data['category'] == "TMN") {
          long_minTemp.add(Weather.fromJson(data)); ///////////
        } else if (data['category'] == "R06") {
          long_precip.add(Weather.fromJson(data));
        } else if (data['category'] == "PTY") {
          long_precip_type.add(Weather.fromJson(data));
        } else if (data['category'] == "T3H") {
          long_temp.add(Weather.fromJson(data));
        } else if (data['category'] == "REH") {
          long_humidity.add(Weather.fromJson(data));
        } else if (data['category'] == "SKY") {
          long_sky.add(Weather.fromJson(data));
        } else if (data['category'] == "VEC") {
          long_wind_dir.add(Weather.fromJson(data));
        } else if (data['category'] == "WSD") {
          long_wind_sp.add(Weather.fromJson(data));
        } else {
          // print(data['category']);
          ;
        }
      });
      // weather_info = await fetchWeatherInfo(weatherInfo);
    } else {
      throw Exception('Failed to fetch long weather info');
    }

    // print(short_southToNorth_wind.cast());
    // print(short_eastToWest_wind.cast());
    // print(short_sky.cast());
    // print(short_humidity.cast());
    // print(short_temp.cast());
    // print(short_temp.cast());
    // print(short_precip_type.cast());
    // print(short_precip.cast());
    // print(long_minTemp.cast());
    // print(long_maxTemp.cast());
    // print(long_probOfPrecip.cast());

    curr_temp = long_temp.first.fcstValue;
    sky = long_sky.first.fcstValue;
    max_temp = long_maxTemp.first.fcstValue;
    min_temp = long_minTemp.first.fcstValue;
    precip_type = long_precip_type.first.fcstValue;
    prob_of_precip = long_probOfPrecip.first.fcstValue;
    precip = long_precip.first.fcstValue;
    humidity = long_humidity.first.fcstValue;
    windSP = long_wind_sp.first.fcstValue;
    windDIR = long_wind_dir.first.fcstValue;

    http.Response sunRiseSetInfo;
    // sunRiseSetInfo = await http.get(
    //     '$riseSetLCInfoHeader&locdate=$base_date&hardness=$lon_min&latitude=$lat_min&dnYn=N');

    var url = Uri.parse('$riseSetAreaInfoHeader&locdate=$base_date&location=$location');
    sunRiseSetInfo = await http.get(url.toString());

    // print(url);

    if (sunRiseSetInfo.statusCode == 200) {
      Xml2Json xml2Json = Xml2Json();
      xml2Json.parse(sunRiseSetInfo.body);
      var jsonString = xml2Json.toParker();
      sun_set = jsonDecode(jsonString)['response']['body']['items']['item']['sunset'];
      sun_rise = jsonDecode(jsonString)['response']['body']['items']['item']['sunrise'];
    } else {
      throw Exception('Failed to fetch sun rise & set info');
    }
    // print('$sun_set, $sun_rise');

    http.Response midFcstInfo;
    midFcstInfo = await http.get('$midFcstInfoHeader&regId=$regId&tmFc=$dt');
    // print('$midFcstInfoHeader&regId=$regId&tmFc=$dt');

    if (midFcstInfo.statusCode == 200) {
      Xml2Json xmlToJson = Xml2Json();
      xmlToJson.parse(midFcstInfo.body);
      var tmp = xmlToJson.toParker();
      Map map = jsonDecode(tmp)['response']['body']['items']['item'];
      map.remove('regId');
      map.removeWhere((key, value) => key.contains('Low') || key.contains('High'));
      midFcstInfoList = map;
      // print(midFcstInfoList);
    } else {
      throw Exception('Failed to fetch mid fcst info');
    }

    http.Response midFcstLandInfo;
    midFcstLandInfo = await http.get('$midFcstLandInfoHeader&regId=$regLnCode&tmFc=$dt');
    print('$midFcstLandInfoHeader&regId=$regLnCode&tmFc=$dt');

    if (midFcstLandInfo.statusCode == 200) {
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(midFcstLandInfo.body);
      var tmp = xml2json.toParker();
      Map map = jsonDecode(tmp)['response']['body']['items']['item'];
      // print(map);
      map.removeWhere((key, value) => key.startsWith('r'));
      midFcstLandInfoList = map;
      // print(midFcstLandInfoList);
    } else {
      throw Exception('Failed to fetch mid fcst land info');
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
      long_precip: long_precip,
      long_humidity: long_humidity,
      long_precip_type: long_precip_type,
      long_sky: long_sky,
      long_temp: long_temp,
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
      sunrise: sun_rise.toString(),
      sunset: sun_set.toString(),
      midFcstInfoList: midFcstInfoList,
      midFcstLandInfoList: midFcstLandInfoList,
    );
  }
}
