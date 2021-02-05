import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/planting_model.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/sub_journal_create/input_forms.dart';
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
                        .add(PlantingAreaUnitChanged(areaUnit: '%'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '%',
                  selectedColumnContent:
                      _journalCreateBloc.state.plantingAreaUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc
                        .add(PlantingAreaUnitChanged(areaUnit: 'm^2'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: 'm^2',
                  selectedColumnContent:
                      _journalCreateBloc.state.plantingAreaUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc
                        .add(PlantingAreaUnitChanged(areaUnit: '평'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '평',
                  selectedColumnContent:
                      _journalCreateBloc.state.plantingAreaUnit,
                ),
                Divider(),
              ],
            ),
          );
        });
  }

  Widget planting() {
    return BlocBuilder<JournalCreateBloc, JournalCreateState>(
        cubit: _journalCreateBloc,
        builder: (context, state) {
          return Column(
            children: <Widget>[
              InputForm2(
                  textEditingController: area,
                  changed: (value) {
                    validate();
                    _journalCreateBloc
                        .add(PlantingAreaChanged(area: double.parse(value)));
                  },
                  unitPickPressed: () {
                    areaPickBottomSheet(context);
                  },
                  unitString: _journalCreateBloc.state.plantingAreaUnit,
                  title: '면적'),
              InputForm4(
                  title: '주수',
                  changed: (value) {
                    _journalCreateBloc.add(PlantingCountChanged(count: value));
                  },
                  unit: '주',
                  textEditingController: count),
              InputForm4(
                  title: '주당가격',
                  changed: (value) {
                    _journalCreateBloc
                        .add(PlantingPriceChanged(price: int.parse(value)));
                  },
                  unit: '원',
                  textEditingController: countPrice),
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
