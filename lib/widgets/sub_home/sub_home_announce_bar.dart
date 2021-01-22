import 'package:flutter/material.dart';

class SubHomeAnnounceBar extends StatelessWidget {
  const SubHomeAnnounceBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.5),
          color: Color(0xfff5f5f5)),
      child: Container(
        padding:
        const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
        child: Row(
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: Color(0xfffdd015),
            ),
            SizedBox(
              width: 7.0,
            ),
            Expanded(
              child: Text(
                '4/5 - 안전에 유의하시길 당부드립니다.',
                style: Theme.of(context).textTheme.overline
                    .copyWith(color: Color(0xff8b8b8b)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
