import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/workforce_model.dart';
import 'package:BrandFarm/widgets/sub_journal_create/input_forms.dart';
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
            InputForm4(title: '참여인원',
                changed: (v) {
                  validate();
                  _journalCreateBloc.add(
                      WorkforceNumChanged(workforceNum: int.parse(v)));
                }, unit: '명', textEditingController: number),
            InputForm4(title: '인건비(1인당)', changed: (v) {
              _journalCreateBloc.add(WorkforcePriceChanged(
                  workforcePrice: int.parse(v)));
            }, unit: '원', textEditingController: price),
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
