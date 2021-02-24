import 'package:flutter/material.dart';

class EmptyScreen extends StatefulWidget {
  @override
  _EmptyScreenState createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('empty screen', style: TextStyle(color: Colors.black),),
      ),
      body: Container(),
    );
  }
}
