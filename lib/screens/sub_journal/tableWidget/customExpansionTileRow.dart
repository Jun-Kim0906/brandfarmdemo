import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:flutter/material.dart';

class CustomExpansionTileRow extends StatelessWidget {
  const CustomExpansionTileRow({
    Key key,
    this.title,
    this.content,
    this.titleStyle,
    this.contentStyle,
  }) : super(key: key);

  final String title;
  final String content;
  final TextStyle titleStyle;
  final TextStyle contentStyle;

  @override
  Widget build(BuildContext context) {
    final TextStyle _titleStyle = this.titleStyle ?? Theme
        .of(context)
        .textTheme
        .bodyText1;
    final TextStyle _contentStyle = this.contentStyle ?? Theme
        .of(context)
        .textTheme
        .bodyText1;
    return Row(
      children: [
        SizedBox(
          width: defaultPadding,
        ),
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: _titleStyle,
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            content,
            style: _contentStyle,
          ),
        ),
      ],
    );
  }
}
