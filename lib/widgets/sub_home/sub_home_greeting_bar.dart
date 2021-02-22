import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:flutter/material.dart';

class SubHomeGreetingBar extends StatelessWidget {
  const SubHomeGreetingBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 10.0),
      child: Row(
        children: [
          RichText(
              text:
              TextSpan(
                  text: "안녕하세요 ${UserUtil.getUser().name}님,\n좋은 하루되세요 :)",
                  style: Theme.of(context).textTheme.headline3
              )),
          Spacer(),
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                color: Color(0xffbfbfbf),
                offset: Offset(0.0, 4.0),
                spreadRadius: 2.0,
                blurRadius: 4.0,
              )
            ]),
            child: CircleAvatar(
                radius: 34.0,
                backgroundImage: NetworkImage(
                    'https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=800&q=70')),
          )
        ],
      ),

    );
  }
}
