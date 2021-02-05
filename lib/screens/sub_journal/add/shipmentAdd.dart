import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/shipment_model.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/sub_journal_create/input_forms.dart';
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
    return shipmentAddPanel();
  }

  void unitPickBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc
                        .add(ShipmentUnitSelectChanged(unitSelect: 'Kg'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: 'Kg',
                  selectedColumnContent: _journalCreateBloc.state.shipmentUnitSelect,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc
                        .add(ShipmentUnitSelectChanged(unitSelect: '박스'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '박스',
                  selectedColumnContent: _journalCreateBloc.state.shipmentUnitSelect,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc
                        .add(ShipmentUnitSelectChanged(unitSelect: '콘티'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '콘티',
                  selectedColumnContent: _journalCreateBloc.state.shipmentUnitSelect,
                ),
                Divider(),
              ],
            ),
          );
        });
  }

  void gradePickBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(ShipmentGradeChanged(grade: '특'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '특',
                  selectedColumnContent: _journalCreateBloc.state.shipmentGrade,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(ShipmentGradeChanged(grade: '상'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '상',
                  selectedColumnContent: _journalCreateBloc.state.shipmentGrade,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(ShipmentGradeChanged(grade: '중'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '중',
                  selectedColumnContent: _journalCreateBloc.state.shipmentGrade,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(ShipmentGradeChanged(grade: '하'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '하',
                  selectedColumnContent: _journalCreateBloc.state.shipmentGrade,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(ShipmentGradeChanged(grade: '그외'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '그외',
                  selectedColumnContent: _journalCreateBloc.state.shipmentGrade,
                ),
                Divider(),
              ],
            ),
          );
        });
  }


  Widget shipmentAddPanel() {
    return BlocBuilder<JournalCreateBloc, JournalCreateState>(
      cubit: _journalCreateBloc,
      builder: (BuildContext context, JournalCreateState state) {
        return Column(
          children: <Widget>[
            InputForm1(
              textEditingController: name,
              changed: (value) {
                validate(value);
                _journalCreateBloc.add(ShipmentPlantChanged(plant: value));
              },
              validatePassword: validatePassword(name.text),
              title: '출하작물',
            ),
            InputForm1(
                textEditingController: path,
                changed: (value) {
                  validate(value);
                  _journalCreateBloc.add(ShipmentPathChanged(path: value));
                },
                validatePassword: validatePassword(path.text),
                title: '출하경로  '),
            InputForm2(
                textEditingController: unit,
                changed: (value) {
                  _journalCreateBloc
                      .add(ShipmentUnitChanged(unit: double.parse(value)));
                },
                unitPickPressed: () {
                  unitPickBottomSheet(context);
                },
                unitString: _journalCreateBloc.state.shipmentUnitSelect,
                title: '출하단위'),
            InputForm1(
              textEditingController: count,
              changed: (value) {
                _journalCreateBloc
                    .add(ShipmentAmountChanged(amount: value.toString()));
              },
              title: '출하숫자',
            ),
            InputForm3(
                title: '등급',
                buttonPressed: () {
                  gradePickBottomSheet(context);
                },
                selected: _journalCreateBloc.state.shipmentGrade),
            InputForm4(
                title: '단위가격',
                changed: (value) {
                  _journalCreateBloc
                      .add(ShipmentPriceChanged(price: int.parse(value)));
                },
                unit: '원',
                textEditingController: price),
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
    if (name.text.isEmpty || path.text.isEmpty) {
      _journalCreateBloc.add(DataCheck(check: true));
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
    }
  }
}

