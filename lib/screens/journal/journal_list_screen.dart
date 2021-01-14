import 'package:BrandFarm/blocs/authentication/bloc.dart';
import 'package:BrandFarm/screens/notification/notification_list_screen.dart';
import 'package:BrandFarm/widgets/brandfarm_icons.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JournalListScreen extends StatefulWidget {
  @override
  _JournalListScreenState createState() => _JournalListScreenState();
}

class _JournalListScreenState extends State<JournalListScreen> {
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.yellow,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF37949B),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Row(
                children: [
                  Text(
                    '한동이네 딸기 농장',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.calendar,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        leading: IconButton(
          iconSize: 60.0,
          icon: Image.asset('assets/brandfarm.png'),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationLoggedOut(),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        // title: Text('journal list'),
        actions: [
          Badge(
            position: BadgePosition.topEnd(top: 2, end: 8),
            badgeContent: Text(
              '2',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
            child: IconButton(
              iconSize: 40.0,
              icon: Icon(
                Icons.notifications_none_sharp,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationListScreen(),
                  ),
                );
              },
            ),
            padding: EdgeInsets.all(4.5),
          ),
          IconButton(
              iconSize: 35.0,
              icon: Icon(
                BrandFarmIcons.settings,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
      ),
      body: Container(
        child: RaisedButton(
          onPressed: (){

          },
          child: Row(
            children: [
              Text('2021'),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.list),
        label: Text('일지쓰기'),
        onPressed: (){},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // Row(
      //   children: [
      //     YearPicker(
      //       initialDate: selectedDate,
      //       firstDate: DateTime(2020),
      //       lastDate: DateTime(2021, 12, 31),
      //       selectedDate: selectedDate,
      //       onChanged: (date) {
      //         setState(() {
      //           selectedDate = date;
      //         });
      //       },
      //     ),
      //     CalendarDatePicker(
      //       initialDate: selectedDate,
      //       firstDate: DateTime(2020),
      //       lastDate: DateTime(2021, 12, 31),
      //       onDateChanged: (date) {
      //         setState(() {
      //           selectedDate = date;
      //         });
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
