import 'package:BrandFarm/blocs/weather/bloc.dart';
import 'package:BrandFarm/repository/weather/weather_repository.dart';
import 'package:BrandFarm/utils/unicode/unicode_util.dart';
import 'package:BrandFarm/utils/weather/datetime.dart';
import 'package:BrandFarm/utils/weather/weather_icons.dart';
import 'package:BrandFarm/widgets/loading/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum weather_circle_type { sunset, prob_of_precip, precip, humidity, wind_info }

class WeatherDetail extends StatefulWidget {
  @override
  _WeatherDetailState createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  String fieldName = '한동이네 딸기 농장';
  String curr_addr = '경상북도 포항시';
  DateTime now = DateTime.now();

  // String curr_temp = '16' + degrees;
  // String maxTemp = '18';
  // String minTemp = '8';
  // String sunset = '6:31';

  // String prob_of_precip = '10';
  // String precip = '0';
  // String humidity = '29';
  // String wind_dir = '서남서';
  // String wind_speed = '2';

  WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
        cubit: _weatherBloc,
        builder: (context, state) {
          return (state.isLoading == true)
              ? Loading()
              : Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      fieldName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    actions: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 14,
                      ),
                      Center(
                          child: Text(
                        curr_addr,
                        style: TextStyle(fontSize: 12),
                      )),
                    ],
                  ),
                  body: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                              0.1032,
                              0.3218,
                              0.4822,
                              0.6571,
                              0.7919,
                            ],
                            colors: [
                              Color(0xFF82BFED),
                              Color(0xFF80D0F6),
                              Color(0xFF6BDCFF),
                              Color(0xFFADEBFF),
                              Color(0xFF7BE7FF),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                          child: ListView(
                            children: [
                              Container(
                                padding: EdgeInsets.all(0),
                                margin: EdgeInsets.all(0),
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FlatButton(
                                      padding: EdgeInsets.all(0),
                                      height: 30,
                                      minWidth: 1,
                                      child: Icon(
                                        Icons.refresh,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        print('refresh button pressed');
                                        _weatherBloc.add(Wait_Fetch_Weather());
                                        _weatherBloc.add(GetWeatherInfo());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  sky_type(
                                      precipType:
                                          state.precip_type.toString() ??
                                              'Error precip is empty',
                                      skyType: state.sky.toString() ??
                                          'Error sky is empty'),
                                  Text(
                                    state.curr_temp,
                                    style: TextStyle(
                                        fontSize: 70, color: Colors.white),
                                  ),
                                  Container(
                                    width: 140,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '최고: ' +
                                              doubleToInt(str: state.max_temp) +
                                              degrees,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '최저: ' +
                                              doubleToInt(str: state.min_temp) +
                                              degrees,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 45,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                          '일몰',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                        circle(
                                            info: state.sunset ?? '0630',
                                            type: weather_circle_type.sunset),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                          '강수확률',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                        circle(
                                            info: state.prob_of_precip,
                                            type: weather_circle_type
                                                .prob_of_precip),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                          '강수량',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                        circle(
                                            info: state.precip,
                                            type: weather_circle_type.precip),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                          '습도',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                        circle(
                                            info: state.humidity,
                                            type: weather_circle_type.humidity),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                          '바람',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                        circle(
                                            info: state.windSP,
                                            windDir: state.windDIR,
                                            type:
                                                weather_circle_type.wind_info),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                                thickness: 0.4,
                              ),
                              Container(
                                height: 80,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: state.long_temp.length,
                                        itemBuilder: (context, index) {
                                          if (index == 0) {
                                            return Row(
                                              children: [
                                                horizontal_view(
                                                  time: state.long_temp[index]
                                                      .fcstTime,
                                                  skyType: state.long_sky[index]
                                                      .fcstValue,
                                                  precipType: state
                                                      .long_precip_type[index]
                                                      .fcstValue,
                                                  temp: state.long_temp[index]
                                                      .fcstValue,
                                                  now: 1,
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Row(
                                              children: [
                                                horizontal_view(
                                                  time: state.long_temp[index]
                                                      .fcstTime,
                                                  skyType: state.long_sky[index]
                                                      .fcstValue,
                                                  precipType: state
                                                      .long_precip_type[index]
                                                      .fcstValue,
                                                  temp: state.long_temp[index]
                                                      .fcstValue,
                                                  now: 0,
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                                thickness: 0.4,
                              ),
                              Container(
                                height: 235,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      vertical_view(
                                        date: daysOfWeek(index: now.weekday),
                                        icon: long_sky_list(
                                            precip_type: state
                                                .precip_type_byDate[0]
                                                .fcstValue,
                                            skyType: state
                                                .sky_type_byDate[0].fcstValue,
                                            index: 0),
                                        info: doubleToInt(
                                          str: state.max_temp,
                                        ),
                                        info2: doubleToInt(
                                          str: state.min_temp,
                                        ),
                                      ),
                                      ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: 2,
                                        itemBuilder: (context, index) {
                                          return vertical_view(
                                            date: daysOfWeek(
                                                index: now
                                                    .add(Duration(
                                                        days: index + 1))
                                                    .weekday),
                                            icon: long_sky_list(
                                                precip_type: state
                                                    .precip_type_byDate[
                                                        index + 1]
                                                    .fcstValue,
                                                skyType: state
                                                    .sky_type_byDate[index + 1]
                                                    .fcstValue,
                                                index: index + 1),
                                            info: doubleToInt(
                                              str: state.long_maxTemp[index]
                                                  .fcstValue,
                                            ),
                                            info2: doubleToInt(
                                              str: state.long_minTemp[index]
                                                  .fcstValue,
                                            ),
                                          );
                                        },
                                      ),
                                      ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount:
                                            state.midFcstLandInfoAmList.length,
                                        itemBuilder: (context, index) {
                                          var max = state
                                              .midFcstInfoMaxList.entries
                                              .toList();
                                          var min = state
                                              .midFcstInfoMinList.entries
                                              .toList();
                                          var skyList = state
                                              .midFcstLandInfoAmList.entries
                                              .toList();
                                          return vertical_view(
                                            date: daysOfWeek(
                                                index: now
                                                    .add(Duration(
                                                        days: index + 3))
                                                    .weekday),
                                            icon: skyList[index].value,
                                            info: max[index].value,
                                            info2: min[index].value,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                                thickness: 0.4,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Color(0x30FFFFFF),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(150)),
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0x20FFFFFF),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(150)),
                        ),
                      ),
                    ],
                  ),
                );
        });
  }

  Widget sky_type({String precipType, String skyType}) {
    switch (precipType) {
      case '0':
        {
          if (skyType == '1') {
            return sky_text(text: '맑음');
          } else if (skyType == '3') {
            return sky_text(text: '구름많음');
          } else if (skyType == '4') {
            return sky_text(text: '흐림');
          } else {
            print('Unknown sky type');
          }
        }
        break;
      case '1':
      case '2':
      case '4':
      case '5':
      case '6':
        {
          return sky_text(text: '비');
        }
        break;
      case '3':
      case '7':
        {
          return sky_text(text: '눈');
        }
        break;
      default:
        {
          return sky_text(text: '--');
        }
        break;
    }
  }

  Widget sky_text({String text}) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, color: Colors.white),
    );
  }

//  enum weather_circle_type {sunset, prob_of_precip, precip, humidity, wind_info}

  Widget circle({String info, String windDir, weather_circle_type type}) {
    switch (type) {
      case weather_circle_type.sunset:
        {
          return circleStyle_row(
              info: getAmPm(time: info), info2: info, font_size: 15, time: 1);
        }
        break;
      case weather_circle_type.prob_of_precip:
        {
          return circleStyle_gradient(
              info: info, info2: '%', font_size: 24, font_size2: 15);
        }
        break;
      case weather_circle_type.precip:
        {
          return circleStyle_row(
              info: info, info2: ' mm', font_size: 24, font_size2: 15, time: 0);
        }
        break;
      case weather_circle_type.humidity:
        {
          return circleStyle_gradient(
              info: info, info2: '%', font_size: 24, font_size2: 15);
        }
        break;
      case weather_circle_type.wind_info:
        {
          return circleStyle_col(
              info: wind_dir(dir: windDir), info2: info + 'm/s', font_size: 15);
        }
        break;
      default:
        {
          return circleStyle_row(
              info: '-', info2: '-', font_size: 15, font_size2: 15, time: 0);
        }
        break;
    }
  }

  Widget circleStyle_gradient(
      {String info, String info2, double font_size, double font_size2}) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
//        color: Color(0x20FFFFFF),
        shape: BoxShape.circle,
        gradient: getGradient(num: info),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              info,
              style: TextStyle(
                color: Colors.white,
                fontSize: font_size,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              info2,
              style: TextStyle(
                color: Colors.white,
                fontSize: font_size2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient getGradient({String num}) {
    var amt = int.parse(num); // amount
    var tmp = 100 - amt;
    var amt_dec = tmp / 100; // decimal value
    // print('$amt, $amt_dec');
    switch (amt) {
      case 0:
        {
          return LinearGradient(
            colors: [
              Color(0x20FFFFFF),
              Color(0x20FFFFFF),
            ],
          );
        }
        break;
      case 100:
        {
          return LinearGradient(
            colors: [
              Color(0xFF75BDFF),
              Color(0xFF75BDFF),
            ],
          );
        }
        break;
      default:
        {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              amt_dec,
              amt_dec,
            ],
            colors: [
              Color(0x20FFFFFF),
              Color(0xFF75BDFF),
            ],
          );
        }
        break;
    }
  }

  Widget circleStyle_row(
      {String info,
      String info2,
      double font_size,
      double font_size2,
      int time}) {
    String tmpHour;
    String tmpMin;
    String iTime;
    if (time == 1) {
      tmpHour = info2.substring(0, 2);
      tmpMin = info2.substring(2);
      if (tmpHour.contains('10')) {
        iTime = tmpHour + ':' + tmpMin;
      } else if (tmpHour.contains('0')) {
        iTime = tmpHour.substring(1) + ':' + tmpMin;
      } else {
        iTime = tmpHour + ':' + tmpMin;
      }
    } else {
      ;
    }
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Color(0x20FFFFFF),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                info,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: font_size,
                  fontWeight: FontWeight.w500,
                ),
              ),
              (time == 0)
                  ? Text(
                      info2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: font_size2,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Text(
                      iTime,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: font_size2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget circleStyle_col(
      {String info, String info2, double font_size, double font_size2}) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Color(0x20FFFFFF),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              info,
              style: TextStyle(
                color: Colors.white,
                fontSize: font_size,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              info2,
              style: TextStyle(
                color: Colors.white,
                fontSize: font_size2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget weather_horizontal_list(
  //     {WeatherState state, String skyType, int now, int index}) {
  //   switch (state.long_precip_type[index].fcstValue.toString()) {
  //     case '0':
  //       {
  //         if (skyType == '1') {
  //           return horizontal_view(
  //             time: state.long_temp[index].fcstTime,
  //             icon: 'sun',
  //             temp: state.long_temp[index].fcstValue,
  //             now: now,
  //           );
  //         } else if (skyType == '3') {
  //           return horizontal_view(
  //             time: state.long_temp[index].fcstTime,
  //             icon: 'cloud_sun',
  //             temp: state.long_temp[index].fcstValue,
  //             now: now,
  //           );
  //         } else if (skyType == '4') {
  //           return horizontal_view(
  //             time: state.long_temp[index].fcstTime,
  //             icon: 'clouds',
  //             temp: state.long_temp[index].fcstValue,
  //             now: now,
  //           );
  //         } else {
  //           print('Unknown sky type');
  //         }
  //       }
  //       break;
  //     case '1':
  //     case '2':
  //     case '4':
  //     case '5':
  //     case '6':
  //       {
  //         return horizontal_view(
  //           time: state.long_temp[index].fcstTime,
  //           icon: 'rain',
  //           temp: state.long_temp[index].fcstValue,
  //           now: now,
  //         );
  //       }
  //       break;
  //     case '3':
  //     case '7':
  //       {
  //         return horizontal_view(
  //           time: state.long_temp[index].fcstTime,
  //           icon: 'snow_heavy',
  //           temp: state.long_temp[index].fcstValue,
  //           now: now,
  //         );
  //       }
  //       break;
  //     default:
  //       {
  //         return horizontal_view(
  //           time: '--',
  //           icon: 'all_inclusive',
  //           temp: '--',
  //           now: now,
  //         );
  //       }
  //       break;
  //   }
  // }

  // if now = 1 then now . . . else if now == 0 then not now
  Widget horizontal_view(
      {String time, String precipType, String skyType, String temp, int now}) {
    String half_time;
    String tmp;
    String iTime;
    tmp = time.substring(0, 2);
    if (tmp.contains('10')) {
      iTime = tmp;
    } else if (tmp.contains('0')) {
      iTime = tmp.substring(1);
    } else {
      iTime = tmp;
    }
    if (int.parse(iTime) >= 12) {
      half_time = '오후 ';
    } else {
      half_time = '오전 ';
    }
    return Container(
      // width: 25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          now == 0
              ? Text(
                  half_time + iTime + '시',
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  '지금',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
          // SizedBox(height: 10,),
          horizontal_view_icon(
            precip_type: precipType,
            skyType: skyType,
          ),
          // SizedBox(height: 10,),
          Row(
            children: [
              Text(
                temp,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                celcius,
                style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget horizontal_view_icon({String precip_type, String skyType, int index}) {
    switch (precip_type) {
      case '0':
        {
          if (int.parse(skyType) < 6) {
            return Icon(CupertinoIcons.sun_max);
          } else if (int.parse(skyType) > 5 && int.parse(skyType) < 9) {
            return Icon(CupertinoIcons.cloud_sun);
          } else if (int.parse(skyType) > 8) {
            return Icon(CupertinoIcons.cloud);
          } else {
            print('Unknown sky type');
          }
        }
        break;
      case '1':
      case '2':
      case '4':
      case '5':
      case '6':
        {
          return Icon(CupertinoIcons.cloud_rain_fill);
        }
        break;
      case '3':
      case '7':
        {
          return Icon(CupertinoIcons.cloud_snow_fill);
        }
        break;
      default:
        {
          return Icon(CupertinoIcons.infinite);
        }
        break;
    }
  }

  Widget vertical_view({String date, String icon, String info, String info2}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: TextStyle(color: Colors.white),
          ),
          vertical_view_icon(skyType: icon),
          Row(
            children: [
              Text(
                info,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                info2,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget vertical_view_icon({String skyType}) {
    switch (skyType) {
      case '맑음':
        {
          return Icon(CupertinoIcons.sun_max);
        }
        break;
      case '구름많음':
      case '흐림':
        {
          return Icon(CupertinoIcons.cloud_fill);
        }
        break;
      case '구름많고 비':
      case '흐리고 비':
      case '구름많고 비/눈':
      case '흐리고 비/눈':
      case '구름많고 소나기':
      case '비':
      case '흐리고 소나기':
        {
          return Icon(CupertinoIcons.cloud_rain_fill);
        }
        break;
      case '구름많고 눈':
      case '눈':
      case '흐리고 눈':
        {
          return Icon(CupertinoIcons.cloud_snow_fill);
        }
        break;
      default:
        {
          return Icon(CupertinoIcons.infinite);
        }
        break;
    }
  }
}
