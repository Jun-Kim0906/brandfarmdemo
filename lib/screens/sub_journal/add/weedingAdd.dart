import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/weeding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeedingAdd extends StatefulWidget {
  final Weeding weeding;

  const WeedingAdd({
    this.weeding,
  });

  State<WeedingAdd> createState() => _WeedingAdd();
}

class _WeedingAdd extends State<WeedingAdd> {
  bool expansion;

  Widget tIcon = Icon(
    Icons.add,
    color: Colors.black,
  );

  JournalCreateBloc _journalCreateBloc;
  Weeding _weeding;

  TextEditingController progress;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _weeding = widget.weeding;

    if (_weeding == null) {
      _journalCreateBloc.add(DataCheck(check: true));
      progress = TextEditingController();
      expansion = false;
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
      progress =
          TextEditingController(text: _weeding.weedingProgress.toString());
      expansion = true;
      tIcon = Icon(
        Icons.close,
        color: Colors.black,
      );

      _journalCreateBloc
          .add(WeedingProgressChanged(progress: _weeding.weedingProgress));
      _journalCreateBloc
          .add(WeedingUnitChanged(weedingUnit: _weeding.weedingUnit));
    }
  }

  @override
  Widget build(BuildContext context) {
    return seeding();
  }

  Widget areaUnit() {
    return Container(
      child: DropdownButton(
        underline: SizedBox(),
        items: [
          DropdownMenuItem(
            value: '%',
            child: Text(
              '%',
              
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc.add(WeedingUnitChanged(weedingUnit: value));
        },
        value: _journalCreateBloc.state.weedingUnit,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget seeding() {
    return BlocBuilder<JournalCreateBloc, JournalCreateState>(
      cubit: _journalCreateBloc,
      builder: (context, state) {
        return Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider()),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      '제초 작업 진행율',
                    ),
                    padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    width: (MediaQuery.of(context).size.width - 40) * 0.3,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (v) {
                          validate();
                          _journalCreateBloc.add(WeedingProgressChanged(
                              progress: double.parse(v)));
                        },
                        controller: progress,
                        decoration: InputDecoration(
                          errorText: validatePassword(progress.text),
                          hintText: '내용을 입력해주세요',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      flex: 2,
                      child: Container(
                        child: areaUnit(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider()),
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
    if (progress.text.isEmpty) {
      _journalCreateBloc.add(DataCheck(check: true));
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
    }
  }
}
