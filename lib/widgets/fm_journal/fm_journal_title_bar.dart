import 'package:flutter/material.dart';

class FMJournalTitle extends StatefulWidget {
  @override
  _FMJournalTitleState createState() => _FMJournalTitleState();
}

class _FMJournalTitleState extends State<FMJournalTitle> {
  String field;
  List<String> fList = [
    '필드A',
    '필드B',
    '필드C',
  ];

  @override
  void initState() {
    super.initState();
    field = fList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '일지목록',
          style: Theme
              .of(context)
              .textTheme
              .bodyText1
              .copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w200,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 28,),
        _selectFieldDropdown(),
        Divider(height: 36, thickness: 1, color: Color(0xFFDFDFDF),),
      ],
    );
  }

  Widget _selectFieldDropdown() {
    return DropdownButton(
      value: field,
      items: fList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      style: Theme.of(context).textTheme.bodyText2.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Color(0xFF15B85B),
      ),
      icon: Icon(Icons.keyboard_arrow_down_sharp, color: Color(0x66000000),),
      onChanged: (String value) {
        setState(() {
          field = value;
        });
      },
      underline: Container(),
    );
  }
}

