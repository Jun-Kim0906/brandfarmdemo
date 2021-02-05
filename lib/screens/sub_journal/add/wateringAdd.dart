import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/watering_model.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/sub_journal_create/input_forms.dart';
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

  void areaPickBottomSheet(BuildContext context) {
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
                  onTap: () {
                    _journalCreateBloc
                        .add(WateringAreaUnitChanged(areaUnit: '%'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '%',
                  selectedColumnContent:
                  _journalCreateBloc.state.wateringAreaUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc
                        .add(WateringAreaUnitChanged(areaUnit: 'm^2'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: 'm^2',
                  selectedColumnContent:
                  _journalCreateBloc.state.wateringAreaUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc
                        .add(WateringAreaUnitChanged(areaUnit: '평'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '평',
                  selectedColumnContent:
                  _journalCreateBloc.state.wateringAreaUnit,
                ),
                Divider(),
              ],
            ),
          );
        });
  }

  void totalPickBottomSheet(BuildContext context) {
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
                    _journalCreateBloc.add(WateringAmountUnitChanged(amountUnit: '리터'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '리터',
                  selectedColumnContent: _journalCreateBloc.state.wateringAmountUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(WateringAmountUnitChanged(amountUnit: '말'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '말',
                  selectedColumnContent: _journalCreateBloc.state.wateringAmountUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(WateringAmountUnitChanged(amountUnit: '톤'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '톤',
                  selectedColumnContent: _journalCreateBloc.state.wateringAmountUnit,
                ),
                Divider(),
              ],
            ),
          );
        });
  }

  Widget watering() {
    return BlocBuilder<JournalCreateBloc, JournalCreateState>(
      cubit: _journalCreateBloc,
      builder: (context, state) {
        return Column(
          children: <Widget>[
            InputForm2(
                textEditingController: area,
                changed: (v) {
                  validate();
                  _journalCreateBloc
                      .add(WateringAreaChanged(area: double.parse(v)));
                },
                unitPickPressed: () {
                  areaPickBottomSheet(context);
                },
                unitString: _journalCreateBloc.state.wateringAreaUnit,
                title: '면적'),
            InputForm2(
                textEditingController: total,
                changed: (v) {
                  _journalCreateBloc
                      .add(WateringAmountChanged(amount: double.parse(v)));
                },
                unitPickPressed: () {
                  totalPickBottomSheet(context);
                },
                unitString: _journalCreateBloc.state.wateringAmountUnit,
                title: '총관수량'),
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
