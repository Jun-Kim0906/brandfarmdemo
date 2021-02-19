import 'package:BrandFarm/blocs/weather/bloc.dart';
import 'package:BrandFarm/repository/weather/weather_repository.dart';
import 'package:BrandFarm/screens/weather/weather_detail_screen.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/utils/unicode/unicode_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubHomeWeatherWidget extends StatefulWidget {
  @override
  _SubHomeWeatherWidgetState createState() => _SubHomeWeatherWidgetState();
}

class _SubHomeWeatherWidgetState extends State<SubHomeWeatherWidget> {
  double height = 97;
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
        return InkWell(
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
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  offset: Offset(0, 4),
                  blurRadius: 4.0,
                )
              ],
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
            child: _upperHalf(state: state),
          ),
        );
      },
    );
  }

  Widget _upperHalf({WeatherState state}) {
    return Padding(
      padding: const EdgeInsets.only(left: 13),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 13,),
              Row(
                children: [
                  Text(addr,
                    style: Theme.of(context).textTheme.subtitle1
                        .copyWith(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  SizedBox(width: 6.25,),
                  Icon(Icons.near_me_outlined, color: Colors.white, size: 10,),
                ],
              ),
              Row(
                children: [
                  Text(
                    state.curr_temp,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 60,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  ),
                  SizedBox(width: 1,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        child: Text(degrees, style: TextStyle(
                            fontSize: 30,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Icon(Icons.wb_sunny_outlined, size: 17, color: Colors.white,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    horizontal_view_icon(
                      precip_type: state.precip_type,
                      skyType: state.sky,
                    ),
                    sky_type(
                        precipType: state.precip_type.toString(),
                        skyType: state.sky.toString()
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '최고: ' + doubleToInt(str: state.max_temp) + degrees,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    SizedBox(width: 7,),
                    Text(
                      '최저: ' + doubleToInt(str: state.min_temp) + degrees,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    SizedBox(width: 10,),
                  ],
                ),
                SizedBox(height: 12,),
              ],
            ),
          ),
        ],
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
      style: Theme.of(context).textTheme.bodyText1
          .copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
    );
  }

  Widget horizontal_view_icon({String precip_type, String skyType, int index}) {
    switch (precip_type) {
      case '0':
        {
          if (int.parse(skyType) < 6) {
            return Image.asset(
              'assets/weather_image/sunny.png',
              width: 50.0,
            );
          } else if (int.parse(skyType) > 5 && int.parse(skyType) < 9) {
            return Image.asset(
              'assets/weather_image/sunny.png',
              width: 50.0,
            );
          } else if (int.parse(skyType) > 8) {
            return Image.asset(
              'assets/weather_image/cloudy.png',
              width: 50.0,
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
            width: 50.0,
          );
        }
        break;
      case '3':
      case '7':
        {
          return Image.asset(
            'assets/weather_image/snowy.png',
            width: 50.0,
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
