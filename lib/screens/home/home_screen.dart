//bloc
import 'package:BrandFarm/blocs/home/bloc.dart';
import 'package:BrandFarm/blocs/weather/bloc.dart';
import 'package:BrandFarm/blocs/authentication/bloc.dart';

//screen
import 'package:BrandFarm/layout/adaptive.dart';
import 'package:BrandFarm/screens/field/field_detail_screen.dart';

//flutter
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return BlocListener(
      cubit: _homeBloc,
      listener: (BuildContext context, HomeState state) {

      },
      child: BlocBuilder(
        builder: (context, state) {
          if (isDesktop) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
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
            return Scaffold();
          }
        },
      ),
    );
  }
}
