import 'package:BrandFarm/test.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/utils/todays_date.dart';
import 'package:BrandFarm/widgets/sub_home/sub_home_calendar_full.dart';
import 'package:flutter/material.dart';

import 'package:BrandFarm/blocs/home/bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class SubHomeCalendar extends StatelessWidget {
  const SubHomeCalendar({
    Key key,
    @required HomeBloc homeBloc,
    @required this.initialIndex,
    @required this.state,
    @required this.testPlans,
  }) : _homeBloc = homeBloc, super(key: key);

  final HomeBloc _homeBloc;
  final int initialIndex;
  final HomeState state;

  final List testPlans;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: defaultPadding, left: defaultPadding, bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: Offset(0, 4),
              blurRadius: 4.0,
            )
          ]),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.0),
            height: 48.0,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${state.selectedYear} 년',
                    style: Theme.of(context).textTheme.overline,
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          pageBuilder: (context, a1, a2) =>
                              SubHomeCalendarFull(),
                          transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                          transitionDuration: Duration(milliseconds: 300),
                          opaque: false),
                    );
                  },
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                        'assets/svg_icon/calendar_icon.svg',
                      )),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    icon: Icon(Icons.keyboard_arrow_left_sharp),
                    onPressed: () {
                      _homeBloc.add(PrevMonthClicked());
                    }),
                Text(
                  '${state.selectedMonth}월',
                  style: Theme.of(context).textTheme.headline6,
                ),
                IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    icon: Icon(Icons.keyboard_arrow_right_sharp),
                    onPressed: () {
                      _homeBloc.add(NextMonthClicked());
                    }),
              ],
            ),
          ),
          Divider(
            indent: 15.0,
            endIndent: 15.0,
          ),
          Container(
            height: 100.0,
            child: ScrollablePositionedList.builder(
                initialScrollIndex: initialIndex,
                initialAlignment: 0,
                scrollDirection: Axis.horizontal,
                itemCount: DateUtils.getDaysInMonth(state.selectedYear, state.selectedMonth),
                itemBuilder: (BuildContext context, int index) {
                  int date = index +1;
                  Color numberColor;
                  Color dayOfWeekColor;
                  Color backgroundColor;
                  if(date == state.selectedDate){
                    numberColor = Colors.white;
                    dayOfWeekColor = Colors.white;
                    backgroundColor = Theme.of(context).colorScheme.primary;
                  }else if(date == state.currentDate&&int.parse(month)==state.selectedMonth&&int.parse(year)==state.selectedYear){
                    numberColor = Colors.black;
                    dayOfWeekColor = Color(0x80000000);
                    backgroundColor = Color(0xffe5e5e5);
                  }else{
                    numberColor = Colors.black;
                    dayOfWeekColor = Color(0x80000000);
                    backgroundColor = Colors.white;
                  }

                  return InkWell(
                    onTap: () {
                      _homeBloc.add(DateClicked(SelectedDay: date));
                    },
                    child: Center(
                      child: Container(
                        width: 41.0,
                        margin: EdgeInsets.only(left: 4.5, right:4.5, top: 13.0, bottom: 10.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: backgroundColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('E').format(DateTime(state.selectedYear,
                                  state.selectedMonth, index + 1)),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: dayOfWeekColor),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                                '${date}',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(color: numberColor)
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
              child: plans(context: context)),
          SizedBox(height: defaultPadding,),
        ],
      ),
    );
  }

  Widget plans({BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: ExpansionTile(
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
          Container(
            color: Colors.white,
            child: Column(
              children: List.generate(testPlans.length, (index) =>
                  Column(
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
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
