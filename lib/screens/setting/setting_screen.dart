import 'package:BrandFarm/screens/setting/logout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isActivated;

  @override
  void initState() {
    super.initState();
    isActivated = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF219653),),
        ),
        title: Text('설정',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontSize: 18,
            color: Colors.black,
        ),),
      ),
      body: Container(
        // padding: EdgeInsets.only(top: ),
        child: Column(
          children: [
            Divider(height: 1, thickness: 1, color: Color(0x20000000),),
            ListTile(
              onTap: (){},
              leading: Text('프로필 / 계정 설정',
                style: Theme.of(context).textTheme.bodyText1,),
            ),
            Divider(height: 1, thickness: 1, color: Color(0x20000000),),
            ListTile(
              leading: Text('알림 활성화',
                style: Theme.of(context).textTheme.bodyText1,),
              trailing: CupertinoSwitch(
                value: isActivated,
                onChanged: (value) {
                  setState(() {
                    isActivated = value;
                  });
                },
              ),
            ),
            Divider(height: 1, thickness: 1, color: Color(0x20000000),),
            ListTile(
              onTap: (){
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, a1, a2) =>
                          LogoutScreen(),
                      transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                      transitionDuration: Duration(milliseconds: 300),
                      opaque: false),
                );
              },
              leading: Text('로그아웃',
                style: Theme.of(context).textTheme.bodyText1,),
            ),
            Divider(height: 1, thickness: 1, color: Color(0x20000000),),
          ],
        ),
      ),
    );
  }
}
