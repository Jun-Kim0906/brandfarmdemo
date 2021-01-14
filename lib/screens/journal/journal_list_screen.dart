import 'package:BrandFarm/blocs/authentication/bloc.dart';
import 'package:BrandFarm/screens/notification/notification_list_screen.dart';
import 'package:BrandFarm/utils/todays_date.dart';
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
  DateTime now = DateTime.now();
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
                    style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text('2021년 2월',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 18),
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
                Container(
                  height: 23,
                  width: 65,
                  color: Colors.white,
                  child: RaisedButton(
                    elevation: 0.0,
                    color: Colors.white,
                    padding: EdgeInsets.all(2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Color(0xFFD6D6D6)),
                    ),
                    child: FittedBox(
                      child: Row(
                        children: [
                          Text('최신순'),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                    onPressed: () {
                      // _settingModalBottomSheet(context);
                    },
                  ),
                ),
              ],
            ),
            ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 21,
              itemBuilder: (context, index) {
                int date = 21;
                return list_tile(
                  date: 21 - index,
                  week: daysOfWeek(
                      index: now.add(Duration(days: index + 1)).weekday),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.edit),
        label: Text('일지쓰기'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget list_tile({int date, String week}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      onTap: () {},
      leading: leadingIcon(date: date, week: week),
      title: Text(
        '2022년 2월 21일의 일지',
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontWeight: FontWeight.normal),
      ),
      subtitle: Text(
        '딸기는 넘 맛있다. 딸기는 넘 맛있다. 딸기는 넘 맛있다. 딸기는 넘 맛있다. 딸기는 넘 맛있다. 딸기는 넘 맛있다.',
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(fontWeight: FontWeight.normal),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      trailing: trailingIcon(),
    );
  }

  Widget leadingIcon({int date, String week}) {
    return Container(
      child: FittedBox(
        child: Column(
          children: [
            Text(
              '$date',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 36,
                  ),
            ),
            Text(
              week,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget trailingIcon() {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/strawberry.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.srcATop),
        ),
      ),
      child: Center(
        child: Text(
          '+2',
          style: Theme.of(context).textTheme.headline3.copyWith(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.background,
              ),
        ),
      ),
    );
  }
}
