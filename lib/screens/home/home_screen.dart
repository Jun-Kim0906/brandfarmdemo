//bloc
import 'package:BrandFarm/blocs/home/bloc.dart';
import 'package:BrandFarm/blocs/weather/bloc.dart';
import 'package:BrandFarm/blocs/authentication/bloc.dart';

//screen
import 'package:BrandFarm/layout/adaptive.dart';
import 'package:BrandFarm/screens/field/field_detail_screen.dart';
import 'package:flutter/cupertino.dart';

//flutter
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//util
import 'package:BrandFarm/utils/todays_date.dart';

//plugin
import 'package:badges/badges.dart';

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
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$year년 $month월 $day일 $weekday',
                          ),
                          Row(
                            children: [
                              Text('$name'),
                              Text(' 님, 안녕하세요')
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 30.0,
                        child: Icon(
                          Icons.add
                        ),
                      ),
                    ],
                  )
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
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                  onPressed: () {},
                ),
                padding: EdgeInsets.all(4.5),
              ),
              IconButton(
                  iconSize: 35.0,
                  icon: Icon(Icons.settings),
                  onPressed: () {})
            ],
          ),
        )
      ],
    );
  }
}
