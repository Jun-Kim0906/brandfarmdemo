import 'package:BrandFarm/blocs/journal/bloc.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/utils/unicode/unicode_util.dart';
import 'package:BrandFarm/utils/themes/farm_theme_data.dart';
import 'package:BrandFarm/widgets/department_badge.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';

class SubJournalDetailScreen extends StatefulWidget {
  String from;
  int index;
  List list;

  SubJournalDetailScreen({
    Key key,
    String from,
    int state,
    int index,
    List list,
  })  : from = from ?? 'journal',
        index = index ?? 0,
        list = list,
        super(key: key);

  @override
  _SubJournalDetailScreenState createState() => _SubJournalDetailScreenState();
}

class _SubJournalDetailScreenState extends State<SubJournalDetailScreen> {
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  TextEditingController _textEditingController;
  JournalBloc _journalBloc;
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  List commentList = [
    '최브팜',
    '박브팜',
  ];
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  // double height;
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    _journalBloc = BlocProvider.of<JournalBloc>(context);
    _textEditingController = TextEditingController();
    // height = MediaQuery.of(context).size.height + (MediaQuery.of(context).size.height / 2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JournalBloc, JournalState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            title: Text(
              '2021_0405_한동이네딸기농장',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {},
                child: Text(
                  '편집',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          body: (widget.from == 'journal')
              ? _journalBody(
                  context: context,
                  state: state,
                )
              : _issueBody(
                  context: context,
                  state: state,
                ),
        );
      },
    );
  }

  Widget _issueBody({BuildContext context, JournalState state}) {
    List pic = state.issueImageList
        .where((element) => element.issid == widget.list[widget.index].issid)
        .toList();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        TextEditingController().clear();
      },
      child: ListView(
        children: [
          SizedBox(
            height: 13,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Container(
              height: 150,
              padding: EdgeInsets.fromLTRB(46, 23, 46, 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1,
                  color: Color(0x30000000),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 26,
                        child: Text('날짜',
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Color(0x70000000),
                                    )),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Text(
                        '${DateFormat('yMMMMEEEEd', 'ko').format(DateTime.fromMicrosecondsSinceEpoch(widget.list[widget.index].date.microsecondsSinceEpoch))}',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 52,
                        child: Text('카테고리',
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Color(0x70000000),
                                    )),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        getCategoryInfo(
                            category: widget.list[widget.index].category),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Color(0xFF219653),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 52,
                        child: Text('이슈상태',
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Color(0x70000000),
                                    )),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      DepartmentBadge(
                          department: getIssueState(
                              state: widget.list[widget.index].issueState)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
              widget.list[widget.index].contents,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          (pic.isNotEmpty) ? Divider(
            height: 0,
            thickness: 1,
            color: Color(0x20000000),
          ) : Container(),
          (pic.isNotEmpty)
              ? SizedBox(
                  height: 10,
                )
              : Container(),
          (pic.isNotEmpty)
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Row(
                    children: [
                      Text(
                        '사진',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Text(
                        '${pic.length}',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFF15B85B),
                            ),
                      ),
                    ],
                  ),
                )
              : Container(),
          (pic.isNotEmpty)
              ? SizedBox(
                  height: 9,
                )
              : Container(),
          (pic.isNotEmpty)
              ? _addPictureBar(context: context, pic: pic)
              : Container(),
          (pic.isNotEmpty) ? SizedBox(height: 17,) : Container(),
          (commentList.isNotEmpty) ? Divider(
            height: 0,
            thickness: 1,
            color: Color(0x20000000),
          ) : Container(),
          _comment(context: context),
        ],
      ),
    );
  }

  String getCategoryInfo({int category}) {
    switch (category) {
      case 1:
        {
          return '작물';
        }
        break;
      case 2:
        {
          return '시설';
        }
        break;
      case 3:
        {
          return '기타';
        }
        break;
      default:
        {
          return '--';
        }
    }
  }

  String getIssueState({int state}) {
    switch (state) {
      case 1:
        {
          return 'todo';
        }
        break;
      case 2:
        {
          return 'doing';
        }
        break;
      case 3:
        {
          return 'done';
        }
        break;
      default:
        {
          return '--';
        }
        break;
    }
  }

  Widget _journalBody({BuildContext context, JournalState state}) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        TextEditingController().clear();
      },
      child: ListView(
        children: [
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '2021년 04월 05일 화요일',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                )),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _weatherCard(),
          ),
          SizedBox(
            height: 41,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '일일 활동내역',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )),
          ),
          SizedBox(
            height: 15,
          ),
          _infoContainer(context: context),
          SizedBox(
            height: 31,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    '사진',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    '4',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF219653),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _imageList(context: context),
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '과정 기록',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )),
          ),
          SizedBox(
            height: 12,
          ),
          _record(context: context),
          SizedBox(
            height: 55,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      '댓글',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      '2',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF219653),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.grey,
          ),
          _comment(context: context),
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.grey,
          ),
          SizedBox(
            height: 9,
          ),
          _writeComment(context: context),
        ],
      ),
    );
  }

  Widget _weatherCard() {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(14, 13, 13, 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.0,
                1.0,
              ],
              colors: [
                Color(0xFF3195DE),
                Color(0xFF9AECFE),
              ],
            )),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '경북 포항시 북구 흫해읍 한동로 558',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Icon(
                      Icons.near_me_outlined,
                      size: 10,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: 11,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '16',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          degrees,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '최고: 18',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  degrees,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '최저: 6',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  degrees,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/weather_image/sunny.png',
                        height: 36,
                        width: 45,
                      ),
                      Text(
                        '맑음',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoContainer({BuildContext context}) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 11),
      height: 420,
      child: Swiper(
        itemHeight: 420,
        itemWidth: MediaQuery.of(context).size.width,
        layout: SwiperLayout.DEFAULT,
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
          color: Colors.grey,
          activeColor: Color(0xFF219653),
        )),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.fromLTRB(22, 1, 22, 50),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(11, 24, 11, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 17,
                      ),
                      Text(
                        '출하정보',
                        style: Theme.of(context)
                            .textTheme
                            .infoContainerTitleTextTheme
                            .copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 17,
                      ),
                      Container(
                        width: 52,
                        child: Text(
                          '출하작물',
                          style: Theme.of(context)
                              .textTheme
                              .infoContainerTitleTextTheme,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        '딸기',
                        style: Theme.of(context)
                            .textTheme
                            .infoContainerBodyTextTheme,
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 17,
                      ),
                      Container(
                        width: 52,
                        child: Text(
                          '출하경로',
                          style: Theme.of(context)
                              .textTheme
                              .infoContainerTitleTextTheme,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        '얄리리 얄랑셩 얄라리 얄라',
                        style: Theme.of(context)
                            .textTheme
                            .infoContainerBodyTextTheme,
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 17,
                      ),
                      Container(
                        width: 52,
                        child: Text(
                          '출하단위',
                          style: Theme.of(context)
                              .textTheme
                              .infoContainerTitleTextTheme,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        '1',
                        style: Theme.of(context)
                            .textTheme
                            .infoContainerBodyTextTheme,
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 17,
                      ),
                      Container(
                        width: 52,
                        child: Text(
                          '출하숫자',
                          style: Theme.of(context)
                              .textTheme
                              .infoContainerTitleTextTheme,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        '50 kg',
                        style: Theme.of(context)
                            .textTheme
                            .infoContainerBodyTextTheme,
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 17,
                      ),
                      Container(
                        width: 52,
                        child: Text(
                          '등급',
                          style: Theme.of(context)
                              .textTheme
                              .infoContainerTitleTextTheme,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        '특',
                        style: Theme.of(context)
                            .textTheme
                            .infoContainerBodyTextTheme,
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 17,
                      ),
                      Container(
                        width: 52,
                        child: Text(
                          '단위가격',
                          style: Theme.of(context)
                              .textTheme
                              .infoContainerTitleTextTheme,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        '9000 원',
                        style: Theme.of(context)
                            .textTheme
                            .infoContainerBodyTextTheme,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _addPictureBar({
    BuildContext context,
    List pic,
  }) {
    return Container(
      height: 74,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: pic.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              SizedBox(
                width: defaultPadding,
              ),
              _image(
                context: context,
                url: pic[index].url,
              ),
              (index == pic.length - 1)
                  ? SizedBox(
                      width: defaultPadding,
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Widget _image({BuildContext context, String url}) {
    return Container(
      height: 74.0,
      width: 74.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            url,
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.srcATop),
        ),
      ),
    );
  }

  Widget _imageList({BuildContext context}) {
    return Container(
      height: 85,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return (index == 0)
                ? Container(
                    height: 85,
                    width: 85,
                    color: Colors.grey,
                  )
                : Row(
                    children: [
                      SizedBox(
                        width: 1,
                        height: 85,
                      ),
                      Container(
                        height: 85,
                        width: 85,
                        color: Colors.grey,
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget _record({BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 11, 19, 11),
          child: Text(
            '포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항',
            style: TextStyle(
              fontSize: 16,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _comment({BuildContext context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 146,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: commentList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  _customListTile(context: context, index: index),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _customListTile({BuildContext context, int index}) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 37,
            width: 37,
            decoration: new BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                commentList[index],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '1시간 전',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 7,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '수고하셨습니다. 끝까지 힘써주세요',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 11,
                  ),
                  Text(
                    '답글 달기',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _writeComment({BuildContext context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 92,
      child: Column(
        children: [
          SizedBox(
            height: 9,
          ),
          Row(
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: new BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 9,
              ),
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(23),
                    )),
                    hintText: '댓글 달기...',
                    contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 9),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
