import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/utils/todays_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  DateTime now = DateTime.now();
  DateTime firstDayOfWeek;
  int currentDay;
  int daysInMonth;
  int daysInPrevMonth;
  int firstWeekDayOfMonth;
  int lastWeekDayOfMonth;
  String year;
  String month;
  String selectedDay;
  List monthList = [];

  @override
  void initState() {
    super.initState();
    currentDay = now.weekday;
    daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    // 1 means monday; 7 ,means sunday
    firstWeekDayOfMonth = DateTime(now.year, now.month, 1).weekday;
    lastWeekDayOfMonth = DateTime(now.year, now.month, daysInMonth).weekday;
    firstDayOfWeek = now.subtract(Duration(days: currentDay));
    year = DateFormat('yyyy').format(now);
    month = DateFormat('M').format(now);
    if (firstWeekDayOfMonth < 7) {
      daysInPrevMonth = DateTime(now.year, now.month, 0).day;
      for (int i = firstWeekDayOfMonth - 1; i >= 0; i--) {
        if (monthList.isEmpty) {
          monthList.insert(0, daysInPrevMonth - i);
        } else {
          monthList.add(daysInPrevMonth - i);
        }
      }
    }
    for (int i = 1; i <= daysInMonth; i++) {
      monthList.add(i);
    }
    if (lastWeekDayOfMonth < 6) {
      for (int i = 1; i < 6; i++) {
        monthList.add(i);
      }
    }
    if (lastWeekDayOfMonth > 6) {
      for (int i = 1; i < 7; i++) {
        monthList.add(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Color(0x99000000),
        body: Center(
          child: Container(
            padding:
                EdgeInsets.fromLTRB(0, 24, 0, 24),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 1.2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                _year(context: context),
                _month(context: context),
                _weekDayName(context: context),
                SizedBox(
                  height: defaultPadding,
                ),
                _days(context: context),
                SizedBox(
                  height: 30,
                ),
                _buttons(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _year({BuildContext context}) {
    return Text(
      year,
      style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0x70333333),
          ),
    );
  }

  Widget _month({BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF219653),
            size: 16,
          ),
        ),
        Text(
          '${month}월',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Color(0xFF333333),
              ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF219653),
            size: 16,
          ),
        ),
      ],
    );
  }

  Widget _weekDayName({BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'S',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Color(0xFF219653),
                fontSize: 15,
              ),
        ),
        Text(
          'M',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Color(0xFF219653),
                fontSize: 15,
              ),
        ),
        Text(
          'T',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Color(0xFF219653),
                fontSize: 15,
              ),
        ),
        Text(
          'W',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Color(0xFF219653),
                fontSize: 15,
              ),
        ),
        Text(
          'T',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Color(0xFF219653),
                fontSize: 15,
              ),
        ),
        Text(
          'F',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Color(0xFF219653),
                fontSize: 15,
              ),
        ),
        Text(
          'S',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Color(0xFF219653),
                fontSize: 15,
              ),
        ),
      ],
    );
  }

  Widget _days({BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) => Text('${monthList[index]}')),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              List.generate(7, (index) => Text('${monthList[index + 7]}')),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              List.generate(7, (index) => Text('${monthList[index + 14]}')),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              List.generate(7, (index) => Text('${monthList[index + 21]}')),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              List.generate(7, (index) => Text('${monthList[index + 28]}')),
        ),
      ],
    );
  }

  Widget _buttons({BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              '취소',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
            )),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: RaisedButton(
            onPressed: () {},
            child: Text(
              '완료',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
