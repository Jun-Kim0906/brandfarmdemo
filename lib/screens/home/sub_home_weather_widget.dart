import 'package:BrandFarm/blocs/weather/bloc.dart';
import 'package:BrandFarm/repository/weather/weather_repository.dart';
import 'package:BrandFarm/screens/weather/weather_detail_screen.dart';
import 'package:BrandFarm/utils/unicode/unicode_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubHomeWeatherWidget extends StatefulWidget {
  @override
  _SubHomeWeatherWidgetState createState() => _SubHomeWeatherWidgetState();
}

class _SubHomeWeatherWidgetState extends State<SubHomeWeatherWidget> {
  double width = 191;
  double height = 149;
  String addr = '경북 포항시';
  WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Card(
          // margin: EdgeInsets.all(0),
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: _weatherBloc,
                      child: WeatherDetail(),
                    )),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 14, 0, 4),
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.0,
                    1.0,
                  ],
                  colors: [
                    Color(0xFF3195DE),
                    Color(0xFF9AECFE),
                  ],
                ),
              ),
              child: Column(
                children: [
                  _upperHalf(state: state),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(thickness: 1, color: Colors.white,),
                  ),
                  _lowerHalf(state: state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _upperHalf({WeatherState state}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(addr,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 10, color: Colors.white),
                  ),
                  SizedBox(width: 6.25,),
                  Icon(Icons.near_me_outlined, color: Colors.white, size: 10,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    state.curr_temp,
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(width: 1,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 36,
                        child: Text(degrees, style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Icon(Icons.wb_sunny_outlined, size: 17, color: Colors.white,),
                horizontal_view_icon(
                  precip_type: state.precip_type,
                  skyType: state.sky,
                ),
                sky_type(
                    precipType: state.precip_type.toString(),
                    skyType: state.sky.toString()
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '최고: ' + doubleToInt(str: state.max_temp) + degrees,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white),
                    ),
                    SizedBox(width: 7,),
                    Text(
                      '최저: ' + doubleToInt(str: state.min_temp) + degrees,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _lowerHalf({WeatherState state}) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: state.long_temp.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Row(
              children: [
                SizedBox(
                  width: 14,
                ),
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
                  width: 23,
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
                  width: 23,
                ),
              ],
            );
          }
        },
      ),
    );
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
      style: TextStyle(fontSize: 12, color: Colors.white),
    );
  }

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
          Text(
            half_time + iTime + '시',
            style: TextStyle(color: Colors.white, fontSize: 10),
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
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                degrees,
                style: TextStyle(
                    fontSize: 4.0,
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
            return Image.asset(
              'assets/weather_image/sunny.png',
              width: 21.0,
            );
          } else if (int.parse(skyType) > 5 && int.parse(skyType) < 9) {
            return Image.asset(
              'assets/weather_image/sunny.png',
              width: 21.0,
            );
          } else if (int.parse(skyType) > 8) {
            return Image.asset(
              'assets/weather_image/cloudy.png',
              width: 21.0,
            );
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
          return Image.asset(
            'assets/weather_image/rainy.png',
            width: 21.0,
          );
        }
        break;
      case '3':
      case '7':
        {
          return Image.asset(
            'assets/weather_image/snowy.png',
            width: 21.0,
          );
        }
        break;
      default:
        {
          return Icon(CupertinoIcons.infinite, color: Colors.white,);
        }
        break;
    }
  }
}
