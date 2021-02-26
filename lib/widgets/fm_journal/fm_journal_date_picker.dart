import 'package:flutter/material.dart';

class FMJournalDatePicker extends StatefulWidget {
  @override
  _FMJournalDatePickerState createState() => _FMJournalDatePickerState();
}

class _FMJournalDatePickerState extends State<FMJournalDatePicker> {
  DateTime now = DateTime.now();
  String year;
  String month;
  List<String> yearList;
  List<String> monthList;

  @override
  void initState() {
    super.initState();
    generateYearMonth();
    year = now.year.toString();
    month = now.month.toString();
  }

  void generateYearMonth() {
    List<String> yList = List.generate(10, (index) {
      int initial = 2020;
      int num = initial + index;
      return num.toString();
    });
    List<String> mList = List.generate(12, (index) {
      int initial = 1;
      int num = initial + index;
      return num.toString();
    });
    setState(() {
      yearList = yList;
      monthList = mList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _selectYear(),
        SizedBox(width: 24,),
        _selectMonth(),
      ],
    );
  }

  Widget _selectYear() {
    return DropdownButton(
      value: year,
      items: yearList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      style: Theme.of(context).textTheme.bodyText2.copyWith(
        fontSize: 18,
        color: Color(0x66000000),
      ),
      icon: Icon(Icons.keyboard_arrow_down_sharp, color: Color(0x66000000),),
      onChanged: (String value) {
        setState(() {
          year = value;
        });
      },
      underline: Container(),
    );
  }

  Widget _selectMonth() {
    return DropdownButton(
      value: month,
      items: monthList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      style: Theme.of(context).textTheme.bodyText2.copyWith(
        fontSize: 18,
        color: Color(0x66000000),
      ),
      icon: Icon(Icons.keyboard_arrow_down_sharp, color: Color(0x66000000),),
      onChanged: (String value) {
        setState(() {
          month = value;
        });
      },
      underline: Container(),
    );
  }
}
