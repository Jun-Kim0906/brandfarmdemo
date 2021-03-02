import 'package:BrandFarm/blocs/fm_issue/bloc.dart';
import 'package:BrandFarm/blocs/fm_journal/fm_journal_bloc.dart';
import 'package:BrandFarm/blocs/fm_journal/fm_journal_event.dart';
import 'package:BrandFarm/models/sub_journal/sub_journal_model.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/utils/todays_date.dart';
import 'package:BrandFarm/widgets/department_badge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FMIssueDetailScreen extends StatefulWidget {
  @override
  _FMIssueDetailScreenState createState() => _FMIssueDetailScreenState();
}

class _FMIssueDetailScreenState extends State<FMIssueDetailScreen> {
  FMJournalBloc _fmJournalBloc;
  FMIssueBloc _fmIssueBloc;
  //  for testing
  SubJournalIssue testObj;
  List pic = [1, 2, 3];

  String date;
  String weekday;
  String fieldName;

  @override
  void initState() {
    super.initState();
    _fmJournalBloc = BlocProvider.of<FMJournalBloc>(context);
    _fmIssueBloc = BlocProvider.of<FMIssueBloc>(context);
    testObj = SubJournalIssue(
      category: 1,
      comments: 0,
      date: Timestamp.now(),
      fid: '--',
      issid: '--',
      issueState: 1,
      sfmid: '--',
      title: '2021_04_05_작물영양이슈',
      uid: '--',
      contents: contents,
    );
    date = getDate(date: testObj.date);
    fieldName = '한동이네 딸기 농장 필드A';
  }

  String getDate({Timestamp date}) {
    DateTime dt = DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);
    setState(() {
      weekday = daysOfWeek(index: dt.weekday);
    });
    return '${dt.year}년 ${dt.month}월 ${dt.day}일';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 39),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView(
        // shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(),
                SizedBox(height: 31,),
                Divider(height: 26, thickness: 1, color: Color(0xFFDFDFDF),),
                _subtitle(),
                Divider(height: 26, thickness: 1, color: Color(0xFFDFDFDF),),
                SizedBox(height: 8,),
                _infoCard(),
                SizedBox(height: 7,),
                Divider(height: 48, thickness: 1, color: Color(0xFFDFDFDF),),
              ],
            ),
          ),
          (pic.isNotEmpty) ? _imageList() : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Divider(height: 60, thickness: 1, color: Color(0xFFDFDFDF),),
                _contents(),
                SizedBox(height: 30,),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                  onPressed: (){
                    _fmJournalBloc.add(ChangeScreen(navTo: 1));
                  },
                  child: Text('이전'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Text('${testObj.title}',
      style: Theme.of(context).textTheme.bodyText2.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w200,
        color: Colors.black,
      ),);
  }

  Widget _subtitle() {
    return Text('${date} / ${fieldName} / 이슈일지',
      style: Theme.of(context).textTheme.bodyText2.copyWith(
        color: Color(0x80000000),
      ),);
  }

  Widget _infoCard() {
    return Container(
      width: 343,
      height: 137,
      padding: EdgeInsets.fromLTRB(30, 23, 0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: Color(0x4D000000)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('날짜',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Color(0xB3000000),
                ),),
              SizedBox(width: 14,),
              Text('${date} ${weekday}',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),),
            ],
          ),
          SizedBox(height: 19,),
          Row(
            children: [
              Text('카테고리',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Color(0xB3000000),
                ),),
              SizedBox(width: 14,),
              Text('${getCategory(cat: testObj.category)}',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF219653),
                ),),
            ],
          ),
          SizedBox(height: 19,),
          Row(
            children: [
              Text('이슈상태',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Color(0xB3000000),
                ),),
              SizedBox(width: 14,),
              Container(
                width: 32.22,
                height: 20,
                child: FittedBox(
                  child: DepartmentBadge(department: getIssueState(state: testObj.issueState),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageList() {
    return Column(
      children: [
        InkWell(
          onTap: (){},
            child: Row(
              children: [
                SizedBox(width: 32,),
                Text('사진',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                  ),),
                SizedBox(width: 6,),
                Text('${pic.length}',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 18,
                    color: Color(0xFF15B85B),
                ),),
                SizedBox(width: 6,),
                Icon(Icons.arrow_drop_down_outlined, color: Color(0xFFBEBEBE),),
              ],
            ),
        ),
        SizedBox(height: 22,),
        Row(
          children: List.generate(pic.length, (index) {
            return Row(
              children: [
                (index == 0) ? SizedBox(width: 32,) : Container(),
                Container(
                  width: 144,
                  height: 144,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/strawberry.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20,),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _contents() {
    return Text('${testObj.contents}',
      style: Theme.of(context).textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.w300,
        color: Color(0xB3000000),
      ),);
  }

  String getCategory({int cat}) {
    switch(cat) {
      case 1 : {
        return '작물';
      }
      break;
      case 2 : {
        return '시설';
      }
      break;
      case 3 : {
        return '기타';
      }
      break;
    }
  }

  String getIssueState({int state}) {
    switch(state) {
      case 1 : {
        return 'todo';
      }
      break;
      case 2 : {
        return 'doing';
      }
      break;
      case 3 : {
        return 'done';
      }
      break;
    }
  }
}
