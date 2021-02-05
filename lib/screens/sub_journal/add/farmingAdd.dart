import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/farming_model.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/sub_journal_create/input_forms.dart';
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

  void farmingPickBottomSheet(BuildContext context) {
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
                        .add(FarmingAreaUnitChanged(areaUnit: '%'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '%',
                  selectedColumnContent:
                  _journalCreateBloc.state.farmingAreaUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc
                        .add(FarmingAreaUnitChanged(areaUnit: 'm^2'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: 'm^2',
                  selectedColumnContent:
                  _journalCreateBloc.state.farmingAreaUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc
                        .add(FarmingAreaUnitChanged(areaUnit: '평'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '평',
                  selectedColumnContent:
                  _journalCreateBloc.state.farmingAreaUnit,
                ),
                Divider(),
              ],
            ),
          );
        });
  }

  void methodPickBottomSheet(BuildContext context) {
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
                    _journalCreateBloc.add(FarmingMethodUnitChanged(methodUnit: '로터리'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '로터리',
                  selectedColumnContent: _journalCreateBloc.state.farmingMethodUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(FarmingMethodUnitChanged(methodUnit: '쟁기'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '쟁기',
                  selectedColumnContent: _journalCreateBloc.state.farmingMethodUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(FarmingMethodUnitChanged(methodUnit: '심토파쇄'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '심토파쇄',
                  selectedColumnContent: _journalCreateBloc.state.farmingMethodUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(FarmingMethodUnitChanged(methodUnit: '배토작업'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '배토작업',
                  selectedColumnContent: _journalCreateBloc.state.farmingMethodUnit,
                ),
                Divider(),
              ],
            ),
          );
        });
  }

  Widget farming() {
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
                      .add(FarmingAreaChanged(area: double.parse(v)));
                },
                unitPickPressed: () {
                  farmingPickBottomSheet(context);
                },
                unitString: _journalCreateBloc.state.farmingAreaUnit,
                title: '면적'),
            InputForm2(
                textEditingController: method,
                changed: (v) {
                  _journalCreateBloc.add(FarmingMethodChanged(method: v));
                },
                unitPickPressed: () {
                  methodPickBottomSheet(context);
                },
                unitString: _journalCreateBloc.state.farmingMethodUnit,
                title: '경운방법'),
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
