import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/watering_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WateringAdd extends StatefulWidget {
  final Watering watering;

  const WateringAdd({this.watering});

  State<WateringAdd> createState() => _WateringAdd();
}

class _WateringAdd extends State<WateringAdd> {
  bool expansion;

  Widget tIcon = Icon(
    Icons.add,
    color: Colors.black,
  );

  JournalCreateBloc _journalCreateBloc;

  TextEditingController area;
  TextEditingController total;

  Watering _watering;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _watering = widget.watering;
    if (_watering == null) {
      _journalCreateBloc.add(DataCheck(check: true));
      area = TextEditingController();
      total = TextEditingController();
      expansion = false;
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
      area = TextEditingController(text: _watering.wateringArea.toString());
      total = TextEditingController(text: _watering.wateringAmount.toString());
      expansion = true;
      tIcon = Icon(
        Icons.close,
        color: Colors.black,
      );

      _journalCreateBloc.add(WateringAreaChanged(area: _watering.wateringArea));
      _journalCreateBloc
          .add(WateringAreaUnitChanged(areaUnit: _watering.wateringAreaUnit));
      _journalCreateBloc
          .add(WateringAmountChanged(amount: _watering.wateringAmount));
      _journalCreateBloc.add(
          WateringAmountUnitChanged(amountUnit: _watering.wateringAmountUnit));
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
          _journalCreateBloc.add(WateringAreaUnitChanged(areaUnit: value));
        },
        value: _journalCreateBloc.state.wateringAreaUnit,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget totalUnit() {
    return Container(
      child: DropdownButton(
        underline: SizedBox(),
        items: [
          DropdownMenuItem(
            value: '리터',
            child: Text(
              '리터',
              
            ),
          ),
          DropdownMenuItem(
            value: '말',
            child: Text(
              '말',
              
            ),
          ),
          DropdownMenuItem(
            value: '톤',
            child: Text(
              '톤',
              
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc.add(WateringAmountUnitChanged(amountUnit: value));
        },
        value: _journalCreateBloc.state.wateringAmountUnit,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget watering() {
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
                      '면적',
                    ),
                    padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    width: (MediaQuery.of(context).size.width - 40) * 0.3,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: TextFormField(
                        onChanged: (v) {
                          validate();
                          _journalCreateBloc
                              .add(WateringAreaChanged(area: double.parse(v)));
                        },
                        keyboardType: TextInputType.number,
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
                    padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    width: (MediaQuery.of(context).size.width - 40) * 0.3,
                    child: Text(
                      '총관수량',
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (v) {
                          _journalCreateBloc.add(
                              WateringAmountChanged(amount: double.parse(v)));
                        },
                        controller: total,
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      flex: 2,
                      child: Container(
                        child: totalUnit(),
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
    if (area.text.isEmpty) {
      _journalCreateBloc.add(DataCheck(check: true));
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return watering();
  }
}
