
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.Dart';

class SplashScreen extends StatefulWidget {
  final int duration;
  const SplashScreen({this.duration});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: height * 0.263,
          width: width * 0.2,
          child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image.asset('assets/brandfarm.png')
          ),
        ),
      ),
    );
  }
}
