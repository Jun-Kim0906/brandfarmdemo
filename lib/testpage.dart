import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/bloc.dart';

class TestPage extends StatelessWidget {
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
    );
  }
}
