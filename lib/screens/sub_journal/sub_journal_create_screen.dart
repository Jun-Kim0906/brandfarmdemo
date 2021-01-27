import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/utils/todays_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubJournalCreateScreen extends StatefulWidget {
  @override
  _SubJournalCreateScreenState createState() => _SubJournalCreateScreenState();
}

class _SubJournalCreateScreenState extends State<SubJournalCreateScreen> {
  JournalCreateBloc _journalCreateBloc;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        cubit: _journalCreateBloc,
        listener: (BuildContext context, JournalCreateState state) {},
        child: BlocBuilder<JournalCreateBloc, JournalCreateState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  '성장일지 작성',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                centerTitle: true,
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: defaultPadding),
                    child: Center(
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          '완료',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Color(0x4D000000)),
                        ),
                        padding: EdgeInsets.zero,
                        height: 30.0,
                        minWidth: 59.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Color(0x4D000000),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    DateBar(),
                    SizedBox(
                      height: 10.0,
                    ),
                    InputTitleBar(),
                    SizedBox(height: 15.0,),
                    InputActivityBar(),
                    SizedBox(height: 15.0,),
                    AddPictureBar(),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('과정 기록', style: Theme.of(context).textTheme.headline5),
                          SizedBox(height: 8.0,),
                          Scrollbar(
                            child: TextField(
                              scrollPhysics: RangeMaintainingScrollPhysics(),
                              minLines: null,
                              maxLines: 8,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                hintText: '내용을 입력해주세요',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 18.0, color: Color(0x2C000000)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(),
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class AddPictureBar extends StatelessWidget {
  const AddPictureBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text('사진첨부', style: Theme.of(context).textTheme.headline5),
        ),
        SizedBox(height: 5.0,),
        Container(
          height: 100.0,
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index){
              return index == 0
                  ? Row(
                    children: [
                      SizedBox(width: defaultPadding,),
                      Center(
                        child: InkWell(
                onTap: (){},
                        child: Container(
                          height: 74.0,
                          width: 74.0,
                          decoration: BoxDecoration(
                            color: Color(0x1a000000)
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 34.0,
                            ),
                          ),
                        )),
                      ),
                    ],
                  )
                  : Container();
            },
          ),
        ),
      ],
    );
  }
}

class InputActivityBar extends StatelessWidget {
  const InputActivityBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          Text('일일 활동내역 입력',
              style: Theme.of(context).textTheme.headline5),
          Spacer(),
          TextButton(
            onPressed: () {},
            child: Text('편집', style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18.0, color: Color(0xb3000000)),),
          )
        ],
      ),
    );
  }
}

class InputTitleBar extends StatelessWidget {
  const InputTitleBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('제목', style: Theme.of(context).textTheme.headline5),
          SizedBox(width: 8.0),
          Expanded(
              child: TextField(
                style:
          Theme.of(context).textTheme
          .bodyText1
          .copyWith(fontSize: 18.0),
            decoration: InputDecoration(
                hintText: '2021_0405_한동이네딸기농장',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18.0, color: Color(0x2C000000)),
                isDense: true,
                contentPadding: EdgeInsets.all(5.0)),
          ))
        ],
      ),
    );
  }
}

class DateBar extends StatelessWidget {
  const DateBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          Text('$year년 $month월 $day일 $weekday',
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontSize: 16.0, color: Theme.of(context).primaryColor)),
          Spacer(),
          SvgPicture.asset(
            'assets/svg_icon/calendar_icon.svg',
            color: Color(0xb3000000),
          ),
        ],
      ),
    );
  }
}
