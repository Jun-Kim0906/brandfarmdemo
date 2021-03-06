import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/fertilize_model.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/sub_journal_create/input_forms.dart';
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
                  onTap: () {
                    _journalCreateBloc.add(FertilizerMethod(method: '옆면살포'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '옆면살포',
                  selectedColumnContent:
                      _journalCreateBloc.state.fertilizerMethod,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc.add(FertilizerMethod(method: '관주'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '관주',
                  selectedColumnContent:
                      _journalCreateBloc.state.fertilizerMethod,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc.add(FertilizerMethod(method: '전충살포'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '전충살포',
                  selectedColumnContent:
                      _journalCreateBloc.state.fertilizerMethod,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc.add(FertilizerMethod(method: '기타'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '기타',
                  selectedColumnContent:
                      _journalCreateBloc.state.fertilizerMethod,
                ),
                Divider(),
              ],
            ),
          );
        });
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
                        .add(FertilizerAreaUnitChanged(areaUnit: '%'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '%',
                  selectedColumnContent:
                      _journalCreateBloc.state.fertilizerAreaUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc
                        .add(FertilizerAreaUnitChanged(areaUnit: 'm^2'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: 'm^2',
                  selectedColumnContent:
                      _journalCreateBloc.state.fertilizerAreaUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc
                        .add(FertilizerAreaUnitChanged(areaUnit: '평'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '평',
                  selectedColumnContent:
                      _journalCreateBloc.state.fertilizerAreaUnit,
                ),
                Divider(),
              ],
            ),
          );
        });
  }

  void materialPickBottomSheet(BuildContext context) {
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
                    _journalCreateBloc.add(
                        FertilizerMaterialUnitChanged(materialUnit: 'g(ml)'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: 'g(ml)',
                  selectedColumnContent:
                      _journalCreateBloc.state.fertilizerMaterialUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc.add(
                        FertilizerMaterialUnitChanged(materialUnit: 'Kg(L)'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: 'Kg(L)',
                  selectedColumnContent:
                  _journalCreateBloc.state.fertilizerMaterialUnit,
                ),
                Divider(),
              ],
            ),
          );
        });
  }

  void waterPickBottomSheet(BuildContext context) {
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
                    _journalCreateBloc.add(FertilizerWaterUnitChanged(waterUnit: '리터'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '리터',
                  selectedColumnContent: _journalCreateBloc.state.fertilizerWaterUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(FertilizerWaterUnitChanged(waterUnit: '말'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '말',
                  selectedColumnContent: _journalCreateBloc.state.fertilizerWaterUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(FertilizerWaterUnitChanged(waterUnit: '톤'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '톤',
                  selectedColumnContent: _journalCreateBloc.state.fertilizerWaterUnit,
                ),
                Divider(),
              ],
            ),
          );
        });
  }

  Widget fertilizerWrite() {
    return BlocBuilder<JournalCreateBloc, JournalCreateState>(
      cubit: _journalCreateBloc,
      builder: (context, state) {
        return Column(
          children: <Widget>[
            InputForm3(
                title: '살포방식',
                buttonPressed: () {
                  methodPickBottomSheet(context);
                },
                selected: _journalCreateBloc.state.fertilizerMethod),
            InputForm2(
                textEditingController: area,
                changed: (value) {
                  validate();
                  _journalCreateBloc
                      .add(FertilizerAreaChanged(area: double.parse(value)));
                },
                unitPickPressed: () {
                  areaPickBottomSheet(context);
                },
                unitString: _journalCreateBloc.state.fertilizerAreaUnit,
                title: '면적'),
            InputForm1(
                textEditingController: material,
                changed: (value) {
                  _journalCreateBloc
                      .add(FertilizerMaterialChanged(material: value));
                  validate();
                },
                title: '자재이름',
                validatePassword: validatePassword(material.text)),
            InputForm2(
                textEditingController: mUsing,
                changed: (value) {
                  _journalCreateBloc.add(FertilizerMaterialUseChanged(
                      materialUse: double.parse(value)));
                },
                unitPickPressed: () {
                  materialPickBottomSheet(context);
                },
                unitString: _journalCreateBloc.state.fertilizerMaterialUnit,
                title: '자재 사용량'),
            InputForm2(
                textEditingController: wUsing,
                changed: (value) {
                  _journalCreateBloc.add(
                      FertilizerWaterUseChanged(waterUse: double.parse(value)));
                },
                unitPickPressed: () {
                  waterPickBottomSheet(context);
                },
                unitString: _journalCreateBloc.state.fertilizerWaterUnit,
                title: '물 사용량'),
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
