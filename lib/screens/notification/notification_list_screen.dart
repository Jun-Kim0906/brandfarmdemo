import 'package:BrandFarm/screens/notification/notification_dialog_screen.dart';
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
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF37949B),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('알림'),
      ),
      body: ListView.builder(
        itemCount: 24,
        // separatorBuilder: (context, index) {
        //   return Divider(
        //     color: Colors.white,
        //     thickness: 15,
        //   );
        // },
        itemBuilder: (context, index) {
          return (index == 0)
              ? Card(
                  margin: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                  elevation: 1,
                  child: ListTile(
                    onTap: (){
                      print('testing');
                    },
                    contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    tileColor: Color(0xFFFFF8DB),
                    leading: Icon(
                      CupertinoIcons.exclamationmark_circle,
                      size: 40,
                      color: Color(0xFFFDD015),
                    ),
                    title: Row(
                      children: [
                        Container(
                          color: Color(0xFFFFD231),
                          child: Text('OM'),
                        ),
                        Center(child: Text('안전에 유의하시길 당부드립니다')),
                      ],
                    ),
                    subtitle: Text(
                      '날씨가 여전히 추운 관계로 농작물 관리에 조금 더 신경써 주시고 빙판길로 인해 미끄러울 수 있으니 집에 가세요',
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('상시'),
                      ],
                    ),
                  ),
                )
              : Card(
                  margin: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                  elevation: 1,
                  child: ListTile(
                    onTap: (){
                      print('testing');
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) => NotificationDialogScreen(), opaque: false
                        ),
                      );
                    },
                    contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    tileColor: Colors.white,
                    leading: Badge(
                      position: BadgePosition.topStart(top: 0, start: 0),
                      shape: BadgeShape.circle,
                      child: Icon(Icons.notification_important, size: 40,),
                      padding: EdgeInsets.all(4.5),
                    ),
                    title: Row(
                      children: [
                        Container(
                          color: Color(0xFFFFD231),
                          child: Text('OM'),
                        ),
                        Center(child: Text('딸기수확 완료여부 파악 요망')),
                      ],
                    ),
                    subtitle: Text(
                      '2/22 까지 한동이네 딸기농장에서의 목표치 만큼의 딸기수확이 완료되면',
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('2시간 전'),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
