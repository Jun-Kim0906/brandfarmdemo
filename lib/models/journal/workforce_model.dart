import 'package:meta/meta.dart';

class Workforce {
  ///인력투입정보
  final int workforceNum;

  ///참여인원
  final int workforcePrice;

  ///인건비(1인당)
  final bool workforceValid;
  final int index;

  Workforce({
    @required this.workforceNum,
    @required this.workforcePrice,
    @required this.workforceValid,
    @required this.index,
  });

  factory Workforce.fromDs(dynamic ds) {
    Map<String, dynamic> temp = Map<String, dynamic>.from(ds);
    return Workforce.fromMap(temp);
  }

  factory Workforce.fromMap(Map<String, dynamic> workforce) {
    return Workforce(
      workforceNum: workforce['workforceNum'],
      workforcePrice: workforce['workforcePrice'],
      workforceValid: workforce['workforceValid'],
      index: workforce['index'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'workforceNum': this.workforceNum,
      'workforcePrice': this.workforcePrice,
      'workforceValid': this.workforceValid,
      'index': this.index,
    };
  }
}
