//screens
import 'dart:io';

import 'package:BrandFarm/screens/home/home_screen.dart';
import 'package:BrandFarm/screens/splash/splash_screen.dart';
import 'package:BrandFarm/screens/login/login_screen.dart';

//bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:BrandFarm/blocs/login/bloc.dart';
import 'blocs/home/bloc.dart';
import 'package:BrandFarm/blocs/authentication/bloc.dart';
import 'package:BrandFarm/blocs/blocObserver.dart';

//repository
import 'package:BrandFarm/repository/user/user_repository.dart';

//flutter firebase
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

//util
import 'package:BrandFarm/utils/themes/farm_theme_data.dart';



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
  bool isDesktop;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    try{
      if(Platform.isIOS || Platform.isAndroid){
        isDesktop = false;
      }else{
        isDesktop = true;
      }
    }catch(e){
      isDesktop = true;
    }
    if(isDesktop){
      _authenticationBloc.add(AuthenticationStarted());
    }else{
      Timer(Duration(seconds: 2), () {
        _authenticationBloc.add(AuthenticationStarted());
      });
    }
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
        theme: FarmThemeData.lightThemeData,
        // darkTheme: FarmThemeData.darkThemeData,
        // ThemeData(
        //   backgroundColor: Colors.white,
        //   primaryColor: Colors.black,
        //   primaryColorLight: Colors.white,
        //   accentColor: Colors.blue[600],
        //   appBarTheme: AppBarTheme(brightness: Brightness.light),
        // ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationSuccess) {
              return BlocProvider<HomeBloc>(
                  create: (BuildContext context) =>
                      HomeBloc(),
                  child: HomeScreen(name: state.displayName));
            } else if(state is AuthenticationInitial && !isDesktop){
              return SplashScreen(duration: 2);
            } else{
              return BlocProvider<LoginBloc>(
                  create: (BuildContext context) =>
                      LoginBloc(userRepository: userRepository),
                child: LoginScreen(userRepository: userRepository,),
              );
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
