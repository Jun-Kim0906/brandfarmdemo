import 'package:flutter/cupertino.dart';
import 'package:flutter/material.Dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.15,
              width: width * 0.2,
              child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Image.asset('assets/brandfarm.png')),
            ),
            SizedBox(
              height: height * 0.1,
              width: width * 0.702,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: FadeAnimatedTextKit(
                  duration: Duration(seconds: widget.duration),
                  textStyle: TextStyle(
                    color: Color(0xff343434),
                    fontSize: 82,
                    fontFamily: 'Roboto',
                  ),
                  text: [
                    "Brand Farm",
                  ],
                  isRepeatingAnimation: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
