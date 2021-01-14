import 'package:BrandFarm/blocs/authentication/bloc.dart';
import 'package:BrandFarm/screens/notification/notification_list_screen.dart';
import 'package:BrandFarm/utils/todays_date.dart';
import 'package:BrandFarm/widgets/brandfarm_icons.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JournalListScreen extends StatefulWidget {
  @override
  _JournalListScreenState createState() => _JournalListScreenState();
}

class _JournalListScreenState extends State<JournalListScreen> {
  DateTime now = DateTime.now();
  DateTime selectedDate;
  bool _isVisible;
  double _elevation = 0;
  List items;
  DateTime _chosenDateTime;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    items = List<int>.generate(21, (i) => 21 - i);
    _isVisible = true;
    selectedDate = DateTime.now();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          print("**** ${_isVisible} up");
          setState(() {
            _isVisible = false;
            _elevation = 3.0;
          });
        }
      } else {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            print("**** ${_isVisible} down");
            setState(() {
              _isVisible = true;
              _elevation = 0.0;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _sliverList(context),
      floatingActionButton: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        // height: _isVisible ? 45.0 : 0.0,
        alignment: _isVisible ? Alignment(0,1) : Alignment(0, 1.5),
        child: Wrap(
          children: [
            FloatingActionButton.extended(
              icon: Icon(Icons.edit),
              label: Text('일지쓰기'),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _appBar() {
    return AppBar(
      // elevation: _elevation,
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
    );
  }

  Widget _defaultListView() {
    return Padding(
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
                    Text(
                      '2021년 2월',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontSize: 18),
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
                    index: now.subtract(Duration(days: index + 1)).weekday),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sliverList(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF37949B),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Row(
              children: [
                Text(
                  '한동이네 딸기 농장',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold),
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
            floating: true,
            // flexibleSpace: Placeholder(),
            expandedHeight: 30,
          ),
          SliverPersistentHeader(
            delegate: _Delegate(_isVisible),
            pinned: true,
            floating: true,
          ),
        ];
      },
      // body: Container(),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          int item = items[index];
          return Dismissible(
            background: Container(
              padding: EdgeInsets.only(left: 15),
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.delete),
                ],
              ),
            ),
            secondaryBackground: Container(
              padding: EdgeInsets.only(right: 15),
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete),
                ],
              ),
            ),
            key: Key(item.toString()),
            onDismissed: (direction) {
              setState(() {
                items.removeAt(index);
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: list_tile(
                  date: items[index],
                  week: daysOfWeek(
                      index: now.subtract(Duration(days: index + 1)).weekday)),
            ),
          );
        },
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
}

class _Delegate extends SliverPersistentHeaderDelegate{
  _Delegate(this._isVisible);

  int index = 2;
  bool _isVisible;

  // @override
  // double get minExtent => _row.preferredSize.height;

  // @override
  // double get maxExtent => _row.preferredSize.height;

  @override
  double get minExtent => 48;

  @override
  double get maxExtent => 48;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: (_isVisible)
          ? BoxDecoration(
              color: Colors.white,
            )
          : BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // _showDatePicker(context);
            },
            child: Row(
              children: [
                Text(
                  '2021년 2월',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontSize: 18),
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
                _settingModalBottomSheet(context);
              },
            ),
          ),
        ],
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
                      : Container(height: 1, width: 1,),
                  onTap: () => {
                    Navigator.pop(context),
                    // setState(() {
                    //   fieldListOptions = '가나다순';
                    //   index = 1;
                    // }),
                  }),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
              ListTile(
                leading: Text('거리순'),
                title: Text(''),
                trailing: (index == 2)
                    ? Icon(Icons.check)
                    : Container(height: 1, width: 1,),
                onTap: () => {
                  Navigator.pop(context),
                  // setState(() {
                  //   fieldListOptions = '거리순';
                  //   index = 2;
                  // }),
                },
              ),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
              ListTile(
                leading: Text('최근 열람순'),
                title: Text(''),
                trailing: (index == 3)
                    ? Icon(Icons.check)
                    : Container(height: 1, width: 1,),
                onTap: () => {
                  Navigator.pop(context),
                  // setState(() {
                  //   fieldListOptions = '최근 열람순';
                  //   index = 3;
                  // }),
                },
              ),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
              ListTile(
                leading: Text('잘생긴순'),
                title: Text(''),
                trailing: (index == 4)
                    ? Icon(Icons.check)
                    : Container(height: 1, width: 1,),
                onTap: () => {
                  Navigator.pop(context),
                  // setState(() {
                  //   fieldListOptions = '잘생긴순';
                  //   index = 4;
                  // }),
                },
              ),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
            ],
          );
        });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class showDatePicker extends StatefulWidget {
  showDatePicker({Key key}) : super(key: key);
  @override
  _showDatePickerState createState() => _showDatePickerState();
}

class _showDatePickerState extends State<showDatePicker> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  // showCupertinoModalPopup is a built-in function of the cupertino library
  // void _showCupertinoModalPopup(
  //     context: ctx,
  //     builder: (_) => Container(
  //       height: 500,
  //       color: Color.fromARGB(255, 255, 255, 255),
  //       child: Column(
  //         children: [
  //           Container(
  //             height: 400,
  //             child: CupertinoDatePicker(
  //                 initialDateTime: DateTime.now(),
  //                 onDateTimeChanged: (val) {
  //                   setState(() {
  //                     _chosenDateTime = val;
  //                   });
  //                 }),
  //           ),
  //
  //           // Close the modal
  //           CupertinoButton(
  //             child: Text('OK'),
  //             onPressed: () => Navigator.of(ctx).pop(),
  //           )
  //         ],
  //       ),
  //     ));
}