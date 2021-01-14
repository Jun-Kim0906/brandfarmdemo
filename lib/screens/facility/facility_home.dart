import 'package:BrandFarm/blocs/weather/bloc.dart';
import 'package:BrandFarm/repository/weather/weather_repository.dart';
import 'package:BrandFarm/screens/test/test_screen.dart';
// import 'package:BrandFarm/screens/test/test_screen.dart';
import 'package:BrandFarm/screens/weather/weather_detail_screen.dart';
import 'package:BrandFarm/utils/unicode/unicode_util.dart';
import 'package:BrandFarm/utils/weather/weather_icons.dart';
import 'package:BrandFarm/widgets/loading/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FacilityHome extends StatefulWidget {
  @override
  _FacilityHomeState createState() => _FacilityHomeState();
}

class _FacilityHomeState extends State<FacilityHome> {
  String fieldName = '한동이네 딸기 농장';
  String curr_addr = '경상북도 포항시';

  // String curr_temp = '16' + degrees;
  // String maxTemp = '18';
  // String minTemp = '8';

  var height;
  var width;

  WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    _weatherBloc.add(GetWeatherInfo());
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocBuilder<WeatherBloc, WeatherState>(
        cubit: _weatherBloc,
        builder: (context, state) {
          return Scaffold(
              body: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 200.0,
                        floating: true,
                        pinned: true,
                        snap: true,
                        actionsIconTheme: IconThemeData(opacity: 0.0),
                        flexibleSpace: Stack(
                          children: <Widget>[
                            Positioned.fill(
                                child: Hero(
                                  tag: 123,
                                  child: Image.asset(
                                    'assets/strawberry_farm.png',
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Positioned(
                              bottom: 22,
                              left: width/3,
                              child: Text(
                                '한동이네 딸기 농장',
                                style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: new EdgeInsets.all(16.0),
                        sliver: new SliverList(
                          delegate: new SliverChildListDelegate([
                            TabBar(
                              labelColor: Colors.black87,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                new Tab(icon: new Icon(Icons.info), text: "Tab 1"),
                                new Tab(
                                    icon: new Icon(Icons.lightbulb_outline),
                                    text: "Tab 2"),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ];
                  },
                  body: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: <Widget>[
                                Card(
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
                                      width: width,
                                      height: 282,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [
                                            0.0611,
                                            0.3129,
                                            0.5495,
                                          ],
                                          colors: [
                                            Color(0xFF82BFED),
                                            Color(0xFF80D0F6),
                                            Color(0xFF7EDFFE),
                                          ],
                                        ),
                                      ),
                                      child: ListView(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(0),
                                            margin: EdgeInsets.all(0),
                                            height: 30,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                                    fontSize: 70,
                                                    color: Colors.white),
                                              ),
                                              Container(
                                                width: 140,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      '최고: ' + doubleToInt(str: state.max_temp) + degrees,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      '최저: ' + doubleToInt(str: state.min_temp) + degrees,
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Card(
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
                                              builder: (context) =>
                                                  BlocProvider.value(
                                                    value: _weatherBloc,
                                                    child: WeatherDetail(),
                                                  )),
                                        );
                                      },
                                      child: Container(
                                        width: width,
                                        height: 113,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Color(0xFF00B8D4),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          height: 80,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: CupertinoScrollbar(
                                                  // controller: _scrollController,
                                                  // isAlwaysShown: true,
                                                  child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    shrinkWrap: true,
                                                    physics: ClampingScrollPhysics(),
                                                    itemCount: state.long_temp.length,
                                                    itemBuilder: (context, index) {
                                                      if (index == 0) {
                                                        return Row(
                                                          children: [
                                                            weather_horizontal_list(
                                                                state: state,
                                                                skyType: state
                                                                    .long_sky[index]
                                                                    .fcstValue,
                                                                now: 1,
                                                                index: index),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                          ],
                                                        );
                                                      } else {
                                                        return Row(
                                                          children: [
                                                            weather_horizontal_list(
                                                                state: state,
                                                                skyType: state
                                                                    .long_sky[index]
                                                                    .fcstValue,
                                                                now: 0,
                                                                index: index),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0.0,
                                  left: 0.0,
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      color: Color(0x30FFFFFF),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(150),
                                          topLeft: Radius.circular(15)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0.0,
                                  left: 0.0,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0x20FFFFFF),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(150),
                                          topLeft: Radius.circular(15)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
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

  Widget weather_horizontal_list(
      {WeatherState state, String skyType, int now, int index}) {
    switch (state.long_precip_type[index].fcstValue.toString()) {
      case '0':
        {
          if (skyType == '1') {
            return horizontal_view(
              time: state.long_temp[index].fcstTime,
              icon: 'sun',
              temp: state.long_temp[index].fcstValue,
              now: now,
            );
          } else if (skyType == '3') {
            return horizontal_view(
              time: state.long_temp[index].fcstTime,
              icon: 'cloud_sun',
              temp: state.long_temp[index].fcstValue,
              now: now,
            );
          } else if (skyType == '4') {
            return horizontal_view(
              time: state.long_temp[index].fcstTime,
              icon: 'clouds',
              temp: state.long_temp[index].fcstValue,
              now: now,
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
          return horizontal_view(
            time: state.long_temp[index].fcstTime,
            icon: 'rain',
            temp: state.long_temp[index].fcstValue,
            now: now,
          );
        }
        break;
      case '3':
      case '7':
        {
          return horizontal_view(
            time: state.long_temp[index].fcstTime,
            icon: 'snow_heavy',
            temp: state.long_temp[index].fcstValue,
            now: now,
          );
        }
        break;
      default:
        {
          return horizontal_view(
            time: '--',
            icon: 'all_inclusive',
            temp: '--',
            now: now,
          );
        }
        break;
    }
  }

  Widget horizontal_view({String time, String icon, String temp, int now}) {
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
            style: TextStyle(
              // fontSize: 14,
                color: Colors.white),
          )
              : Text(
            '지금',
            style: TextStyle(
              // fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: 10,),
          (icon == 'sun')
              ? Image.asset('assets/weather_image/sunny.png', width: 24.0,)
              : (icon == 'cloud_sun')
              ? Image.asset('assets/weather_image/sunny.png', width: 24.0,)
              : (icon == 'clouds')
              ? Image.asset('assets/weather_image/cloudy.png', width: 24.0,)
              : (icon == 'rain')
              ? Image.asset('assets/weather_image/rainy.png', width: 24.0,)
              : (icon == 'snow_heavy')
              ? Image.asset('assets/weather_image/snowy.png', width: 24.0,)
              : Icon(
            Icons.all_inclusive,
            color: Colors.yellow,
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
}
