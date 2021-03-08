import 'package:BrandFarm/blocs/fm_journal/fm_journal_bloc.dart';
import 'package:BrandFarm/blocs/fm_journal/fm_journal_event.dart';
import 'package:BrandFarm/blocs/fm_journal/fm_journal_state.dart';
import 'package:BrandFarm/models/field_model.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FMJournalTitle extends StatefulWidget {
  bool shouldReload;
  FMJournalTitle({Key key, this.shouldReload}) : super(key: key);

  @override
  _FMJournalTitleState createState() => _FMJournalTitleState();
}

class _FMJournalTitleState extends State<FMJournalTitle> {
  FMJournalBloc _fmJournalBloc;

  @override
  void initState() {
    super.initState();
    _fmJournalBloc = BlocProvider.of<FMJournalBloc>(context);
    if(widget.shouldReload) {
      _fmJournalBloc.add(GetFieldList());
    } // get + set
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FMJournalBloc, FMJournalState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '일지목록',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                  ),
            ),
            SizedBox(
              height: 28,
            ),
            _selectFieldDropdown(state: state),
            Divider(
              height: 36,
              thickness: 1,
              color: Color(0xFFDFDFDF),
            ),
          ],
        );
      },
    );
  }

  Widget _selectFieldDropdown({FMJournalState state}) {
    return DropdownButton(
      value: state.field,
      items: state.fieldList.map<DropdownMenuItem<Field>>((Field value) {
        return DropdownMenuItem<Field>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
      style: Theme.of(context).textTheme.bodyText2.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Color(0xFF15B85B),
      ),
      // itemTextstyle: Theme.of(context).textTheme.bodyText2.copyWith(
      //       fontSize: 18,
      //       color: Color(0xFF15B85B),
      //     ),
      // itemWidth: 200,
      // boxPadding: EdgeInsets.symmetric(horizontal: 6),
      // boxTextstyle: Theme.of(context).textTheme.bodyText2.copyWith(
      //       fontSize: 18,
      //       color: Color(0xFF15B85B),
      //     ),
      // boxWidth: 200,
      // boxHeight: 45,
      icon: Icon(Icons.keyboard_arrow_down_sharp, color: Color(0x66000000),),
      onChanged: (Field value) {
        setState(() {
          _fmJournalBloc.add(SetField(field: value));
        });
      },
      underline: Container(),
    );
  }
}
