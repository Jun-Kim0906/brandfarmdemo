import 'package:BrandFarm/widgets/fm_journal/fm_journal_date_picker.dart';
import 'package:BrandFarm/widgets/fm_journal/fm_journal_list.dart';
import 'package:BrandFarm/widgets/fm_journal/fm_journal_list_picker.dart';
import 'package:BrandFarm/widgets/fm_journal/fm_journal_title_bar.dart';
import 'package:flutter/material.dart';

class FMJournalScreen extends StatefulWidget {
  @override
  _FMJournalScreenState createState() => _FMJournalScreenState();
}

class _FMJournalScreenState extends State<FMJournalScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 11, 20, 0),
        child: Container(
          height: 800,
          width: 814,
          padding: EdgeInsets.fromLTRB(19, 29, 24, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Scrollbar(
            controller: _scrollController,
            child: ListView(
              controller: _scrollController,
              shrinkWrap: true,
              children: [
                FMJournalTitle(),
                FMJournalDatePicker(),
                SizedBox(height: 27,),
                FMJournalListPicker(),
                SizedBox(height: 76,),
                FMJournalList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
