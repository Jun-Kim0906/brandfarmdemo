import 'package:BrandFarm/utils/unicode/unicode_util.dart';
import 'package:BrandFarm/utils/themes/farm_theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SubJournalDetailScreen extends StatefulWidget {
  @override
  _SubJournalDetailScreenState createState() => _SubJournalDetailScreenState();
}

class _SubJournalDetailScreenState extends State<SubJournalDetailScreen> {
  TextEditingController _textEditingController;

  List commentList = [
    '최브팜',
    '박브팜',
  ];

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
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
      body: GestureDetector(
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


