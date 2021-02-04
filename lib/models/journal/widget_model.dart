import 'package:meta/meta.dart';

class Widgets {
  ///출하정보
  final int index;
  final String name;

  Widgets({
    @required this.name,
    @required this.index,
  });

  factory Widgets.fromDs(dynamic ds) {
    Map<String, dynamic> temp = Map<String, dynamic>.from(ds);
    return Widgets.fromMap(temp);
  }

  factory Widgets.fromMap(Map<String, dynamic> widgets) {
    return Widgets(
      name: widgets["name"],
      index: widgets["index"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'index': this.index,
    };
  }
}
