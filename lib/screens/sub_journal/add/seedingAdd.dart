import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/seeding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeedingAdd extends StatefulWidget {
  final Seeding seeding;

  const SeedingAdd({this.seeding});

  State<SeedingAdd> createState() => _SeedingAdd();
}

class _SeedingAdd extends State<SeedingAdd> {
  bool expansion;
  Widget tIcon = Icon(
    Icons.add,
    color: Colors.black,
  );

  JournalCreateBloc _journalCreateBloc;

  TextEditingController area;
  TextEditingController amount;
  Seeding _seeding;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _seeding = widget.seeding;
    if (_seeding == null) {
      _journalCreateBloc.add(DataCheck(check: true));
      area = TextEditingController();
      amount = TextEditingController();
      expansion = false;
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
      area = TextEditingController(text: _seeding.seedingArea.toString());
      amount = TextEditingController(text: _seeding.seedingAmount.toString());
      expansion = true;
      tIcon = Icon(
        Icons.close,
        color: Colors.black,
      );
      _journalCreateBloc.add(SeedingAreaChanged(area: _seeding.seedingArea));
      _journalCreateBloc
          .add(SeedingAreaUnitChanged(areaUnit: _seeding.seedingAreaUnit));
      _journalCreateBloc
          .add(SeedingAmountChanged(amount: _seeding.seedingAmount));
      _journalCreateBloc.add(
          SeedingAmountUnitChanged(amountUnit: _seeding.seedingAmountUnit));
    }
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
          DropdownMenuItem(
            value: 'm^2',
            child: Text(
              'm^2',
              
            ),
          ),
          DropdownMenuItem(
            value: '평',
            child: Text(
              '평',
              
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc.add(SeedingAreaUnitChanged(areaUnit: value));
        },
        value: _journalCreateBloc.state.seedingAreaUnit,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget amountUnit() {
    return Container(
      child: DropdownButton(
        underline: SizedBox(),
        items: [
          DropdownMenuItem(
            value: 'kg',
            child: Text(
              'kg',
              
            ),
          ),
          DropdownMenuItem(
            value: 'g',
            child: Text(
              'g',
              
            ),
          ),
          DropdownMenuItem(
            value: '개',
            child: Text(
              '개',
              
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc.add(SeedingAmountUnitChanged(amountUnit: value));
        },
        value: _journalCreateBloc.state.seedingAmountUnit,
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
                      '파종면적',
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
                        onChanged: (value) {
                          validate();
                          _journalCreateBloc.add(
                              SeedingAreaChanged(area: double.parse(value)));
                        },
                        controller: area,
                        decoration: InputDecoration(
                          errorText: validatePassword(area.text),
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
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      '파종량',
                    ),
                    padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    width: (MediaQuery.of(context).size.width - 40) * 0.3,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: TextField(
                        onChanged: (value) {
                          _journalCreateBloc.add(SeedingAmountChanged(
                              amount: double.parse(value)));
                        },
                        keyboardType: TextInputType.number,
                        controller: amount,
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      flex: 2,
                      child: Container(
                        child: amountUnit(),
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
//      _journalCreateBloc.add(DataCheck(check: true));
      return "필수 데이터 입니다.";
    } else {
//      _journalCreateBloc.add(DataCheck(check: false));
      return null;
    }
  }

  validate() {
    if (area.text.isEmpty) {
      _journalCreateBloc.add(DataCheck(check: true));
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return seeding();
  }
}
