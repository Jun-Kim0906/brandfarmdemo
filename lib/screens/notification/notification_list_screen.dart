import 'package:BrandFarm/screens/notification/notification_dialog_screen.dart';
import 'package:BrandFarm/widgets/department_badge.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            color: Color(0xFF37949B),
            size: 29,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('알림',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return (index == 0)
              ? Column(
                children: [
                  _fixedCustomListTile(),
                  SizedBox(height: 3,),
                ],
              )
              : Column(
                children: [
                  _customListTile(index: index),
                  SizedBox(height: 3,),
                ],
              );
        },
      ),
    );
  }

  Widget _fixedCustomListTile() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFF8DB),
        border: Border(
          top: BorderSide(width: 1, color: Color(0xFFEBEBEB)),
          bottom: BorderSide(width: 1, color: Color(0xFFEBEBEB)),
        ),
      ),
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
              padding: EdgeInsets.fromLTRB(18, 13, 13, 0),
              height: 93,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                          child: Icon(
                            Icons.error_outline_rounded,
                            size: 40,
                            color: Color(0xFFFDD015),
                          )),
                    ],
                  ),
                  SizedBox(width: 18,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 240,
                        child: Row(
                          children: [
                            Container(
                              height: 13,
                                width: 21,
                                child: FittedBox(
                                    child: DepartmentBadge(department: 'office'))),
                            SizedBox(width: 2,),
                            Center(
                                child: Text(
                                  '안전에 유의하시길 당부드립니다',
                                  // style: Theme.of(context).textTheme.overline.copyWith(fontSize: 15),
                                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 9,),
                      Container(
                        width: 256,
                        child: Column(
                          children: [
                            Text(
                              '날씨가 여전히 추운 관계로 농작물 관리에 조금 더 신경써 주시고 빙판길로 인해 미끄러울 수 있으니 집에 가세요',
                              // style: Theme.of(context).textTheme.overline.copyWith(fontWeight: FontWeight.normal),
                              style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 14,),
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
                              style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontWeight: FontWeight.w300,
                                fontSize: 13,
                                color: Color(0xFF737373),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customListTile({int index}) {
    return Container(
      decoration: BoxDecoration(
        color: (index > 4) ? Color(0xFFEBEBEB) : Colors.white,
        border: Border(
          top: BorderSide(width: 1, color: Color(0xFFEBEBEB)),
          bottom: BorderSide(width: 1, color: Color(0xFFEBEBEB)),
        ),
      ),
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
              padding: EdgeInsets.fromLTRB(10, 13, 13, 0),
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
                            Container(
                              height: 13,
                                width: 21,
                                child: FittedBox(child: DepartmentBadge(department: 'office'))),
                            SizedBox(width: 2,),
                            Text(
                              '딸기수확 완료여부 파악 요망',
                              // style: Theme.of(context).textTheme.overline.copyWith(fontSize: 15,),
                              style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 9,),
                      Container(
                        // height: 36,
                        width: 240,
                        child: Column(
                          children: [
                            Text(
                              '2/22 까지 한동이네 딸기농장에서의 목표치 만큼의 딸기수확이 완료되면 일지에서 세부내용을 작성해주시면 됩니다. 감사합니다',
                              // style: Theme.of(context).textTheme.overline.copyWith(fontWeight: FontWeight.normal),
                              style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 9,),
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
                              style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontWeight: FontWeight.w300,
                                fontSize: 13,
                                color: Color(0xFF737373),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
