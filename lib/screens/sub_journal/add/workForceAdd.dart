import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/workforce_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkForceAdd extends StatefulWidget {
  final Workforce workforce;

  const WorkForceAdd({this.workforce});

  State<WorkForceAdd> createState() => _WorkForceAdd();
}

class _WorkForceAdd extends State<WorkForceAdd> {
  bool expansion;

  Widget tIcon = Icon(
    Icons.add,
    color: Colors.black,
  );

  JournalCreateBloc _journalCreateBloc;

  TextEditingController number = TextEditingController();
  TextEditingController price = TextEditingController();

  Workforce _workforce;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _workforce = widget.workforce;

    if (_workforce == null) {
      _journalCreateBloc.add(DataCheck(check: true));
      number = TextEditingController();
      price = TextEditingController();
      expansion = false;
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
      number = TextEditingController(text: _workforce.workforceNum.toString());
      price = TextEditingController(text: _workforce.workforcePrice.toString());
      expansion = true;
      tIcon = Icon(
        Icons.close,
        color: Colors.black,
      );

      _journalCreateBloc
          .add(WorkforceNumChanged(workforceNum: _workforce.workforceNum));
      _journalCreateBloc.add(
          WorkforcePriceChanged(workforcePrice: _workforce.workforcePrice));
    }
  }

  @override
  Widget build(BuildContext context) {
    return workForceAddPanel();
  }

  Widget workForceAddPanel() {
    return BlocBuilder<JournalCreateBloc, JournalCreateState>(
      cubit: _journalCreateBloc,
      builder: (context, state) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      '참여인원',
                    ),
                    padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    width: (MediaQuery.of(context).size.width - 40) * 0.3,
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (v) {
                        validate();
                        _journalCreateBloc.add(
                            WorkforceNumChanged(workforceNum: int.parse(v)));
                      },
                      keyboardType: TextInputType.number,
                      controller: number,
                      decoration: InputDecoration(
                        errorText: validatePassword(number.text),
                        hintText: '내용을 입력해주세요',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '명',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      '인건비(1인당)',
                    ),
                    padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    width: (MediaQuery.of(context).size.width - 40) * 0.3,
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (v) {
                        _journalCreateBloc.add(WorkforcePriceChanged(
                            workforcePrice: int.parse(v)));
                      },
                      keyboardType: TextInputType.number,
                      controller: price,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '원',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(),
            ),
          ],
        );
      },
    );
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      ///      _journalCreateBloc.add(DataCheck(check: true));
      return "필수 데이터 입니다.";
    } else {
      ///      _journalCreateBloc.add(DataCheck(check: false));
      return null;
    }
  }

  validate() {
    if (number.text.isEmpty) {
      _journalCreateBloc.add(DataCheck(check: true));
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
    }
  }
}
