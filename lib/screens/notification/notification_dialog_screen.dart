import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/department_badge.dart';
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
      backgroundColor: Color(0xB3000000),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              height: 314,
              padding: EdgeInsets.fromLTRB(20, 13, 15, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Container(
                          height: 56,
                          width: 56,
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
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  // SizedBox(height: 19,),
                  Text(
                    '2시간 전 - 오피스매니저',
                    style: Theme.of(context)
                        .textTheme
                        .overline
                        .copyWith(fontWeight: FontWeight.w300,
                        fontSize: 13,
                        color: Color(0xFF737373)),
                  ),
                  // SizedBox(height: 32,),
                  Center(
                    child: Container(
                      width: 113,
                      height: 41,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Color(0xFF6FEA98),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Text(
                          '확인',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
