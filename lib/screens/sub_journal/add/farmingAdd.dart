import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/farming_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FarmingAdd extends StatefulWidget {
  final Farming farming;

  const FarmingAdd({this.farming});
  State<FarmingAdd> createState() => _FarmingAdd();
}

class _FarmingAdd extends State<FarmingAdd> {
  bool expansion;
  Widget tIcon = Icon(
    Icons.add,
    color: Colors.black,
  );

  JournalCreateBloc _journalCreateBloc;

  TextEditingController area;
  TextEditingController method;

  Farming _farming;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _farming = widget.farming;

    if (_farming == null) {
      _journalCreateBloc.add(DataCheck(check: true));
      area = TextEditingController();
      method = TextEditingController();
      expansion = false;
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
      area = TextEditingController(text: _farming.farmingArea.toString());
      method = TextEditingController(text: _farming.farmingMethod);
      expansion = true;
      tIcon = Icon(
        Icons.close,
        color: Colors.black,
      );

      _journalCreateBloc.add(FarmingAreaChanged(area: _farming.farmingArea));
      _journalCreateBloc
          .add(FarmingAreaUnitChanged(areaUnit: _farming.farmingAreaUnit));
      _journalCreateBloc
          .add(FarmingMethodChanged(method: _farming.farmingMethod));
      _journalCreateBloc.add(
          FarmingMethodUnitChanged(methodUnit: _farming.farmingMethodUnit));
    }
  }

  Widget farmingUnit() {
    return Container(
      child: DropdownButton(
        underline: SizedBox(),
        items: [
          DropdownMenuItem(
            value: '%',
            child: Text(
              '%',
              // style: blackColor,
            ),
          ),
          DropdownMenuItem(
            value: 'm^2',
            child: Text(
              'm^2',
              // style: blackColor,
            ),
          ),
          DropdownMenuItem(
            value: '평',
            child: Text(
              '평',
              // style: blackColor,
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc.add(FarmingAreaUnitChanged(areaUnit: value));
        },
        value: _journalCreateBloc.state.farmingAreaUnit,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget methodUnit() {
    return Container(
      child: DropdownButton(
        underline: SizedBox(),
        items: [
          DropdownMenuItem(
            value: '로터리',
            child: Text(
              '로터리',
              // style: blackColor,
            ),
          ),
          DropdownMenuItem(
            value: '쟁기',
            child: Text(
              '쟁기',
              // style: blackColor,
            ),
          ),
          DropdownMenuItem(
            value: '심토파쇄',
            child: Text(
              '심토파쇄',
              // style: blackColor,
            ),
          ),
          DropdownMenuItem(
            value: '배토작업',
            child: Text(
              '배토작업',
              // style: blackColor,
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc.add(FarmingMethodUnitChanged(methodUnit: value));
        },
        value: _journalCreateBloc.state.farmingMethodUnit,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget farming() {
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
                    padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    child: Text(
                      '면적',
                      // style: subTitle3,
                    ),
                    width: (MediaQuery.of(context).size.width - 40) * 0.3,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: TextField(
                        onChanged: (v) {
                          validate();
                          _journalCreateBloc
                              .add(FarmingAreaChanged(area: double.parse(v)));
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
                        child: farmingUnit(),
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
                      '경운방법',
                      // style: subTitle3,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: TextField(
                        onChanged: (v) {
                          _journalCreateBloc
                              .add(FarmingMethodChanged(method: v));
                        },
//                        keyboardType: TextInputType.number,
                        controller: method,
                        // decoration: inputContent,
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      flex: 2,
                      child: Container(
                        child: methodUnit(),
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
    return farming();
  }
}
