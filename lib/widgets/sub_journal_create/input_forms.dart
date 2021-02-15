import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:flutter/material.dart';

class InputForm1 extends StatelessWidget {
  const InputForm1({
    Key key,
    @required TextEditingController textEditingController,
    @required this.changed,
    this.validatePassword,
    @required this.title,
  }): _controller = textEditingController,
        super(key: key);

  final TextEditingController _controller;
  final ValueChanged<String> changed;
  final String validatePassword;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
            child: Text(
              title,
              style: Opacity70Style,
            ),
            width: (MediaQuery.of(context).size.width - 32) * 0.25,
          ),
          Expanded(
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyText1,
              textInputAction: TextInputAction.done,
              onChanged: changed,
              controller: _controller,
              decoration: InputDecoration(
                  errorText: validatePassword,
                  hintText: '내용을 입력해주세요',
                  contentPadding:
                  EdgeInsets.only(left: 3.0, bottom: 5.0),
                  hintStyle: HintTextStyle,
                  isDense: true),
            ),
          )
        ],
      ),
    );
  }
}

class InputForm2 extends StatelessWidget {
  const InputForm2({
    Key key,
    @required TextEditingController textEditingController,
    @required this.changed,
    @required this.unitPickPressed,
    @required this.unitString,
    @required this.title,
  })  : _controller = textEditingController,
        super(key: key);

  final String title;
  final ValueChanged<String> changed;
  final TextEditingController _controller;
  final VoidCallback unitPickPressed;
  final String unitString;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
            width: (MediaQuery.of(context).size.width - 32) * 0.25,
            child: Text(
              title,
              style: Opacity70Style,
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 32) * 0.41,
            margin: EdgeInsets.only(right: 20),
            child: TextField(
              style: Theme.of(context).textTheme.bodyText1,
              onChanged: changed,
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: '내용을 입력해주세요',
                  contentPadding: EdgeInsets.only(left: 3.0, bottom: 5.0),
                  hintStyle: HintTextStyle,
                  isDense: true),
            ),
          ),
          TextButton(
              onPressed: unitPickPressed,
              child: Row(
                children: [
                  Text(unitString),
                  Icon(
                    Icons.keyboard_arrow_down,
                  )
                ],
              )),
        ],
      ),
    );
  }
}


class InputForm3 extends StatelessWidget {
  const InputForm3({
    Key key,
    @required this.title,
    @required this.buttonPressed,
    @required this.selected,
  }) : super(key: key);

  final VoidCallback buttonPressed;
  final String title;
  final String selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
            width: (MediaQuery.of(context).size.width - 32) * 0.25,
            child: Text(
              title,
              style: Opacity70Style,
            ),
          ),
          TextButton(
              onPressed: buttonPressed,
              child: Row(
                children: [
                  Text(selected),
                  Icon(
                    Icons.keyboard_arrow_down,
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class InputForm4 extends StatelessWidget {
  const InputForm4({
    Key key,
    @required this.title,
    @required this.changed,
    @required this.unit,
    @required TextEditingController textEditingController,
  }) : _controller = textEditingController,
        super(key: key);

  final String title;
  final ValueChanged<String> changed;
  final String unit;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
            width: (MediaQuery.of(context).size.width - 32) * 0.25,
            child: Text(
              title,
              style: Opacity70Style,
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 32) * 0.41,
            margin: EdgeInsets.only(right: 20),
            child: TextField(
              style: Theme.of(context).textTheme.bodyText1,
              onChanged: changed,
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: '내용을 입력해주세요',
                  contentPadding: EdgeInsets.only(left: 3.0, bottom: 5.0),
                  hintStyle: HintTextStyle,
                  isDense: true),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
            child: Text(
              unit,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}

class InputModalSheetColumn extends StatelessWidget {
  const InputModalSheetColumn({
    Key key,
    @required this.onTap,
    @required this.thisColumnContent,
    @required this.selectedColumnContent,
  }):super(key: key);

  final VoidCallback onTap;
  final String thisColumnContent;
  final String selectedColumnContent;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: defaultPadding
          ),
          child: thisColumnContent == selectedColumnContent
              ? Row(
            children: [
              Text(
                thisColumnContent,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(
                    fontSize: 18.0,
                    color:
                    Theme.of(context).primaryColor),
              ),
              Spacer(),
              Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
              ),
            ],
          )
              : Row(
                children: [
                  Text(
            thisColumnContent,
            style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18.0),
          ),
                ],
              ),
        )
    );
  }
}

