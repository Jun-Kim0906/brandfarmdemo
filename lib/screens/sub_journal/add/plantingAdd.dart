import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/planting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlantingAdd extends StatefulWidget {
  final Planting planting;

  const PlantingAdd({this.planting});

  State<PlantingAdd> createState() => _PlantingAdd();
}

class _PlantingAdd extends State<PlantingAdd> {
  bool expansion;
  Widget tIcon = Icon(
    Icons.add,
    color: Colors.black,
  );

  JournalCreateBloc _journalCreateBloc;
  Planting _planting;

  TextEditingController area;
  TextEditingController count;
  TextEditingController countPrice;

  @override
  void initState() {
    super.initState();
    _planting = widget.planting;
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);

    if (_planting == null) {
      _journalCreateBloc.add(DataCheck(check: true));
      area = TextEditingController();
      count = TextEditingController();
      countPrice = TextEditingController();
      expansion = false;
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
      area = TextEditingController(text: _planting.plantingArea.toString());
      count = TextEditingController(text: _planting.plantingCount);
      countPrice =
          TextEditingController(text: _planting.plantingPrice.toString());
      expansion = true;
      tIcon = Icon(
        Icons.close,
        color: Colors.black,
      );

      _journalCreateBloc.add(PlantingAreaChanged(area: _planting.plantingArea));
      _journalCreateBloc
          .add(PlantingAreaUnitChanged(areaUnit: _planting.plantingAreaUnit));
      _journalCreateBloc
          .add(PlantingCountChanged(count: _planting.plantingCount));
      _journalCreateBloc
          .add(PlantingPriceChanged(price: _planting.plantingPrice));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return planting();
  }

  Widget plantingUnit() {
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
          _journalCreateBloc.add(PlantingAreaUnitChanged(areaUnit: value));
        },
        value: _journalCreateBloc.state.plantingAreaUnit,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget planting() {
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
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            validate();
                            _journalCreateBloc.add(
                                PlantingAreaChanged(area: double.parse(value)));
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
                          child: plantingUnit(),
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
                      width: (MediaQuery.of(context).size.width - 40) * 0.3,
                      child: Text(
                        '주수',
                      ),
                      padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          _journalCreateBloc
                              .add(PlantingCountChanged(count: value));
                        },
                        keyboardType: TextInputType.number,
                        controller: count,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '주',
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
                      width: (MediaQuery.of(context).size.width - 40) * 0.3,
                      child: Text(
                        '주당가격',
                      ),
                      padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          _journalCreateBloc.add(
                              PlantingPriceChanged(price: int.parse(value)));
                        },
                        keyboardType: TextInputType.number,
                        controller: countPrice,
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
                  child: Divider()),
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
    if (area.text.isEmpty) {
      _journalCreateBloc.add(DataCheck(check: true));
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
    }
  }
}
