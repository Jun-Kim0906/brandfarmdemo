import 'package:BrandFarm/models/farm/farm_model.dart';
import 'package:BrandFarm/models/field_model.dart';
import 'package:flutter/foundation.dart';
import 'package:BrandFarm/utils/todays_date.dart';

class FMJournalState {
  bool isLoading;
  int navTo;
  int index;
  bool isIssue;
  bool shouldReload;
  String order;

  Farm farm;
  List<Field> fieldList;
  Field field;

  String year;
  String month;

  FMJournalState({
    @required this.isLoading,
    @required this.navTo,
    @required this.index,
    @required this.farm,
    @required this.fieldList,
    @required this.field,
    @required this.year,
    @required this.month,
    @required this.isIssue,
    @required this.shouldReload,
    @required this.order,
  });

  factory FMJournalState.empty() {
    return FMJournalState(
      isLoading: false,
      navTo: 1,
      index: 0,
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
      shouldReload: true,
      order: '최신 순',
    );
  }

  FMJournalState copyWith({
    bool isLoading,
    int navTo,
    int index,
    bool isIssue,
    Farm farm,
    List<Field> fieldList,
    Field field,
    String year,
    String month,
    bool shouldReload,
    String order,
  }) {
    return FMJournalState(
      isLoading: isLoading ?? this.isLoading,
      navTo: navTo ?? this.navTo,
      index: index ?? this.index,
      isIssue: isIssue ?? this.isIssue,
      farm: farm ?? this.farm,
      fieldList: fieldList ?? this.fieldList,
      field: field ?? this.field,
      year: year ?? this.year,
      month: month ?? this.month,
      shouldReload: shouldReload ?? this.shouldReload,
      order: order ?? this.order,
    );
  }

  FMJournalState update({
    bool isLoading,
    int navTo,
    int index,
    bool isIssue,
    Farm farm,
    List<Field> fieldList,
    Field field,
    String year,
    String month,
    bool shouldReload,
    String order,
  }) {
    return copyWith(
      isLoading: isLoading,
      navTo: navTo,
      index: index,
      isIssue: isIssue,
      farm: farm,
      fieldList: fieldList,
      field: field,
      year: year,
      month: month,
      shouldReload: shouldReload,
      order: order,
    );
  }

  @override
  String toString() {
    return '''FMIssueState{
    isLoading: $isLoading,
    navTo: $navTo,
    index: $index,
    isIssue: $isIssue,
    farm: $farm,
    fieldList: ${fieldList.length},
    field: $field,
    year: $year,
    month: $month,
    shouldReload: $shouldReload,
    order: $order,
    }
    ''';
  }
}
