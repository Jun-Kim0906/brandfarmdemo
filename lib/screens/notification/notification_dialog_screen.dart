import 'package:BrandFarm/widgets/login/create_account_button.dart';
import 'package:flutter/material.dart';

class NotificationDialogScreen extends StatefulWidget {
  @override
  _NotificationDialogScreenState createState() =>
      _NotificationDialogScreenState();
}

class _NotificationDialogScreenState extends State<NotificationDialogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x90000000),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            height: 300,
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/megaphone.png', height: 40)),
                Row(
                  children: [
                    Container(
                      color: Color(0xFFFFD231),
                      child: Text('OM'),
                    ),
                    Center(child: Text('딸기수확 완료여부 파악 요망')),
                  ],
                ),
                Text(
                    '2/22 까지 한동이네 딸기농장에서의 목표치 만큼의 딸기수확이 완료되면 일지에서 세부내용을 작성해주시면 됩니다. 감사합니다'),
                Text('2시간 전 - 오피스매니저'),
                Center(
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    color: Color(0xFF00DB69),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('확인',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
