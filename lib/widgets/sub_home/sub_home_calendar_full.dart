import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubHomeCalendarFull extends StatefulWidget {
  @override
  _SubHomeCalendarFullState createState() => _SubHomeCalendarFullState();
}

class _SubHomeCalendarFullState extends State<SubHomeCalendarFull> {
  DateTime now;
  DateTime fixedNow;
  int currentDay;
  int daysInMonth;
  int daysInPrevMonth;
  int firstWeekDayOfMonth;
  int lastWeekDayOfMonth;
  int prevSelectedIndex;
  String year;
  String month;
  String fixedYear;
  String fixedmonth;
  String selectedDay;
  List monthList = [];
  List weekDay = [
    'S',
    'M',
    'T',
    'W',
    'T',
    'F',
    'S',
  ];
  List testPlans = [
    '일지작성',
    '알량성 얄리리 얄라 ㅈㄷㄹ',
    '알량성 얄리리 얄라 ㅈㄷㄹ',
    '알량성 얄리리 얄라 ㅈㄷㄹ 알라딘 알량성 얄리리 량랴당사 다시마',
    '알량성 얄리리 얄라 ㅈㄷㄹ',
    '알량성 얄리리 얄라 ㅈㄷㄹ',
    '알량성 얄리리 얄라 ㅈㄷㄹ',
    '알량성 얄리리 얄라 ㅈㄷㄹ',
    '알량성 얄리리 얄라 ㅈㄷㄹ',
    '알량성 얄리리 얄라 ㅈㄷㄹ',
  ];

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    fixedNow = now;
    currentDay = int.parse(DateFormat('d').format(fixedNow));
    fixedYear = DateFormat('yyyy').format(fixedNow);
    fixedmonth = DateFormat('M').format(fixedNow);
    getMonth(now: now);
    monthList.forEach((month) {
      if (month.date == int.parse(DateFormat('d').format(now))) {
        var index = monthList.indexOf(month);
        PickDate pd = PickDate(date: month.date, isPicked: !month.isPicked);
        setState(() {
          prevSelectedIndex = index;
          monthList.removeAt(index);
          monthList.insert(index, pd);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: FlatButton(
          padding: EdgeInsets.only(left: 6),
          minWidth: 0,
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text('닫기',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.black,
            ),),
        ),
        centerTitle: true,
        title: Text('캘린더', style: Theme.of(context).textTheme.bodyText1.copyWith(
          color: Colors.black,
        ),),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              _year(context: context),
              _month(context: context),
              _weekDayName(context: context),
              _days(context: context),
              SizedBox(
                height: defaultPadding,
              ),
              plans(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _year({BuildContext context}) {
    return Center(
      child: Text(
        year,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color(0x70333333),
        ),
      ),
    );
  }

  Widget _month({BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            DateTime date = DateTime(now.year, now.month - 1, 1);
            setState(() {
              now = date;
            });
            print(date);
            getMonth(now: date);
          },
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
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        IconButton(
          onPressed: () {
            DateTime date = DateTime(now.year, now.month + 1, 1);
            setState(() {
              now = date;
            });
            print(date);
            getMonth(now: date);
          },
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
      children: List.generate(
        7,
            (index) => Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              weekDay[index],
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Color(0xFF219653),
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _days({BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              7,
                  (index) => InkWell(
                onTap: () {
                  if (monthList[index].isPicked == false) {
                    pickDate(index: index);
                  }
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: (monthList[index].isPicked)
                        ? Color(0xFF15B85B)
                        : (monthList[index].date == currentDay &&
                        fixedmonth == month &&
                        fixedYear == year)
                        ? Colors.grey[200]
                        : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${monthList[index].date}',
                      style: TextStyle(
                          color: (index < firstWeekDayOfMonth &&
                              firstWeekDayOfMonth != 7)
                              ? Color(0xFFE9E9E9)
                              : (monthList[index].isPicked)
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              )),
        ),
        // SizedBox(
        //   height: defaultPadding,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              7,
                  (index) => InkWell(
                onTap: () {
                  if (monthList[index + 7].isPicked == false) {
                    pickDate(index: index + 7);
                  }
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: (monthList[index + 7].isPicked)
                        ? Color(0xFF15B85B)
                        : (monthList[index + 7].date == currentDay &&
                        fixedmonth == month &&
                        fixedYear == year)
                        ? Colors.grey[200]
                        : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Text(
                        '${monthList[index + 7].date}',
                        style: TextStyle(
                            color: (monthList[index + 7].isPicked)
                                ? Colors.white
                                : Colors.black),
                      )),
                ),
              )),
        ),
        // SizedBox(
        //   height: defaultPadding,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              7,
                  (index) => InkWell(
                onTap: () {
                  if (monthList[index + 14].isPicked == false) {
                    pickDate(index: index + 14);
                  }
                },
                child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: (monthList[index + 14].isPicked)
                          ? Color(0xFF15B85B)
                          : (monthList[index + 14].date == currentDay &&
                          fixedmonth == month &&
                          fixedYear == year)
                          ? Colors.grey[200]
                          : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Text(
                          '${monthList[index + 14].date}',
                          style: TextStyle(
                              color: (monthList[index + 14].isPicked)
                                  ? Colors.white
                                  : Colors.black),
                        ))),
              )),
        ),
        // SizedBox(
        //   height: defaultPadding,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              7,
                  (index) => InkWell(
                onTap: () {
                  if (monthList[index + 21].isPicked == false) {
                    pickDate(index: index + 21);
                  }
                },
                child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: (monthList[index + 21].isPicked)
                          ? Color(0xFF15B85B)
                          : (monthList[index + 21].date == currentDay &&
                          fixedmonth == month &&
                          fixedYear == year)
                          ? Colors.grey[200]
                          : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Text(
                          '${monthList[index + 21].date}',
                          style: TextStyle(
                              color: (monthList[index + 21].isPicked)
                                  ? Colors.white
                                  : Colors.black),
                        ))),
              )),
        ),
        // SizedBox(
        //   height: defaultPadding,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              7,
                  (index) => InkWell(
                onTap: () {
                  if (monthList[index + 28].isPicked == false) {
                    pickDate(index: index + 28);
                  }
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: (monthList[index + 28].isPicked)
                        ? Color(0xFF15B85B)
                        : (monthList[index + 28].date == currentDay &&
                        fixedmonth == month &&
                        fixedYear == year)
                        ? Colors.grey[200]
                        : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${monthList[index + 28].date}',
                      style: TextStyle(
                          color: (monthList[index + 28].date < 8)
                              ? Color(0xFFE9E9E9)
                              : (monthList[index + 28].isPicked)
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  Widget plans({BuildContext context}) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      initiallyExpanded: true,
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '일정',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 3,),
          Text(
            '${testPlans.length}',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF15B85B)),
          ),
        ],
      ),
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: testPlans.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(11, 8, 6, 11),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(testPlans[index],
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.black,
                    ),),
                ),
                (index != testPlans.length - 1)
                    ? SizedBox(height: 3,) : SizedBox(height: defaultPadding,),
              ],
            );
          },
        ),
        // Container(
        //   color: Colors.white,
        //   child: Column(
        //     children: List.generate(testPlans.length, (index) =>
        //         Column(
        //           children: [
        //             Container(
        //               width: MediaQuery.of(context).size.width,
        //               padding: EdgeInsets.fromLTRB(11, 8, 6, 11),
        //               decoration: BoxDecoration(
        //                 color: Color(0xFFF2F2F2),
        //                 borderRadius: BorderRadius.circular(5),
        //               ),
        //               child: Text(testPlans[index],
        //                 style: Theme.of(context).textTheme.bodyText2.copyWith(
        //                   color: Colors.black,
        //                 ),),
        //             ),
        //             (index != testPlans.length - 1)
        //                 ? SizedBox(height: 3,) : SizedBox(height: defaultPadding,),
        //           ],
        //         )),
        //   ),
        // ),
      ],
    );
  }

  void pickDate({int index}) {
    PickDate prev;
    if (prevSelectedIndex != null) {
      prev = PickDate(
          date: monthList[prevSelectedIndex].date,
          isPicked: !monthList[prevSelectedIndex].isPicked);
    }
    PickDate update = PickDate(
        date: monthList[index].date, isPicked: !monthList[index].isPicked);
    setState(() {
      // prev
      if (prevSelectedIndex != null) {
        monthList.removeAt(prevSelectedIndex);
        monthList.insert(prevSelectedIndex, prev);
      }
      // update
      monthList.removeAt(index);
      monthList.insert(index, update);
      prevSelectedIndex = index;
    });
  }

  void getMonth({DateTime now}) {
    setState(() {
      prevSelectedIndex = null;
      monthList = [];
      daysInMonth = DateTime(now.year, now.month + 1, 0).day;
      // 1 means monday; 7 ,means sunday
      firstWeekDayOfMonth = DateTime(now.year, now.month, 1).weekday;
      lastWeekDayOfMonth = DateTime(now.year, now.month, daysInMonth).weekday;
      year = DateFormat('yyyy').format(now);
      month = DateFormat('M').format(now);
      if (firstWeekDayOfMonth < 7) {
        daysInPrevMonth = DateTime(now.year, now.month, 0).day;
        for (int i = firstWeekDayOfMonth - 1; i >= 0; i--) {
          if (monthList.isEmpty) {
            monthList.insert(
                0, PickDate(date: daysInPrevMonth - i, isPicked: false));
          } else {
            monthList.add(PickDate(date: daysInPrevMonth - i, isPicked: false));
          }
        }
      }
      for (int i = 1; i <= daysInMonth; i++) {
        monthList.add(PickDate(date: i, isPicked: false));
      }
      if (lastWeekDayOfMonth < 6) {
        for (int i = 1; i < 6; i++) {
          monthList.add(PickDate(date: i, isPicked: false));
        }
      }
      if (lastWeekDayOfMonth > 6) {
        for (int i = 1; i < 7; i++) {
          monthList.add(PickDate(date: i, isPicked: false));
        }
      }
    });
  }
}

class PickDate {
  final int date;
  final bool isPicked;

  PickDate({this.date, this.isPicked});
}
