import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/pest_model.dart';
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

  Widget diffusionUnit() {
    return Container(
      child: DropdownButton(
        underline: SizedBox(),
        items: [
          DropdownMenuItem(
            value: _journalCreateBloc.state.spreadDegreeUnit,
            child: Text(
              '%',
              // style: blackColor,
            ),
          ),
        ],
        onChanged: (value) {
          _journalCreateBloc.add(SpreadDegreeUnitChanged(degreeUnit: value));
        },
        value: _journalCreateBloc.state.spreadDegreeUnit,
        style: TextStyle(fontSize: 16),
        elevation: 3,
        isExpanded: true,
      ),
    );
  }

  Widget watering() {
    return BlocBuilder<JournalCreateBloc, JournalCreateState>(
      cubit: _journalCreateBloc,
      builder: (context, state) {
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
                    child: Text(
                      '종류',
                      // style: subTitle3,
                    ),
                    padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                    width: (MediaQuery.of(context).size.width - 40) * 0.3,
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        validate();
                        _journalCreateBloc.add(PestKindChanged(kind: value));
                      },
                      controller: species,
                      decoration: InputDecoration(
                        errorText: validatePassword(species.text),
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
                    width: (MediaQuery.of(context).size.width - 40) * 0.3,
                    child: Text(
                      '확산정도',
                      // style: subTitle3,
                    ),
                    padding: EdgeInsets.fromLTRB(0, 26, 0, 26),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _journalCreateBloc.add(
                              SpreadDegreeChanged(degree: double.parse(value)));
                        },
                        controller: diffusion,
                        // decoration: inputContent,
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      flex: 2,
                      child: Container(
                        child: diffusionUnit(),
                      ),
                    ),
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
