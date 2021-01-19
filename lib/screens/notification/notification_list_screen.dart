import 'package:BrandFarm/screens/notification/notification_dialog_screen.dart';
import 'package:BrandFarm/widgets/department_badge.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationListScreen extends StatefulWidget {
  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(10, 0.0, 0.0, 0.0),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 29,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('알림',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'AppleSDGothicNeoR'),
        ),
      ),
      body: ListView.builder(
        itemCount: 24,
        itemBuilder: (context, index) {
          return (index == 0)
              ? _fixedCustomListTile()
              : _customListTile();
        },
      ),
    );
  }

  Widget fixedPositionCard() {
    return Card(
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      elevation: 1,
      child: ListTile(
        onTap: () {
          print('testing');
        },
        contentPadding: EdgeInsets.fromLTRB(14, 13, 14, 13),
        tileColor: Color(0xFFFFF8DB),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              CupertinoIcons.exclamationmark_circle,
              size: 38,
              color: Color(0xFFFDD015),
            ),
          ],
        ),
        title: Row(
          children: [
            DepartmentBadge(department: 'office'),
            SizedBox(width: 2,),
            Center(
                child: Text(
                  '안전에 유의하시길 당부드립니다',
                  // style: Theme.of(context).textTheme.overline.copyWith(fontSize: 15),
                  style: TextStyle(fontFamily: 'AppleSDGothicNeoR', fontWeight: FontWeight.bold, fontSize: 15,),
                )),
          ],
        ),
        subtitle: Text(
          '날씨가 여전히 추운 관계로 농작물 관리에 조금 더 신경써 주시고 빙판길로 인해 미끄러울 수 있으니 집에 가세요',
          // style: Theme.of(context).textTheme.overline.copyWith(fontWeight: FontWeight.normal),
          style: TextStyle(fontFamily: 'AppleSDGothicNeoR', fontWeight: FontWeight.w300, fontSize: 13, color: Color(0x70000000)),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 55,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('상시',
                  // style: Theme.of(context).textTheme.overline.copyWith(fontWeight: FontWeight.normal),
                  style: TextStyle(fontFamily: 'AppleSDGothicNeoR', fontWeight: FontWeight.w300, fontSize: 13, color: Color(0xFF737373)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget listCard() {
    return Card(
      margin: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 1.0),
      elevation: 1,
      child: ListTile(
        onTap: () {
          print('testing');
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (context, a1, a2) =>
                    NotificationDialogScreen(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
                opaque: false),
          );
        },
        contentPadding: EdgeInsets.fromLTRB(10, 13, 10, 13),
        tileColor: Colors.white,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Badge(
              position: BadgePosition.topStart(top: 0, start: 0),
              shape: BadgeShape.circle,
              child: Container(
                  width: 48,
                  height: 48,
                  child: Center(
                      child: Image.asset('assets/megaphone.png', width: 38, height: 38,))),
              padding: EdgeInsets.all(4.5),
            ),
          ],
        ),
        title: Row(
          children: [
            DepartmentBadge(department: 'office'),
            SizedBox(width: 2,),
            Center(
              child: Text(
                '딸기수확 완료여부 파악 요망',
                // style: Theme.of(context).textTheme.overline.copyWith(fontSize: 15,),
                style: TextStyle(fontFamily: 'AppleSDGothicNeoR', fontWeight: FontWeight.bold, fontSize: 15,),
              ),
            ),
          ],
        ),
        subtitle: Column(
          children: [
            SizedBox(height: 4,),
            Text(
              '2/22 까지 한동이네 딸기농장에서의 목표치 만큼의 딸기수확이 완료되면 일지에서 세부내용을 작성해주시면 됩니다. 감사합니다',
              // style: Theme.of(context).textTheme.overline.copyWith(fontWeight: FontWeight.normal),
              style: TextStyle(fontFamily: 'AppleSDGothicNeoR', fontWeight: FontWeight.w300, fontSize: 13, color: Color(0x70000000)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 55,
              child: Center(
                child: Text('2시간 전',
                  // style: Theme.of(context).textTheme.overline.copyWith(fontWeight: FontWeight.normal),
                  style: TextStyle(fontFamily: 'AppleSDGothicNeoR', fontWeight: FontWeight.w300, fontSize: 13, color: Color(0xFF737373)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fixedCustomListTile() {
    return Container(
      color: Color(0xFFFFF8DB),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (context, a1, a2) =>
                    NotificationDialogScreen(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
                opaque: false),
          );
        },
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.fromLTRB(10, 12, 14, 12),
              height: 93,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: 48,
                          height: 48,
                          child: Center(
                            child: Icon(
                              CupertinoIcons.exclamationmark_circle,
                              size: 38,
                              color: Color(0xFFFDD015),
                            ),)),
                    ],
                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 240,
                        child: Row(
                          children: [
                            DepartmentBadge(department: 'office'),
                            SizedBox(width: 2,),
                            Center(
                                child: Text(
                                  '안전에 유의하시길 당부드립니다',
                                  // style: Theme.of(context).textTheme.overline.copyWith(fontSize: 15),
                                  style: TextStyle(fontFamily: 'AppleSDGothicNeoR', fontWeight: FontWeight.bold, fontSize: 15,),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 4,),
                      Container(
                        // height: 36,
                        width: 240,
                        child: Column(
                          children: [
                            Text(
                              '날씨가 여전히 추운 관계로 농작물 관리에 조금 더 신경써 주시고 빙판길로 인해 미끄러울 수 있으니 집에 가세요',
                              // style: Theme.of(context).textTheme.overline.copyWith(fontWeight: FontWeight.normal),
                              style: TextStyle(fontFamily: 'AppleSDGothicNeoR', fontWeight: FontWeight.w300, fontSize: 13, color: Color(0x70000000)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 55,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('상시',
                              // style: Theme.of(context).textTheme.overline.copyWith(fontWeight: FontWeight.normal),
                              style: TextStyle(fontFamily: 'AppleSDGothicNeoR', fontWeight: FontWeight.w300, fontSize: 13, color: Color(0xFF737373)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 2, color: Color(0xFFF1F1F1),),
          ],
        ),
      ),
    );
  }

  Widget _customListTile() {
    return Container(
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (context, a1, a2) =>
                    NotificationDialogScreen(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
                opaque: false),
          );
        },
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.fromLTRB(10, 12, 14, 12),
              height: 93,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Badge(
                        position: BadgePosition.topStart(top: 0, start: 0),
                        shape: BadgeShape.circle,
                        child: Container(
                            width: 48,
                            height: 48,
                            child: Center(
                                child: Image.asset('assets/megaphone.png', width: 38, height: 38,))),
                        padding: EdgeInsets.all(4.5),
                      ),
                    ],
                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 240,
                        child: Row(
                          children: [
                            DepartmentBadge(department: 'office'),
                            SizedBox(width: 2,),
                            Text(
                              '딸기수확 완료여부 파악 요망',
                              // style: Theme.of(context).textTheme.overline.copyWith(fontSize: 15,),
                              style: TextStyle(fontFamily: 'AppleSDGothicNeoR', fontWeight: FontWeight.bold, fontSize: 15,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4,),
                      Container(
                        // height: 36,
                        width: 240,
                        child: Column(
                          children: [
                            Text(
                              '2/22 까지 한동이네 딸기농장에서의 목표치 만큼의 딸기수확이 완료되면 일지에서 세부내용을 작성해주시면 됩니다. 감사합니다',
                              // style: Theme.of(context).textTheme.overline.copyWith(fontWeight: FontWeight.normal),
                              style: TextStyle(fontFamily: 'AppleSDGothicNeoR', fontWeight: FontWeight.w300, fontSize: 13, color: Color(0x70000000)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 55,
                          child: Center(
                            child: Text('2시간 전',
                              // style: Theme.of(context).textTheme.overline.copyWith(fontWeight: FontWeight.normal),
                              style: TextStyle(fontFamily: 'AppleSDGothicNeoR', fontWeight: FontWeight.w300, fontSize: 13, color: Color(0xFF737373)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 2, color: Color(0xFFF1F1F1),),
          ],
        ),
      ),
    );
  }
}
