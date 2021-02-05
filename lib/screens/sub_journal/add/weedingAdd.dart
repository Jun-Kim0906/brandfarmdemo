import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/weeding_model.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/sub_journal_create/input_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeedingAdd extends StatefulWidget {
  final Weeding weeding;

  const WeedingAdd({
    this.weeding,
  });

  State<WeedingAdd> createState() => _WeedingAdd();
}

class _WeedingAdd extends State<WeedingAdd> {
  bool expansion;

  Widget tIcon = Icon(
    Icons.add,
    color: Colors.black,
  );

  JournalCreateBloc _journalCreateBloc;
  Weeding _weeding;

  TextEditingController progress;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _weeding = widget.weeding;

    if (_weeding == null) {
      _journalCreateBloc.add(DataCheck(check: true));
      progress = TextEditingController();
      expansion = false;
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
      progress =
          TextEditingController(text: _weeding.weedingProgress.toString());
      expansion = true;
      tIcon = Icon(
        Icons.close,
        color: Colors.black,
      );

      _journalCreateBloc
          .add(WeedingProgressChanged(progress: _weeding.weedingProgress));
      _journalCreateBloc
          .add(WeedingUnitChanged(weedingUnit: _weeding.weedingUnit));
    }
  }

  @override
  Widget build(BuildContext context) {
    return seeding();
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
                TextButton(
                  child: Text('Kg'),
                  onPressed: () {
                    _journalCreateBloc
                        .add(ShipmentUnitSelectChanged(unitSelect: 'Kg'));
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('박스'),
                  onPressed: () {
                    _journalCreateBloc
                        .add(ShipmentUnitSelectChanged(unitSelect: '박스'));
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('콘티'),
                  onPressed: () {
                    _journalCreateBloc
                        .add(ShipmentUnitSelectChanged(unitSelect: '콘티'));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
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
        ],
        onChanged: (value) {
          _journalCreateBloc.add(WeedingUnitChanged(weedingUnit: value));
        },
        value: _journalCreateBloc.state.weedingUnit,
        style: BottomSheetStyle,
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
            InputForm4(title: '제초 작업 \n진행율', changed: (v) {
              validate();
              _journalCreateBloc.add(WeedingProgressChanged(
                  progress: double.parse(v)));
            }, unit: '%', textEditingController: progress),
          ],
        );
      },
    );
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "필수 데이터 입니다.";
    } else {
      return null;
    }
  }

  validate() {
    if (progress.text.isEmpty) {
      _journalCreateBloc.add(DataCheck(check: true));
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
    }
  }
}
