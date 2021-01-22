import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/utils/todays_date.dart';
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
  }) : _homeBloc = homeBloc, super(key: key);

  final HomeBloc _homeBloc;
  final int initialIndex;
  final HomeState state;

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
                Align(
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(
                      'assets/svg_icon/calendar_icon.svg',
                    ))
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
        ],
      ),
    );
  }
}
