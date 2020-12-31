import 'dart:async';

import 'package:brandfarmdemo/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brandfarmdemo/blocs/blocs.dart';
import 'package:brandfarmdemo/repository/repositories.dart';
import 'package:brandfarmdemo/screens/screens.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'testpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();


  runApp(
    App(),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final UserRepository userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    Timer(Duration(seconds: 2), () {
      _authenticationBloc.add(AuthenticationStarted());
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider.value(
      value: _authenticationBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
          primaryColor: Colors.black,
          primaryColorLight: Colors.white,
          accentColor: Colors.blue[600],
          appBarTheme: AppBarTheme(brightness: Brightness.light),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is AuthenticationSuccess) {
              return TestPage();
                // BlocProvider<HomeBloc>(
                //   create: (BuildContext context) =>
                //       HomeBloc(),
                //   child: HomeScreen(name: state.displayName));
            } else if(state is AuthenticationInitial){
              return SplashScreen(duration: 2);
            } else{
              return LoginScreen(userRepository: userRepository);
            }

          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.distinct();
    super.dispose();
  }
}
