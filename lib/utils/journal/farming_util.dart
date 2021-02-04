
import 'package:BrandFarm/models/journal/farming_model.dart';

class FarmingUtil {
  static Farming _farming;
  static void setFarming(
    double farmingArea,
    String farmingAreaUnit,
    String farmingMethod,
    String farmingMethodUnit,
  ) async {
    Farming tempFarming = Farming(
        farmingArea: farmingArea,
        farmingAreaUnit: farmingAreaUnit,
        farmingMethod: farmingMethod,
        farmingMethodUnit: farmingMethodUnit);
    _farming = tempFarming;
  }

  static Farming getFarming() {
    return _farming;
  }
}
