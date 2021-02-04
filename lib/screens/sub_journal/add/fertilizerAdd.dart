import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/fertilize_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FertilizerAdd extends StatefulWidget {
  final Fertilize fertilize;

  const FertilizerAdd({this.fertilize});

  State<FertilizerAdd> createState() => _FertilizerAdd();
}

class _FertilizerAdd extends State<FertilizerAdd> {
  bool expansion;

  Widget tIcon = Icon(
    Icons.add,
    color: Colors.black,
  );

  JournalCreateBloc _journalCreateBloc;
  Fertilize _fertilize;

  TextEditingController method;
  TextEditingController area;
  TextEditingController material;
  TextEditingController mUsing;
  TextEditingController wUsing;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);

    _fertilize = widget.fertilize;
    if (_fertilize == null) {
      _journalCreateBloc.add(DataCheck(check: true));
      method = TextEditingController();
      area = TextEditingController();
      material = TextEditingController();
      mUsing = TextEditingController();
      wUsing = TextEditingController();
      expansion = false;
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
      method = TextEditingController(text: _fertilize.fertilizerMethod);
      area = TextEditingController(text: _fertilize.fertilizerArea.toString());
      material = TextEditingController(text: _fertilize.fertilizerMaterialName);
      mUsing = TextEditingController(
          text: _fertilize.fertilizerMaterialUse.toString());
      wUsing =
          TextEditingController(text: _fertilize.fertilizerWater.toString());
      expansion = true;
      tIcon = Icon(
        Icons.close,
        color: Colors.black,
      );
    }
  }

  Widget methodUnit() {
    return Container(
      child: DropdownButton(
        underline: SizedBox(),
        items: [
          DropdownMenuItem(
            value: '엽면살포',
            child: Text(
              '엽면살포',
              // style: blackColor,
            ),
          ),
          DropdownMenuItem(
            value: '관주',
            child: Text(
              '관주',
              // style: blackColor,
            ),
          ),
          DropdownMenuItem(
            value: '전충살포',
            child: Text(
              '전충살포',
              // style: blackColor,
            ),
          ),
          DropdownMenuItem(
            value: '기타',
            child: Text(
              '기타',
              // style: blackColor,
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc.add(FertilizerMethod(method: value));
        },
        value: _journalCreateBloc.state.fertilizerMethod,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
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
          _journalCreateBloc.add(FertilizerAreaUnitChanged(areaUnit: value));
        },
        value: _journalCreateBloc.state.fertilizerAreaUnit,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget materialUnit() {
    return Container(
      child: DropdownButton(
        underline: SizedBox(),
        items: [
          DropdownMenuItem(
            value: 'g(ml)',
            child: Text(
              'g(ml)',
              // style: blackColor,
            ),
          ),
          DropdownMenuItem(
            value: 'Kg(L)',
            child: Text(
              'Kg(L)',
              // style: blackColor,
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc
              .add(FertilizerMaterialUnitChanged(materialUnit: value));
        },
        value: _journalCreateBloc.state.fertilizerMaterialUnit,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget waterUnit() {
    return Container(
      child: DropdownButton(
        underline: SizedBox(),
        items: [
          DropdownMenuItem(
            value: '리터',
            child: Text(
              '리터',
              // style: blackColor,
            ),
          ),
          DropdownMenuItem(
            value: '말',
            child: Text(
              '말',
              // style: blackColor,
            ),
          ),
          DropdownMenuItem(
            value: '톤',
            child: Text(
              '톤',
              // style: blackColor,
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc.add(FertilizerWaterUnitChanged(waterUnit: value));
        },
        value: _journalCreateBloc.state.fertilizerWaterUnit,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget fertilizerWrite() {
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
                    width: (MediaQuery.of(context).size.width - 40) * 0.3,
                    child: Text(
                      '살포방식',
                      // style: subTitle3,
                    ),
                  ),
                  Expanded(
                    child: methodUnit(),
                  )
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
                    child: Text('면적'),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          validate();
                          _journalCreateBloc.add(
                              FertilizerAreaChanged(area: double.parse(value)));
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
                    padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    width: (MediaQuery.of(context).size.width - 40) * 0.3,
                    child: Text('자재이름'),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        _journalCreateBloc
                            .add(FertilizerMaterialChanged(material: value));
                        validate();
                      },
                      controller: material,
                      decoration: InputDecoration(
                        errorText: validatePassword(material.text),
                        hintText: '내용을 입력해주세요',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  )
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
                    child: Text('자재 사용량'),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _journalCreateBloc.add(FertilizerMaterialUseChanged(
                              materialUse: double.parse(value)));
                        },
                        controller: mUsing,
                        // decoration: inputContent,
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      flex: 2,
                      child: Container(
                        child: materialUnit(),
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
                    child: Text('물 사용량'),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _journalCreateBloc.add(FertilizerWaterUseChanged(
                              waterUse: double.parse(value)));
                        },
                        controller: wUsing,
                        // decoration: inputContent,
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      flex: 2,
                      child: Container(
                        child: waterUnit(),
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
    if (area.text.isEmpty || material.text.isEmpty) {
      _journalCreateBloc.add(DataCheck(check: true));
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return fertilizerWrite();
  }
}
