import 'package:BrandFarm/blocs/home/bloc.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/utils/todays_date.dart';
import 'package:flutter/material.dart';

class SubHomeToDoWidget extends StatelessWidget {
  const SubHomeToDoWidget({
    Key key,
    @required this.state,
  }) : super(key: key);

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 9.0),
      height: 149.0,
      decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .onBackground,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: Offset(0, 4),
              blurRadius: 4.0,
            )
          ]),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 9.0,),
            RichText(text: TextSpan(
                children: [
                  TextSpan(
                    text: '${state.selectedYear}년\n',
                    style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 12.0),
                  ),
                  TextSpan(
                    text: '${state.selectedMonth}월 ${state.selectedDate}일 ${daysOfWeek(index: DateTime(state.selectedYear, state.selectedMonth, state.selectedDate).weekday)}',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 18.0),
                  )
                ]
            )),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Container(width: 2.0 ,height: 15.0,color: Theme.of(context).dividerColor,margin: EdgeInsets.only(right: 5.0),),
                  Expanded(child: Text('일지작성', style: Theme.of(context).textTheme.bodyText2, overflow: TextOverflow.ellipsis,))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Container(width: 2.0 ,height: 15.0,color: Theme.of(context).dividerColor,margin: EdgeInsets.only(right: 5.0),),
                  Expanded(child: Text('일지작성', style: Theme.of(context).textTheme.bodyText2, overflow: TextOverflow.ellipsis,))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Container(width: 2.0 ,height: 15.0,color: Theme.of(context).dividerColor,margin: EdgeInsets.only(right: 5.0),),
                  Expanded(child: Text('일지작성 가나다라ㅏ마마ㅏ바ㅏ상ㄴ ', style: Theme.of(context).textTheme.bodyText2, overflow: TextOverflow.ellipsis,))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Container(width: 2.0 ,height: 15.0,color: Theme.of(context).dividerColor,margin: EdgeInsets.only(right: 5.0),),
                  Expanded(child: Text('일지작성 가나다라ㅏ마마ㅏ바ㅏ상ㄴ ', style: Theme.of(context).textTheme.bodyText2, overflow: TextOverflow.ellipsis,))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
