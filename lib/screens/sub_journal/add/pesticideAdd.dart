import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/journal_models.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/sub_journal_create/input_forms.dart';
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
    return pesticideWrite();
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
                    _journalCreateBloc.add(PesticideMethod(method: '옆면살포'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '옆면살포',
                  selectedColumnContent:
                  _journalCreateBloc.state.pesticideMethod,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc.add(PesticideMethod(method: '관주'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '관주',
                  selectedColumnContent:
                  _journalCreateBloc.state.pesticideMethod,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc.add(PesticideMethod(method: '전충살포'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '전충살포',
                  selectedColumnContent:
                  _journalCreateBloc.state.pesticideMethod,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc.add(PesticideMethod(method: '기타'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '기타',
                  selectedColumnContent:
                  _journalCreateBloc.state.pesticideMethod,
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
                        .add(PesticideAreaUnitChanged(areaUnit: '%'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '%',
                  selectedColumnContent:
                  _journalCreateBloc.state.pesticideAreaUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc
                        .add(PesticideAreaUnitChanged(areaUnit: 'm^2'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: 'm^2',
                  selectedColumnContent:
                  _journalCreateBloc.state.pesticideAreaUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc
                        .add(PesticideAreaUnitChanged(areaUnit: '평'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '평',
                  selectedColumnContent:
                  _journalCreateBloc.state.pesticideAreaUnit,
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
                        PesticideMaterialUnitChanged(materialUnit: 'g(ml)'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: 'g(ml)',
                  selectedColumnContent:
                  _journalCreateBloc.state.pesticideMaterialUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc.add(
                        PesticideMaterialUnitChanged(materialUnit: 'Kg(L)'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: 'Kg(L)',
                  selectedColumnContent:
                  _journalCreateBloc.state.pesticideMaterialUnit,
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
                    _journalCreateBloc.add(PesticideWaterUnitChanged(waterUnit: '리터'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '리터',
                  selectedColumnContent: _journalCreateBloc.state.pesticideWaterUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(PesticideWaterUnitChanged(waterUnit: '말'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '말',
                  selectedColumnContent: _journalCreateBloc.state.pesticideWaterUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(PesticideWaterUnitChanged(waterUnit: '톤'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '톤',
                  selectedColumnContent: _journalCreateBloc.state.pesticideWaterUnit,
                ),
                Divider(),
              ],
            ),
          );
        });
  }

  Widget pesticideWrite() {
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
                  selected: _journalCreateBloc.state.pesticideMethod),
              InputForm2(
                  textEditingController: area,
                  changed: (value) {
                    validate();
                    _journalCreateBloc
                        .add(PesticideAreaChanged(area: double.parse(value)));
                  },
                  unitPickPressed: () {
                    areaPickBottomSheet(context);
                  },
                  unitString: _journalCreateBloc.state.pesticideAreaUnit,
                  title: '면적'),
              InputForm1(
                  textEditingController: material,
                  changed: (value) {
                    _journalCreateBloc
                        .add(PesticideMaterialChanged(material: value));
                    validate();
                  },
                  title: '자재이름',
                  validatePassword: validatePassword(material.text)),
              InputForm2(
                  textEditingController: mUsing,
                  changed: (value) {
                    _journalCreateBloc.add(PesticideMaterialUseChanged(
                        materialUse: double.parse(value)));
                  },
                  unitPickPressed: () {
                    materialPickBottomSheet(context);
                  },
                  unitString: _journalCreateBloc.state.pesticideMaterialUnit,
                  title: '자재 사용량'),
              InputForm2(
                  textEditingController: wUsing,
                  changed: (value) {
                    _journalCreateBloc.add(
                        PesticideWaterUseChanged(waterUse: double.parse(value)));
                  },
                  unitPickPressed: () {
                    waterPickBottomSheet(context);
                  },
                  unitString: _journalCreateBloc.state.pesticideWaterUnit,
                  title: '물 사용량'),
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
