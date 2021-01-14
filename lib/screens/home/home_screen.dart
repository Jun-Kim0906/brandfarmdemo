//bloc
import 'package:BrandFarm/blocs/home/bloc.dart';
import 'package:BrandFarm/blocs/weather/bloc.dart';
import 'package:BrandFarm/blocs/authentication/bloc.dart';

//screen
import 'package:BrandFarm/layout/adaptive.dart';
import 'package:BrandFarm/screens/field/field_detail_screen.dart';

import 'package:BrandFarm/screens/notification/notification_list_screen.dart';
import 'package:flutter/cupertino.dart';

//flutter
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//util
import 'package:BrandFarm/utils/todays_date.dart';

import 'package:BrandFarm/widgets/brandfarm_icons.dart';
import 'package:BrandFarm/widgets/department_badge.dart';

//plugin
import 'package:badges/badges.dart';

import 'fm_home_screen_widget.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  HomeScreen({Key key, @required String name})
      : this.name = name,
        super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name;
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    this.name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return BlocListener(
      cubit: _homeBloc,
      listener: (BuildContext context, HomeState state) {},
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (isDesktop) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.indigoAccent,
                  ),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      AuthenticationLoggedOut(),
                    );
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ),
              body: Center(
                child: Text('test page'),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(
                  Icons.add,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (BuildContext context) =>
                            WeatherBloc()..add(Wait_Fetch_Weather()),
                        child: WeatherMain(),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(80.0),
                child: _AppBarContents(),
              ),
              body: ListView(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$year년 $month월 $day일 $weekday',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DepartmentBadge(
                                department: 'field',
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text('$name',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                ' 님, 안녕하세요',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Container(
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                            color: Color(0xffbfbfbf),
                            offset: Offset(0.0, 4.0),
                            spreadRadius: 2.0,
                            blurRadius: 4.0,
                          )
                        ]),
                        child: CircleAvatar(
                            radius: 34.0,
                            backgroundImage: NetworkImage(
                                'https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=800&q=70')),
                      )
                    ],
                  ),
                  SizedBox(height: 32.0),
                  _Announce(),
                  SizedBox(
                    height: 17,
                  ),
                  _HomeCalendar(),
                  SizedBox(
                    height: 19.0,
                  ),
                  FMHomeScreenWidget(),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (BuildContext context) =>
                            WeatherBloc()..add(Wait_Fetch_Weather()),
                        child: WeatherMain(),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class _AppBarContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              IconButton(
                iconSize: 60.0,
                icon: Image.asset('assets/brandfarm.png'),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    AuthenticationLoggedOut(),
                  );
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              Spacer(),
              Badge(
                position: BadgePosition.topEnd(top: 2, end: 8),
                badgeContent: Text(
                  '2',
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
                child: IconButton(
                  iconSize: 40.0,
                  icon: Icon(
                    Icons.notifications_none_sharp,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationListScreen(),
                      ),
                    );
                  },
                ),
                padding: EdgeInsets.all(4.5),
              ),
              IconButton(
                  iconSize: 35.0,
                  icon: Icon(
                    BrandFarmIcons.settings,
                  ),
                  onPressed: () {})
            ],
          ),
        )
      ],
    );
  }
}

class _Announce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.5), color: Color(0xfff5f5f5)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
        child: Row(
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: Color(0xfffdd015),
            ),
            SizedBox(
              width: 7.0,
            ),
            Expanded(
              child: Text(
                '$month/$day - test용입니다. 람쥐 원숭이 토끼 개구리 강아지 고양이 호랑이 백두산 호랑이 감자 고구',
                style: Theme.of(context)
                    .textTheme
                    .overline
                    .copyWith(color: Color(0xff8b8b8b)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: Theme.of(context).dividerColor)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 9.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 6.0),
                      child: Image(
                        width: 17.0,
                        height: 21.0,
                        image: AssetImage('assets/brandfarm.png'),
                      ),
                    ),
                    Text('캘린더', style: Theme.of(context).textTheme.headline5),
                    Spacer(),
                    Icon(
                      CupertinoIcons.calendar,
                      color: Color(0xff878787),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 9.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      color: Color(0xff878787),
                      icon: Icon(Icons.keyboard_arrow_left_sharp),
                      onPressed: () {}),
                  Text(
                    '$month월',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  IconButton(
                      color: Color(0xff878787),
                      icon: Icon(Icons.keyboard_arrow_right_sharp),
                      onPressed: () {}),
                ],
              ),
              SizedBox(
                height: 17.0,
              ),
              _CalendarDate(
                onPressed: () {
                  print('aaa');
                },
              ),
              SizedBox(
                height: 31.0,
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(left: 17.0, right: 13.0),
                child: Row(
                  children: [
                    Text(
                      '메모   ',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      '1',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Theme.of(context).colorScheme.secondary,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class _CalendarDate extends StatelessWidget {
  _CalendarDate({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  '$engWeekday',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.white),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '$day',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.white),
                ),
              ],
            )),
      ),
    );
  }
}
