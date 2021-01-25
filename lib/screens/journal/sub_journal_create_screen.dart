import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/utils/todays_date.dart';
import 'package:flutter/material.dart';
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
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    DateBar(),
                    SizedBox(
                      height: 10.0,
                    ),
                    InputTitleBar(),
                    Row(
                      children: [
                        Text('일일 활동내역 입력',
                            style: Theme.of(context).textTheme.headline5),
                        Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text('편집'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class InputTitleBar extends StatelessWidget {
  const InputTitleBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('제목', style: Theme.of(context).textTheme.headline5),
        SizedBox(width: 8.0),
        Expanded(
            child: TextField(
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
    );
  }
}

class DateBar extends StatelessWidget {
  const DateBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
