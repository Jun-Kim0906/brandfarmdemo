import 'package:BrandFarm/blocs/journal/bloc.dart';
import 'package:BrandFarm/screens/sub_journal/sub_journal_detail_screen.dart';
import 'package:BrandFarm/utils/todays_date.dart';
import 'package:BrandFarm/widgets/loading/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class JournalListScreen extends StatefulWidget {
  JournalListScreen({Key key}) : super(key: key);

  @override
  _JournalListScreenState createState() => _JournalListScreenState();
}

class _JournalListScreenState extends State<JournalListScreen> {
  static final _containerHeight = 100.0;

  // var _fromTop = -_containerHeight;
  var _fromTop = 0.0;
  var _allowReverse = true, _allowForward = true;
  var _prevOffset = 0.0;
  var _prevForwardOffset = -_containerHeight;
  var _prevReverseOffset = 0.0;

  JournalBloc _journalBloc;
  DateTime selectedDate;
  DateTime _chosenDateTime;
  bool _isVisible;
  int index = 2;
  String fieldListOptions = '최신순';
  double scrollOffset = 0.0;
  int _tab;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _journalBloc = BlocProvider.of<JournalBloc>(context);
    _journalBloc.add(GetInitialList());

    _isVisible = true;
    selectedDate = DateTime.now();
    _tab = 0;

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        scrollOffset = _scrollController.offset;
      });
      // print('offset = ${_scrollController.offset}');
      _manageFab();
      _listenForScrollPosition();
      _manageTopContainer();
    });
  }

  void _manageFab() {
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
  }

  void _listenForScrollPosition() {
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
  }

  // entire logic is inside this listener for ListView
  void _manageTopContainer() {
    double offset = _scrollController.offset;
    var direction = _scrollController.position.userScrollDirection;

    if (direction == ScrollDirection.reverse) {
      _allowForward = true;
      if (_allowReverse) {
        _allowReverse = false;
        _prevOffset = offset;
        _prevForwardOffset = _fromTop;
      }

      var difference = offset - _prevOffset;
      _fromTop = _prevForwardOffset + difference;
      if (_fromTop > 0) _fromTop = 0;
    } else if (direction == ScrollDirection.forward) {
      _allowReverse = true;
      if (_allowForward) {
        _allowForward = false;
        _prevOffset = offset;
        _prevReverseOffset = _fromTop;
      }

      var difference = offset - _prevOffset;
      _fromTop = _prevReverseOffset + difference;
      if (_fromTop < -_containerHeight) _fromTop = -_containerHeight;
    }
    setState(() {}); // for simplicity I'm calling setState here, you can put bool values to only call setState when there is a genuine change in _fromTop
  }
  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JournalBloc, JournalState>(
      builder: (context, state) {
        return (state.isLoading)
            ? Loading()
            : DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: _appBar(state: state, context: context),
                  body: TabBarView(
                    children: [
                      Stack(
                        children: [
                          _ListViewByMonth(state: state),
                          Positioned(
                            top: _fromTop,
                            left: 0,
                            right: 0,
                            child: _yourContainer(),
                          ),
                        ],
                      ),
                      Center(
                          child: Text(
                        '이슈일지',
                        style: TextStyle(color: Colors.black),
                      )),
                    ],
                  ),
                  floatingActionButton: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    alignment: _isVisible ? Alignment(0, 1) : Alignment(0, 1.5),
                    child: Wrap(
                      children: [
                        FloatingActionButton.extended(
                          heroTag: 'journal',
                          label: Text('일지쓰기', style: TextStyle(color: Colors.white),),
                          icon: Image.asset('assets/Journal/memo.png', height: 20, width: 20, color: Colors.white,),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SubJournalDetailScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                ),
              );
      },
    );
  }

  Widget _appBar({JournalState state, BuildContext context}) {
    return AppBar(
      // elevation: 3.0,
      leading: IconButton(
        padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
        iconSize: 19.0,
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        '일지목록',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: Container(
          // color: Colors.yellow,
          // margin: EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
            color: Color(0x04000000),
            border: Border(
              top: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
          child: TabBar(
            // indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            onTap: (index){
              setState(() {
                _tab = index;
              });
              // print(_tab);
            },
            indicator: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 2,
                  color: Color(0xFF15B833),
                ),
              ),
            ),
            // labelColor: Colors.yellow,
            labelColor: Color(0xFF15B833),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF15B833),
            tabs: [
              Tab(
                  icon: Image.asset(
                    'assets/Journal/sprout.png',
                    width: 28,
                    height: 22,
                    color: (_tab == 0) ? Color(0xFF15B833) : Colors.grey,
                  ),
                  text: '성장일지'),
              Tab(
                  icon: Image.asset(
                    'assets/Journal/community.png',
                    width: 28,
                    height: 22,
                    color: (_tab == 1) ? Color(0xFF15B833) : Colors.grey,
                  ),
                  text: '이슈일지'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _yourContainer() {
    return Opacity(
      opacity: 1 - (-_fromTop / _containerHeight),
      child: Container(
        height: _containerHeight,
        color: Colors.red,
        alignment: Alignment.center,
        child: Text("Your Container", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _ListViewByMonth({JournalState state}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ListView.builder(
        controller: _scrollController,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          int end;
          String monthBefore;
          String currentMonth;
          String monthAfter;
          currentMonth = DateFormat('MM').format(state.items[index]);
          if (index == 0) {
            return _firstOfList(
                currentMonth: currentMonth, state: state, index: index);
          } else {
            monthBefore = DateFormat('MM').format(state.items[index - 1]);

            if (index + 1 < state.items.length) {
              monthAfter = DateFormat('MM').format(state.items[index + 1]);
            }

            if (currentMonth != monthAfter) {
              end = 0;
            } else {
              end = 1;
            }

            if (currentMonth != monthBefore) {
              return _firstOfList(
                  currentMonth: currentMonth, state: state, index: index);
            } else {
              return _customListTile(
                date: int.parse(DateFormat('dd').format(state.items[index])),
                week: daysOfWeek(index: state.items[index].weekday),
                end: end,
              );
            }
          }
        },
      ),
    );
  }

  Widget _firstOfList({String currentMonth, JournalState state, int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              height: 43,
            ),
            _monthWidget(
                month: currentMonth,
                year: DateFormat('yyyy').format(state.items[index]),
                state: state,
                index: index),
            SizedBox(
              height: 21,
            ),
          ],
        ),
        _customListTile(
          date: int.parse(DateFormat('dd').format(state.items[index])),
          week: daysOfWeek(index: state.items[index].weekday),
          end: 1,
        ),
      ],
    );
  }

  Widget _ListViewByWeekNum({JournalState state}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Scrollbar(
        child: ListView.builder(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            String weekNumBefore;
            String weekNumNow;
            String weekNumAfter;
            weekNumNow = _weekOfMonth(date: state.items[index]);
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 43,
                      ),
                      _weekOfMonthWidget(
                          month: DateFormat('MM').format(state.items[index]),
                          weekOfMonth: weekNumNow,
                          state: state,
                          index: index),
                      SizedBox(
                        height: 21,
                      ),
                    ],
                  ),
                  _customListTile(
                    date:
                        int.parse(DateFormat('dd').format(state.items[index])),
                    week: daysOfWeek(index: state.items[index].weekday),
                    end: 1,
                  ),
                ],
              );
            } else {
              weekNumBefore = _weekOfMonth(date: state.items[index - 1]);
              if (index + 1 < state.items.length) {
                weekNumAfter = _weekOfMonth(date: state.items[index + 1]);
              }
              String month_before =
                  DateFormat('MM').format(state.items[index - 1]);
              String month_now = DateFormat('MM').format(state.items[index]);
              String _month;
              int end;
              if (weekNumNow != weekNumBefore && month_before != month_now) {
                _month = month_now;
              } else if (weekNumNow != weekNumBefore &&
                  int.parse(DateFormat('dd').format(state.items[index])) > 25) {
                DateTime curr = state.items[index].add(Duration(days: 7));
                _month = DateFormat('MM').format(curr);
              } else {
                _month = month_before;
              }
              if (weekNumNow != weekNumAfter) {
                end = 0;
              } else {
                end = 1;
              }
              if (weekNumNow != weekNumBefore) {
                // if(index*77+94 <= scrollOffset.toInt()) {
                //   _journalBloc.add(ChangeDate(month: _month));
                // }
                // WidgetsBinding.instance.addPostFrameCallback(_afterLayout(state: state, index: 0));
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (weekNumNow != weekNumBefore)
                        ? Column(
                            children: [
                              SizedBox(
                                height: 43,
                              ),
                              _weekOfMonthWidget(
                                  month: _month,
                                  weekOfMonth: weekNumNow,
                                  state: state,
                                  index: index),
                              SizedBox(
                                height: 21,
                              ),
                            ],
                          )
                        : Container(),
                    _customListTile(
                      date: int.parse(
                          DateFormat('dd').format(state.items[index])),
                      week: daysOfWeek(index: state.items[index].weekday),
                      end: 1,
                    ),
                  ],
                );
              } else {
                return _customListTile(
                  date: int.parse(DateFormat('dd').format(state.items[index])),
                  week: daysOfWeek(index: state.items[index].weekday),
                  end: end,
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget _currentMonth({JournalState state, BuildContext context}) {
    return Container(
      // height: 214,
      // width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 110,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.year,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: () {
                  print('sdfsfd');
                },
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.month,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: () => _showDatePicker(context),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.camera_circle,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _monthWidget(
      {String month, String year, JournalState state, int index}) {
    return InkWell(
      onTap: () {},
      child: Container(
        // key: state.globalKey[index],
        height: 30,
        width: 112,
        child: Row(
          children: [
            Text(
              '${year}년 ${month}월',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
          ],
        ),
        // decoration: BoxDecoration(
        //   color: Color(0x10000000),
        //   shape: BoxShape.rectangle,
        //   borderRadius: BorderRadius.circular(15),
        // ),
      ),
    );
  }

  Widget _weekOfMonthWidget(
      {String month, String weekOfMonth, JournalState state, int index}) {
    return Container(
      // key: state.globalKey[index],
      height: 30,
      width: 87,
      child: Center(
        child: Text(
          '${month}월 ${weekOfMonth}주차',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      // decoration: BoxDecoration(
      //   color: Color(0x10000000),
      //   shape: BoxShape.rectangle,
      //   borderRadius: BorderRadius.circular(15),
      // ),
    );
  }

  Widget _customListTile({int date, String week, int end}) {
    return Container(
      height: 77,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SubJournalDetailScreen()),
          );
        },
        child: Container(
          margin: EdgeInsets.all(0.0),
          padding: EdgeInsets.all(0),
          height: 77,
          child: Row(
            children: [
              // Container(
              //   height: 77,
              //   width: 2.0,
              //   color: Colors.black,
              // ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            leadingIcon(date: date, week: week),
                          ],
                        ),
                        SizedBox(
                          width: 19,
                        ),
                        titleNSubtitle(),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              trailingIcon(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    (end == 1)
                        ? Divider(
                            height: 14,
                            // indent: 10,
                            // endIndent: 10,
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget list_tile({int date, String week}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SubJournalDetailScreen()),
        );
      },
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
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 36,
                ),
              ),
            ),
            Text(
              week,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleNSubtitle() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 207,
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
            width: 207,
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

  void _showDatePicker(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            _chosenDateTime = val;
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ));
  }

  String _weekOfMonth({DateTime date}) {
    // get today's date
    var now = date;

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
        return '4';
      }
      return '${tmp}';
    } else {
      return '${weekNumber.ceil()}';
    }
    // return '${weekNumber.ceil()}';
  }
}

class DatePicker {
  BuildContext context;
  final ValueChanged<DateTime> onDateTimeChanged;

  DatePicker(this.context, {@required this.onDateTimeChanged});

  void show() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            child: Stack(
              children: <Widget>[
                CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (date) {
                    onDateTimeChanged(date);
                  },
                  initialDateTime: DateTime.now(),
                  minimumDate: DateTime(DateTime.now().year - 1),
                  maximumDate: DateTime(DateTime.now().year + 3),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CupertinoButton(
                    child: Text('Done'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
