import 'package:BrandFarm/blocs/authentication/bloc.dart';
import 'package:BrandFarm/blocs/journal/bloc.dart';
import 'package:BrandFarm/screens/notification/notification_list_screen.dart';
import 'package:BrandFarm/utils/todays_date.dart';
import 'package:BrandFarm/widgets/brandfarm_icons.dart';
import 'package:BrandFarm/widgets/loading/loading.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class JournalListScreen extends StatefulWidget {
  JournalListScreen({Key key}) : super(key: key);

  @override
  _JournalListScreenState createState() => _JournalListScreenState();
}

class _JournalListScreenState extends State<JournalListScreen> {
  JournalBloc _journalBloc;
  DateTime selectedDate;
  bool _isVisible;
  int index = 2;
  String fieldListOptions = '최신순';
  double scrollOffset;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _journalBloc = BlocProvider.of<JournalBloc>(context);
    _journalBloc.add(GetInitialList());

    _isVisible = true;

    selectedDate = DateTime.now();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        scrollOffset = _scrollController.offset;
      });
      print('offset = ${_scrollController.offset}');
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          // print("**** ${_isVisible} up");
          if (this.mounted) {
            setState(() {
              _isVisible = false;
            });
          }
        }
      } else {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            // print("**** ${_isVisible} down");
            if (this.mounted) {
              setState(() {
                _isVisible = true;
              });
            }
          }
        }
      }
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        // scroll bottom
        if (this.mounted) {
          print('reach the bottom');
          setState(() {});
        } else {
          print('load more');
        }
      }
      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        // scroll top

        if (this.mounted) {
          print('reach the top');
          setState(() {});
        } else {
          print('load previous');
        }
      }
    });
  }

  _afterLayout({JournalState state, int index}) {
    _getPosition(state: state);
  }

  _getPosition({JournalState state, int index}) async {
    RenderBox box = state.globalKey[index].currentContext.findRenderObject();
    Offset position = box.localToGlobal(Offset.zero);
    double y = position.dy;
    print(y);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JournalBloc, JournalState>(
      builder: (context, state) {
        return (state.isLoading)
            ? Loading()
            : Scaffold(
                appBar: _appBar(state: state),
                body: _ListView(state: state),
                floatingActionButton: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  alignment: _isVisible ? Alignment(1, 1) : Alignment(1, 1.5),
                  child: Wrap(
                    children: [
                      FloatingActionButton(
                        heroTag: 'journal',
                        child: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget _appBar({JournalState state}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(220),
      child: AppBar(
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
          iconSize: 19.0,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: _currentMonth(state: state),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
            child: SizedBox(
              width: 71,
              child: OutlineButton(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FittedBox(
                  child: Row(
                    children: [
                      Text(
                        fieldListOptions,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
                onPressed: () {
                  _settingModalBottomSheet(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ListView({JournalState state}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ListView.builder(
        controller: _scrollController,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          String weekNumBefore;
          String weekNumNow;
          if (index == 0) {
            weekNumNow = _weekOfMonth(date: state.items[index]);
            return Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 43,
                    ),
                    _weekOfMonthWidget(weekOfMonth: weekNumNow, state: state, index: index),
                    SizedBox(
                      height: 21,
                    ),
                  ],
                ),
                _customListTile(
                  date: int.parse(DateFormat('dd').format(state.items[index])),
                  week: daysOfWeek(index: state.items[index].weekday),
                ),
              ],
            );
          } else {
            weekNumBefore = _weekOfMonth(date: state.items[index - 1]);
            weekNumNow = _weekOfMonth(date: state.items[index]);
            if(weekNumNow != weekNumBefore) {
              // WidgetsBinding.instance.addPostFrameCallback(_afterLayout(state: state, index: 0));
              return Column(
                children: [
                  (weekNumNow != weekNumBefore)
                      ? Column(
                    children: [
                      SizedBox(
                        height: 43,
                      ),
                      _weekOfMonthWidget(weekOfMonth: weekNumNow, state: state, index: index),
                      SizedBox(
                        height: 21,
                      ),
                    ],
                  )
                      : Container(),
                  _customListTile(
                    date: int.parse(DateFormat('dd').format(state.items[index])),
                    week: daysOfWeek(index: state.items[index].weekday),
                  ),
                ],
              );
            } else {
              return _customListTile(
                date: int.parse(DateFormat('dd').format(state.items[index])),
                week: daysOfWeek(index: state.items[index].weekday),
              );
            }
          }
        },
      ),
    );
  }

  Widget _currentMonth({JournalState state}) {
    return Container(
      // height: 214,
      // width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 110,
          ),
          Text(
            state.year,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            state.month,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(CupertinoIcons.camera_circle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _weekOfMonthWidget({String weekOfMonth, JournalState state, int index}) {
    return Container(
      // key: state.globalKey[index],
      height: 30,
      width: 87,
      child: Center(
        child: Text(
          weekOfMonth,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Color(0x10000000),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Widget _customListTile({int date, String week}) {
    return Container(
      height: 77,
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0),
              height: 93,
              child: Row(
                children: [
                  Container(
                    height: 93,
                    width: 1.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      leadingIcon(date: date, week: week),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 240,
                        child: Text(
                          '2022년 2월 21일의 일지',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        // height: 36,
                        width: 240,
                        child: Column(
                          children: [
                            Text(
                              '딸기는 넘 맛있다. 딸기는 넘 맛있다. 딸기는 넘 맛있다. 딸기는 넘 맛있다. 딸기는 넘 맛있다. 딸기는 넘 맛있다.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontWeight: FontWeight.normal),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        trailingIcon(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 2,
              color: Color(0xFFF1F1F1),
            ),
          ],
        ),
      ),
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

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return new Wrap(
            children: <Widget>[
              ListTile(
                  leading: Text('가나다순'),
                  title: Text(''),
                  trailing: (index == 1)
                      ? Icon(Icons.check)
                      : Container(
                          height: 1,
                          width: 1,
                        ),
                  onTap: () => {
                        Navigator.pop(context),
                        setState(() {
                          fieldListOptions = '가나다순';
                          index = 1;
                        }),
                      }),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
              ListTile(
                leading: Text('거리순'),
                title: Text(''),
                trailing: (index == 2)
                    ? Icon(Icons.check)
                    : Container(
                        height: 1,
                        width: 1,
                      ),
                onTap: () => {
                  Navigator.pop(context),
                  setState(() {
                    fieldListOptions = '거리순';
                    index = 2;
                  }),
                },
              ),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
              ListTile(
                leading: Text('최근 열람순'),
                title: Text(''),
                trailing: (index == 3)
                    ? Icon(Icons.check)
                    : Container(
                        height: 1,
                        width: 1,
                      ),
                onTap: () => {
                  Navigator.pop(context),
                  setState(() {
                    fieldListOptions = '최근 열람순';
                    index = 3;
                  }),
                },
              ),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
              ListTile(
                leading: Text('잘생긴순'),
                title: Text(''),
                trailing: (index == 4)
                    ? Icon(Icons.check)
                    : Container(
                        height: 1,
                        width: 1,
                      ),
                onTap: () => {
                  Navigator.pop(context),
                  setState(() {
                    fieldListOptions = '잘생긴순';
                    index = 4;
                  }),
                },
              ),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
            ],
          );
        });
  }

  String _weekOfMonth({DateTime date}) {
    // get today's date
    var now = date;
    var month = DateFormat('MM').format(date);
    var year = DateFormat('yyyy').format(date);

    // set it to feb 10th for testing
    //now = now.add(new Duration(days:7));

    int today = now.weekday;

    // ISO week date weeks start on monday
    // so correct the day number
    var dayNr = (today + 6) % 7;

    // ISO 8601 states that week 1 is the week
    // with the first thursday of that year.
    // Set the target date to the thursday in the target week
    var thisMonday = now.subtract(new Duration(days: (dayNr)));
    var thisThursday = thisMonday.add(new Duration(days: 3));

    // Set the target to the first thursday of the year
    // First set the target to january first
    var firstThursday = new DateTime(now.year, DateTime.january, 1);

    if (firstThursday.weekday != (DateTime.thursday)) {
      firstThursday = new DateTime(now.year, DateTime.january,
          1 + ((4 - firstThursday.weekday) + 7) % 7);
    }

    // The weeknumber is the number of weeks between the
    // first thursday of the year and the thursday in the target week
    var x = thisThursday.millisecondsSinceEpoch -
        firstThursday.millisecondsSinceEpoch;
    var weekNumber = x.ceil() / 604800000; // 604800000 = 7 * 24 * 3600 * 1000

    // print("Todays date: ${now}");
    // print("Monday of this week: ${thisMonday}");
    // print("Thursday of this week: ${thisThursday}");
    // print("First Thursday of this year: ${firstThursday}");
    // print("This week is week #${weekNumber.ceil()}");

    if (weekNumber.ceil() > 4) {
      int tmp = weekNumber.ceil() % 4;
      if (tmp == 0) {
        return '${month}월 4주차';
      }
      return '${month}월 ${tmp}주차';
    } else {
      return '${month}월 ${weekNumber.ceil()}주차';
    }
  }
}
