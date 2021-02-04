import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: LinearProgressIndicator(
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class LoadingDialog {
  static void onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 0, 61, 165)),
              ),
              SizedBox(height: 16),
              Text(
                "Loading",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void dismiss(BuildContext context, Function next) {
    Navigator.pop(context); //pop dialog
    next();
  }
}
