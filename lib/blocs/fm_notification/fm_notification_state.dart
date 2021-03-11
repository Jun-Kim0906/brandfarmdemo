

import 'package:BrandFarm/models/farm/farm_model.dart';
import 'package:BrandFarm/models/field_model.dart';
import 'package:flutter/material.dart';

class FMNotificationState {
  bool isLoading;
  Farm farm;
  List<Field> fieldList;
  Field field;

  FMNotificationState({
    @required this.isLoading,
    @required this.farm,
    @required this.fieldList,
    @required this.field,
  });

  factory FMNotificationState.empty() {
    return FMNotificationState(
      isLoading: false,
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
    );
  }

  FMNotificationState copyWith({
    bool isLoading,
    Farm farm,
    List<Field> fieldList,
    Field field,
  }) {
    return FMNotificationState(
      isLoading: isLoading ?? this.isLoading,
      farm: farm ?? this.farm,
      fieldList: fieldList ?? this.fieldList,
      field: field ?? this.field,
    );
  }

  FMNotificationState update({
    bool isLoading,
    Farm farm,
    List<Field> fieldList,
    Field field,
  }) {
    return copyWith(
      isLoading: isLoading,
      farm: farm,
      fieldList: fieldList,
      field: field,
    );
  }

  @override
  String toString() {
    return '''FMNotificationState{
    isLoading: $isLoading,
    farm: ${farm},
    fieldList: ${fieldList.length},
    field: ${field},
    }
    ''';
  }
}
