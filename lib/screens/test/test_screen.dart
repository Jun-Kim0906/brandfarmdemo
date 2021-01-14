
import 'package:BrandFarm/screens/home/fm_home_screen_widget.dart';
import 'package:BrandFarm/screens/journal/journal_list_screen.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test screen'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => JournalListScreen()),
            );
          },
          child: Text('일지 리스트 화면으로 이동'),
        ),
      ),
    );
  }
}
