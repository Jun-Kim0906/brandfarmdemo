
import 'package:BrandFarm/models/journal/pest_model.dart';

class PestUtil {
  static Pest _pest;
  static void setPest(
      String pestKind, double spreadDegree, String spreadDegreeUnit) async {
    Pest tempPest = Pest(
        pestKind: pestKind,
        spreadDegree: spreadDegree,
        spreadDegreeUnit: spreadDegreeUnit);
    _pest = tempPest;
  }

  static Pest getPest() {
    return _pest;
  }
}
