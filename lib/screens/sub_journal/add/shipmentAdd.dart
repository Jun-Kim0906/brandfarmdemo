import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/shipment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShipmentAdding extends StatefulWidget {
  final Shipment shipment;

  const ShipmentAdding({
    this.shipment,
  });

  State<ShipmentAdding> createState() => ShipmentAdd();
}

class ShipmentAdd extends State<ShipmentAdding> {
  JournalCreateBloc _journalCreateBloc;
  Shipment _shipment;
  bool expansion;

  Widget tIcon = Icon(
    Icons.add,
    color: Colors.black,
  );

  TextEditingController name;
  TextEditingController path;
  TextEditingController unit;
  TextEditingController count;
  TextEditingController grade;
  TextEditingController price;

  String facilityPlant;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);

    _shipment = widget.shipment;

    /// 현재 선택된 facility 의 카테고리를 가져와서 저장함. 출하작물 부분에 삽입.
    facilityPlant = '눈꽃동충하초';

    if (_shipment == null) {
      name = TextEditingController(text: facilityPlant);
      path = TextEditingController();
      unit = TextEditingController();
      count = TextEditingController();
      price = TextEditingController();
      _journalCreateBloc.add(DataCheck(check: true));
      expansion = false;
    } else {
      name = TextEditingController(text: _shipment.shipmentPlant);
      path = TextEditingController(text: _shipment.shipmentPath);
      unit = TextEditingController(text: _shipment.shipmentUnit.toString());
      count = TextEditingController(text: _shipment.shipmentAmount);
      price = TextEditingController(text: _shipment.shipmentPrice.toString());
      _journalCreateBloc.add(DataCheck(check: false));

      expansion = true;
      tIcon = Icon(
        Icons.close,
        color: Colors.black,
      );

      _journalCreateBloc
          .add(ShipmentPlantChanged(plant: _shipment.shipmentPlant));
      _journalCreateBloc.add(ShipmentPathChanged(path: _shipment.shipmentPath));
      _journalCreateBloc.add(ShipmentUnitChanged(unit: _shipment.shipmentUnit));
      _journalCreateBloc
          .add(ShipmentAmountChanged(amount: _shipment.shipmentAmount));
      _journalCreateBloc
          .add(ShipmentGradeChanged(grade: _shipment.shipmentGrade));
      _journalCreateBloc
          .add(ShipmentPriceChanged(price: _shipment.shipmentPrice));
      _journalCreateBloc.add(
          ShipmentUnitSelectChanged(unitSelect: _shipment.shipmentUnitSelect));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return shipmentAddPanel();
  }

  Widget unitPick() {
    return Container(
      child: DropdownButton(
        underline: SizedBox(),
        items: [
          DropdownMenuItem(
            value: 'Kg',
            child: Text(
              'Kg',
              
            ),
          ),
          DropdownMenuItem(
            value: '박스',
            child: Text(
              '박스',
              
            ),
          ),
          DropdownMenuItem(
            value: '콘티',
            child: Text(
              '콘티',
              
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc.add(ShipmentUnitSelectChanged(unitSelect: value));
        },
        value: _journalCreateBloc.state.shipmentUnitSelect,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget gradePick() {
    return Container(
      child: DropdownButton(
        underline: SizedBox(),
        items: [
          DropdownMenuItem(
            value: '특',
            child: Text(
              '특',
              
            ),
          ),
          DropdownMenuItem(
            value: '상',
            child: Text(
              '상',
              
            ),
          ),
          DropdownMenuItem(
            value: '중',
            child: Text(
              '중',
              
            ),
          ),
          DropdownMenuItem(
            value: '하',
            child: Text(
              '하',
              
            ),
          ),
          DropdownMenuItem(
            value: '그외',
            child: Text(
              '그외',
              
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc.add(ShipmentGradeChanged(grade: value));
        },
        value: _journalCreateBloc.state.shipmentGrade,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget shipmentAddPanel() {
    return BlocBuilder<JournalCreateBloc, JournalCreateState>(
      cubit: _journalCreateBloc,
      builder: (BuildContext context, JournalCreateState state) {
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
                      '출하작물',
                    ),
                    width: (MediaQuery.of(context).size.width - 40) * 0.3,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(fontSize: 16.0),
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        validate(value);
                        _journalCreateBloc
                            .add(ShipmentPlantChanged(plant: value));
                      },
                      controller: name,
                      decoration: InputDecoration(
                        errorText: validatePassword(name.text),
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
                    child: Text(
                      '출하경로',
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        validate(value);
                        _journalCreateBloc.add(ShipmentPathChanged(path: value));
                      },
                      controller: path,
                      decoration: InputDecoration(
                        errorText: validatePassword(path.text),
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
                    child: Text('출하단위'),
                  ),
                  Container(
                    child: Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: TextField(
                          onChanged: (value) {
                            _journalCreateBloc.add(
                                ShipmentUnitChanged(unit: double.parse(value)));
                          },
                          controller: unit,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      flex: 2,
                      child: Container(
                        child: unitPick(),
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
                    child: Text('출하숫자'),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        _journalCreateBloc.add(
                            ShipmentAmountChanged(amount: value.toString()));
                      },
                      controller: count,
                      keyboardType: TextInputType.number,
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
                    child: Text('등급'),
                  ),
                  Expanded(
                    child: gradePick(),
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
                    child: Text('단위가격'),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        _journalCreateBloc
                            .add(ShipmentPriceChanged(price: int.parse(value)));
                      },
                      controller: price,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    child: Text('원',),
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

  validate(String value) {
    if (
    name.text.isEmpty ||
        path.text.isEmpty) {
      _journalCreateBloc.add(DataCheck(check: true));
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
    }
  }
}
