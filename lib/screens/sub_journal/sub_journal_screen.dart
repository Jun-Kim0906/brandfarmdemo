import 'package:BrandFarm/blocs/journal/bloc.dart';
import 'package:BrandFarm/utils/todays_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sub_journal_list_screen.dart';

class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  TextEditingController _textEditingController1;
  TextEditingController _textEditingController2;

  @override
  void initState() {
    super.initState();
    _textEditingController1 = TextEditingController();
    _textEditingController2 = TextEditingController();
  }

  void dispose() {
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: _appbar(),
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${year}년 ${month}월 ${day}일 ${weekday}'),
                  Icon(CupertinoIcons.calendar),
                ],
              ),
              SizedBox(height: 37,),
              Row(
                children: [
                  Text('제목'),
                  SizedBox(width: 2,),
                  Expanded(
                    child: TextField(
                      controller: _textEditingController1,
                      autofocus: false,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: '2021_0405_한동이네딸기농장',
                        contentPadding: EdgeInsets.fromLTRB(28, 0, 0, 0 ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 51,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('일일 활동내역 입력'),
                  Text('편집'),
                ],
              ),
              SizedBox(height: 43,),
              Text('사진 첨부'),
              SizedBox(height: 18,),
              Row(
                children: [
                  Container(
                    width: 74,
                    height: 74,
                    color: Colors.grey,
                    child: InkWell(
                      onTap: (){
                        
                      },
                      child: Center(
                        child: Text('+', style: TextStyle(
                            color: Colors.white, fontSize: 35),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 42,),
              Text('과정 기록'),
              SizedBox(height: 14,),
              TextField(
                controller: _textEditingController2,
                autofocus: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  hintText: '내용을 입력해주세요',
                  contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 0 ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _appbar extends StatelessWidget {
  const _appbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
          icon: Icon(Icons.arrow_back_ios, )
      ),
      title: Text('성장일지 작성'),
      centerTitle: true,
      actions: [
        Container(
          height: 10,
          width: 59,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (BuildContext context) => JournalBloc(),
                    child: JournalListScreen(),
                  )),
              );
            },
            child: Center(
                child: Text('완료')
            ),
          ),
        ),
      ],
    );
  }
}
