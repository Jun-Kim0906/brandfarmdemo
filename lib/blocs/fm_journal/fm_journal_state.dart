import 'package:BrandFarm/models/farm/farm_model.dart';
import 'package:BrandFarm/models/field_model.dart';
import 'package:flutter/foundation.dart';
import 'package:BrandFarm/utils/todays_date.dart';

class FMJournalState {
  bool isLoading;
  int navTo;
  bool isIssue;

  Farm farm;
  List<Field> fieldList;
  Field field;

  String year;
  String month;

  FMJournalState({
    @required this.isLoading,
    @required this.navTo,
    @required this.farm,
    @required this.fieldList,
    @required this.field,
    @required this.year,
    @required this.month,
    @required this.isIssue,
  });

  factory FMJournalState.empty() {
    return FMJournalState(
      isLoading: false,
      navTo: 1,
      isIssue: false,
      farm: Farm(farmID: '', fieldCategory: '', managerID: ''),
      fieldList: [],
      field: Field(
          fieldCategory: '',
          fid: '',
          sfmid: '',
          lat: '',
          lng: '',
          city: '',
          province: '',
          name: ''),
      year: DateTime.now().year.toString(),
      month: DateTime.now().month.toString(),
    );
  }

  FMJournalState copyWith({
    bool isLoading,
    int navTo,
    bool isIssue,
    Farm farm,
    List<Field> fieldList,
    Field field,
    String year,
    String month,
  }) {
    return FMJournalState(
      isLoading: isLoading ?? this.isLoading,
      navTo: navTo ?? this.navTo,
      isIssue: isIssue ?? this.isIssue,
      farm: farm ?? this.farm,
      fieldList: fieldList ?? this.fieldList,
      field: field ?? this.field,
      year: year ?? this.year,
      month: month ?? this.month,
    );
  }

  FMJournalState update({
    bool isLoading,
    int navTo,
    bool isIssue,
    Farm farm,
    List<Field> fieldList,
    Field field,
    String year,
    String month,
  }) {
    return copyWith(
      isLoading: isLoading,
      navTo: navTo,
      isIssue: isIssue,
      farm: farm,
      fieldList: fieldList,
      field: field,
      year: year,
      month: month,
    );
  }

  @override
  String toString() {
    return '''FMIssueState{
    isLoading: $isLoading,
    navTo: $navTo,
    isIssue: $isIssue,
    farm: $farm,
    fieldList: ${fieldList.length},
    field: $field,
    year: $year,
    month: $month,
    }
    ''';
  }
}
