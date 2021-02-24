import 'package:BrandFarm/models/journal/fertilize_model.dart';

class FertilizerUtil {
  static Fertilize _fertilize;
  static void setFertilizer(
    String fertilizerMethod,
    double fertilizerArea,
    String fertilizerAreaUnit,
    String fertilizerMaterialName,
    double fertilizerMaterialUse,
    String fertilizerMaterialUnit,
    double fertilizerWater,
    String fertilizerWaterUnit,
  ) async {
    Fertilize tempFertilizer = Fertilize(
      fertilizerArea: fertilizerArea,
      fertilizerAreaUnit: fertilizerAreaUnit,
      fertilizerMaterialName: fertilizerMaterialName,
      fertilizerMaterialUnit: fertilizerMaterialUnit,
      fertilizerMaterialUse: fertilizerMaterialUse,
      fertilizerMethod: fertilizerMethod,
      fertilizerWater: fertilizerWater,
      fertilizerWaterUnit: fertilizerWaterUnit,
    );
    _fertilize = tempFertilizer;
  }

  static Fertilize getFertilizer() {
    return _fertilize;
  }
}
