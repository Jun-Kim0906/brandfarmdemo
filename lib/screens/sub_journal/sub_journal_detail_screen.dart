import 'package:BrandFarm/utils/unicode/unicode_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SubJournalDetailScreen extends StatefulWidget {
  @override
  _SubJournalDetailScreenState createState() => _SubJournalDetailScreenState();
}

class _SubJournalDetailScreenState extends State<SubJournalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '2021_0405_한동이네딸기농장',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {},
            child: Text('편집'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(left: 10),
                child: Text('2021년 04월 05일 화요일', style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),)),
            SizedBox(height: 12,),
            _weatherCard(),
            SizedBox(height: 41,),
            Container(
                padding: EdgeInsets.only(left: 10),
                child: Text('일일 활동내역', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),)),
            SizedBox(height: 17,),
            _infoContainer(context: context),
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
            )
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('경북 포항시 북구 흫해읍 한동로 558', style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),),
                    SizedBox(width: 3,),
                    Icon(Icons.near_me_outlined, size: 10, color: Colors.white,),
                  ],
                ),
                SizedBox(height: 11,),
                Row(
                  children: [
                    Column(
                      children: [
                        Text('16', style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),
                      ],
                    ),
                    Column(
                      children: [
                        Text(degrees, style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),
                        SizedBox(height: 20,),
                      ],
                    ),
                    SizedBox(width: 13,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('최고: 18', style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),),
                            Column(
                              children: [
                                Text(degrees, style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('최저: 6', style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),),
                            Column(
                              children: [
                                Text(degrees, style: TextStyle(
                                  color: Colors.white,
                                ),),
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
                      Text('맑음', style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),),
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
      width: MediaQuery.of(context).size.width,
      height: 366,
      child: Swiper(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.fromLTRB(11, 24, 11, 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('출하정보'),
                  Divider(thickness: 1, color: Colors.grey,),
                  Row(
                    children: [
                      Text('출하작물'),
                      SizedBox(width: 40,),
                      Text('딸기'),
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.grey,),
                  Row(
                    children: [
                      Text('출하작물'),
                      SizedBox(width: 40,),
                      Text('딸기'),
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.grey,),
                  Row(
                    children: [
                      Text('출하작물'),
                      SizedBox(width: 40,),
                      Text('딸기'),
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.grey,),
                  Row(
                    children: [
                      Text('출하작물'),
                      SizedBox(width: 40,),
                      Text('딸기'),
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.grey,),
                  Row(
                    children: [
                      Text('출하작물'),
                      SizedBox(width: 40,),
                      Text('딸기'),
                    ],
                  ),
                  Divider(thickness: 1, color: Colors.grey,),
                  Row(
                    children: [
                      Text('출하작물'),
                      SizedBox(width: 40,),
                      Text('딸기'),
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
}
