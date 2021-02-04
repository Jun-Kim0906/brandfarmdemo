
import 'package:BrandFarm/models/journal/watering_model.dart';

class WateringUtil {
  static Watering _watering;
  static void setWatering(
    double wateringArea,
    String wateringAreaUnit,
    double wateringAmount,
    String wateringAmountUnit,
  ) async {
    Watering tempWatering = Watering(
        wateringAmount: wateringAmount,
        wateringAmountUnit: wateringAmountUnit,
        wateringArea: wateringArea,
        wateringAreaUnit: wateringAreaUnit);
    _watering = tempWatering;
  }

  static Watering getWatering() {
    return _watering;
  }
}
