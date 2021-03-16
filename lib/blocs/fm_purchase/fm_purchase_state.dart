

import 'package:BrandFarm/models/farm/farm_model.dart';
import 'package:BrandFarm/models/field_model.dart';
import 'package:flutter/material.dart';

class FMPurchaseState {
  bool isLoading;
  Farm farm;
  List<Field> fieldList;
  Field field;

  FMPurchaseState({
    @required this.isLoading,
    @required this.farm,
    @required this.fieldList,
    @required this.field,
  });

  factory FMPurchaseState.empty() {
    return FMPurchaseState(
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

  FMPurchaseState copyWith({
    bool isLoading,
    Farm farm,
    List<Field> fieldList,
    Field field,
  }) {
    return FMPurchaseState(
      isLoading: isLoading ?? this.isLoading,
      farm: farm ?? this.farm,
      fieldList: fieldList ?? this.fieldList,
      field: field ?? this.field,
    );
  }

  FMPurchaseState update({
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
    return '''FMPurchaseState{
    isLoading: $isLoading,
    farm: ${farm},
    fieldList: ${fieldList.length},
    field: ${field},
    }
    ''';
  }
}
