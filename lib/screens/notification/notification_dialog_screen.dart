import 'package:BrandFarm/widgets/department_badge.dart';
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
            padding: EdgeInsets.fromLTRB(24, 17, 11, 20),
            height: 325,
            width: 345,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                        height: 52,
                        width: 52,
                        child: Image.asset('assets/megaphone.png'))),
                // SizedBox(height: 20,),
                Row(
                  children: [
                    SizedBox(
                        width: 30,
                        height: 19,
                        child: FittedBox(
                            child: DepartmentBadge(department: 'office'))),
                    SizedBox(
                      width: 5,
                    ),
                    Center(
                        child: Text(
                      '딸기수확 완료여부 파악 요망',
                      style: Theme.of(context).textTheme.headline5,
                    )),
                  ],
                ),
                // SizedBox(height: 25,),
                Text(
                  '2/22 까지 한동이네 딸기농장에서의 목표치 만큼의 딸기수확이 완료되면 일지에서 세부내용을 작성해주시면 됩니다. 감사합니다',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                // SizedBox(height: 19,),
                Text(
                  '2시간 전 - 오피스매니저',
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                // SizedBox(height: 32,),
                Center(
                  child: Container(
                    width: 127,
                    height: 41,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Color(0xFF00DB69),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.5),
                      ),
                      child: Text(
                        '확인',
                        style: TextStyle(color: Colors.white),
                      ),
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
