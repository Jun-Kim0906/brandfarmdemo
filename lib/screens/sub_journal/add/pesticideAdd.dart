import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/journal_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PesticideAdd extends StatefulWidget {
  final Pesticide pesticide;

  const PesticideAdd({this.pesticide});

  State<PesticideAdd> createState() => _PesticideAdd();
}

class _PesticideAdd extends State<PesticideAdd> {
  bool expansion;

  Widget tIcon = Icon(
    Icons.add,
    color: Colors.black,
  );

  JournalCreateBloc _journalCreateBloc;
  Pesticide _pesticide;

  TextEditingController method;
  TextEditingController area;
  TextEditingController material;
  TextEditingController mUsing;
  TextEditingController wUsing;

  @override
  void initState() {
    super.initState();
    _pesticide = widget.pesticide;
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    if (_pesticide == null) {
      _journalCreateBloc.add(DataCheck(check: true));
      method = TextEditingController();
      area = TextEditingController();
      material = TextEditingController();
      mUsing = TextEditingController();
      wUsing = TextEditingController();
      expansion = false;
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
      method = TextEditingController(text: _pesticide.pesticideMethod);
      area = TextEditingController(text: _pesticide.pesticideArea.toString());
      material = TextEditingController(text: _pesticide.pesticideMaterialName);
      mUsing = TextEditingController(
          text: _pesticide.pesticideMaterialUse.toString());
      wUsing =
          TextEditingController(text: _pesticide.pesticideWater.toString());
      expansion = true;
      tIcon = Icon(
        Icons.close,
        color: Colors.black,
      );

      _journalCreateBloc
          .add(PesticideMethod(method: _pesticide.pesticideMethod));
      _journalCreateBloc
          .add(PesticideAreaChanged(area: _pesticide.pesticideArea));
      _journalCreateBloc.add(
          PesticideAreaUnitChanged(areaUnit: _pesticide.pesticideAreaUnit));
      _journalCreateBloc.add(
          PesticideMaterialChanged(material: _pesticide.pesticideMaterialName));
      _journalCreateBloc.add(PesticideMaterialUseChanged(
          materialUse: _pesticide.pesticideMaterialUse));
      _journalCreateBloc.add(PesticideMaterialUnitChanged(
          materialUnit: _pesticide.pesticideMaterialUnit));
      _journalCreateBloc
          .add(PesticideWaterUseChanged(waterUse: _pesticide.pesticideWater));
      _journalCreateBloc.add(
          PesticideWaterUnitChanged(waterUnit: _pesticide.pesticideWaterUnit));
    }
  }

  @override
  Widget build(BuildContext context) {
    return fertilizerWrite();
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
               
            ),
          ),
          DropdownMenuItem(
            value: '관주',
            child: Text(
              '관주',
               
            ),
          ),
          DropdownMenuItem(
            value: '전충살포',
            child: Text(
              '전충살포',
               
            ),
          ),
          DropdownMenuItem(
            value: '기타',
            child: Text(
              '기타',
               
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc.add(PesticideMethod(method: value));
        },
        value: _journalCreateBloc.state.pesticideMethod,
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
          _journalCreateBloc.add(PesticideAreaUnitChanged(areaUnit: value));
        },
        value: _journalCreateBloc.state.pesticideAreaUnit,
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
               
            ),
          ),
          DropdownMenuItem(
            value: 'Kg(L)',
            child: Text(
              'Kg(L)',
               
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc
              .add(PesticideMaterialUnitChanged(materialUnit: value));
        },
        value: _journalCreateBloc.state.pesticideMaterialUnit,
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
          _journalCreateBloc.add(PesticideWaterUnitChanged(waterUnit: value));
        },
        value: _journalCreateBloc.state.pesticideWaterUnit,
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
                  child: Divider() ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '살포방식',
                      ),
                      padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                      width: (MediaQuery.of(context).size.width - 40) * 0.3,
                    ),
                    Expanded(
                      child: methodUnit(),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Divider() ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: (MediaQuery.of(context).size.width - 40) * 0.3,
                      child: Text(
                        '면적',
                      ),
                      padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            validate();
                            _journalCreateBloc.add(PesticideAreaChanged(
                                area: double.parse(value)));
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
                  child: Divider() ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: (MediaQuery.of(context).size.width - 40) * 0.3,
                      child: Text(
                        '자재이름',
                      ),
                      padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    ),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          validate();
                          _journalCreateBloc
                              .add(PesticideMaterialChanged(material: value));
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
                  child: Divider() ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: (MediaQuery.of(context).size.width - 40) * 0.3,
                      child: Text(
                        '자재 사용량',
                      ),
                      padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _journalCreateBloc.add(PesticideMaterialUseChanged(
                                materialUse: double.parse(value)));
                          },
                          controller: mUsing,
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
                  child: Divider() ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: (MediaQuery.of(context).size.width - 40) * 0.3,
                      child: Text(
                        '물 사용량',
                      ),
                      padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _journalCreateBloc.add(PesticideWaterUseChanged(
                                waterUse: double.parse(value)));
                          },
                          controller: wUsing,
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
                  child: Divider() ),
            ],
          );
        });
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
}
