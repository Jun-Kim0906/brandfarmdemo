import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/pest_model.dart';
import 'package:BrandFarm/widgets/sub_journal_create/input_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PestAdd extends StatefulWidget {
  final Pest pest;

  const PestAdd({this.pest});

  State<PestAdd> createState() => _PestAdd();
}

class _PestAdd extends State<PestAdd> {
  bool expansion;
  Widget tIcon = Icon(
    Icons.add,
    color: Colors.black,
  );

  JournalCreateBloc _journalCreateBloc;
  Pest _pest;

  TextEditingController species;
  TextEditingController diffusion;

  @override
  void initState() {
    super.initState();
    _pest = widget.pest;
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);

    if (_pest == null) {
      _journalCreateBloc.add(DataCheck(check: true));
      species = TextEditingController();
      diffusion = TextEditingController();
      expansion = false;
    } else {
      _journalCreateBloc.add(DataCheck(check: false));
      species = TextEditingController(text: _pest.pestKind);
      diffusion = TextEditingController(text: _pest.spreadDegree.toString());
      expansion = true;
      tIcon = Icon(
        Icons.close,
        color: Colors.black,
      );

      _journalCreateBloc.add(PestKindChanged(kind: _pest.pestKind));
      _journalCreateBloc.add(SpreadDegreeChanged(degree: _pest.spreadDegree));
      _journalCreateBloc
          .add(SpreadDegreeUnitChanged(degreeUnit: _pest.spreadDegreeUnit));
    }
  }

  Widget watering() {
    return BlocBuilder<JournalCreateBloc, JournalCreateState>(
      cubit: _journalCreateBloc,
      builder: (context, state) {
        return Column(
          children: <Widget>[
            InputForm1(
                textEditingController: species,
                changed: (value) {
                  validate();
                  _journalCreateBloc.add(PestKindChanged(kind: value));
                },
                title: '종류'),
            InputForm4(
                title: '확산정도',
                changed: (value) {
                  _journalCreateBloc
                      .add(SpreadDegreeChanged(degree: double.parse(value)));
                },
                unit: '%',
                textEditingController: diffusion),
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
    if (species.text.isEmpty) {
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
