
import 'package:BrandFarm/models/journal/weeding_model.dart';

class WeedingUtil {
  static Weeding _weeding;
  static void setWeeding(
    double weedingProgress,
    String weedingUnit,
  ) async {
    Weeding tempWeeding =
        Weeding(weedingProgress: weedingProgress, weedingUnit: weedingUnit);
    _weeding = tempWeeding;
  }

  static Weeding getWeeding() {
    return _weeding;
  }
}
