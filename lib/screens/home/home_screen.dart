import 'package:BrandFarm/blocs/weather/bloc.dart';
import 'package:BrandFarm/screens/field/field_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:BrandFarm/blocs/authentication/bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          onPressed: (){
            BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationLoggedOut(),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);          },
        ),
      ),
      body: Center(
        child: Text('test page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BlocProvider(
              create: (BuildContext context) => WeatherBloc()..add(Wait_Fetch_Weather()),
              child: WeatherMain(),
            ),),
          );
        },
      ),
    );
  }
}
