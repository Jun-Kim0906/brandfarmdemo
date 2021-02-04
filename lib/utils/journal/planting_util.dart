
import 'package:BrandFarm/models/journal/planting_model.dart';

class PlantingUtil {
  static Planting _planting;
  static void setPlanting(
    double plantingArea,
    String plantingAreaUnit,
    String plantingCount,
    int plantingPrice,
  ) async {
    Planting tempPlanting = Planting(
      plantingArea: plantingArea,
      plantingAreaUnit: plantingAreaUnit,
      plantingCount: plantingCount,
      plantingPrice: plantingPrice,
    );
    _planting = tempPlanting;
  }

  static Planting getPlanting() {
    return _planting;
  }
}
