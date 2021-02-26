import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FMJournalListPicker extends StatefulWidget {
  @override
  _FMJournalListPickerState createState() => _FMJournalListPickerState();
}

class _FMJournalListPickerState extends State<FMJournalListPicker> {
  bool isIssue;
  String order;

  @override
  void initState() {
    super.initState();
    isIssue = false;
    order = '최신 순';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _journalSwitch(),
        SizedBox(width: 180,),
        _order(),
      ],
    );
  }

  Widget _journalSwitch() {
    return Container(
      height: 30,
      width: 212,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xFFBCBCBC)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            alignment: (isIssue) ? Alignment(1, 0) : Alignment(-1, 0),
            child: Container(
              height: 30,
              width: 115,
              decoration: BoxDecoration(
                color: Color(0xFF15B85B),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(26, 7, 26, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkResponse(
                  onTap: (){
                    setState(() {
                      isIssue = false;
                    });
                  },
                  child: Text(
                    '성장일지',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.bold, // normal
                          color: (isIssue)
                              ? Color(0x4D000000) : Colors.white, // Color(0x4D000000) or white
                        ),
                  ),
                ),
                InkResponse(
                  onTap: (){
                    setState(() {
                      isIssue = true;
                    });
                  },
                  child: Text(
                    '이슈일지',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.bold, // normal
                          color: (isIssue)
                              ? Colors.white : Color(0x4D000000), // Color(0x4D000000) or white
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _order() {
    return DropdownButton(
      value: order,
      items: <String>['최신 순', '오래된 순']
          .map<DropdownMenuItem<String>>((String value) {
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
      icon: Icon(
        Icons.keyboard_arrow_down_sharp,
        color: Color(0x66000000),
      ),
      onChanged: (String value) {
        setState(() {
          order = value;
        });
      },
      underline: Container(),
    );
  }
}
