import 'package:BrandFarm/models/field_model.dart';

class FieldUtil {
  static Field _field;
  static void setField(Field field) async {
    _field = field;
  }

  static Field getField() {
    return _field;
  }
}
