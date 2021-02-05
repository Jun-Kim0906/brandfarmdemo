import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/seeding_model.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/sub_journal_create/input_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeedingAdd extends StatefulWidget {
  final Seeding seeding;

  const SeedingAdd({this.seeding});

  State<SeedingAdd> createState() => _SeedingAdd();
}

class _SeedingAdd extends State<SeedingAdd> {
  bool expansion;
  Widget tIcon = Icon(
    Icons.add,
    color: Colors.black,
  );

  JournalCreateBloc _journalCreateBloc;

  TextEditingController area;
  TextEditingController amount;
  Seeding _seeding;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _seeding = widget.seeding;
    if (_seeding == null) {
      _journalCreateBloc.add(DataCheck(check: true));
      area = TextEditingController();
      amount = TextEditingController();
      expansion = false;
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
      area = TextEditingController(text: _seeding.seedingArea.toString());
      amount = TextEditingController(text: _seeding.seedingAmount.toString());
      expansion = true;
      tIcon = Icon(
        Icons.close,
        color: Colors.black,
      );
      _journalCreateBloc.add(SeedingAreaChanged(area: _seeding.seedingArea));
      _journalCreateBloc
          .add(SeedingAreaUnitChanged(areaUnit: _seeding.seedingAreaUnit));
      _journalCreateBloc
          .add(SeedingAmountChanged(amount: _seeding.seedingAmount));
      _journalCreateBloc.add(
          SeedingAmountUnitChanged(amountUnit: _seeding.seedingAmountUnit));
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
                        .add(SeedingAreaUnitChanged(areaUnit: '%'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '%',
                  selectedColumnContent:
                      _journalCreateBloc.state.seedingAreaUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc
                        .add(SeedingAreaUnitChanged(areaUnit: 'm^2'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: 'm^2',
                  selectedColumnContent:
                      _journalCreateBloc.state.seedingAreaUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: () {
                    _journalCreateBloc
                        .add(SeedingAreaUnitChanged(areaUnit: '평'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '평',
                  selectedColumnContent:
                      _journalCreateBloc.state.seedingAreaUnit,
                ),
                Divider(),
              ],
            ),
          );
        });
  }

  void amountPickBottomSheet(BuildContext context) {
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
                    _journalCreateBloc.add(SeedingAmountUnitChanged(amountUnit: 'kg'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: 'kg',
                  selectedColumnContent: _journalCreateBloc.state.seedingAmountUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(SeedingAmountUnitChanged(amountUnit: 'g'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: 'g',
                  selectedColumnContent: _journalCreateBloc.state.seedingAmountUnit,
                ),
                Divider(),
                InputModalSheetColumn(
                  onTap: (){
                    _journalCreateBloc.add(SeedingAmountUnitChanged(amountUnit: '개'));
                    Navigator.pop(context);
                  },
                  thisColumnContent: '개',
                  selectedColumnContent: _journalCreateBloc.state.seedingAmountUnit,
                ),
                Divider(),
              ],
            ),
          );
        });
  }

  Widget amountUnit() {
    return Container(
      child: DropdownButton(
        underline: SizedBox(),
        items: [
          DropdownMenuItem(
            value: 'kg',
            child: Text(
              'kg',
            ),
          ),
          DropdownMenuItem(
            value: 'g',
            child: Text(
              'g',
            ),
          ),
          DropdownMenuItem(
            value: '개',
            child: Text(
              '개',
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc.add(SeedingAmountUnitChanged(amountUnit: value));
        },
        value: _journalCreateBloc.state.seedingAmountUnit,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget seeding() {
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
                      .add(SeedingAreaChanged(area: double.parse(value)));
                },
                unitPickPressed: () {
                  areaPickBottomSheet(context);
                },
                unitString: _journalCreateBloc.state.seedingAreaUnit,
                title: '파종면적'),
            InputForm2(
                textEditingController: amount,
                changed: (value) {
                  _journalCreateBloc
                      .add(SeedingAmountChanged(amount: double.parse(value)));
                },
                unitPickPressed: () {
                  amountPickBottomSheet(context);
                },
                unitString: _journalCreateBloc.state.seedingAmountUnit,
                title: '파종량'),
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
    return seeding();
  }
}
