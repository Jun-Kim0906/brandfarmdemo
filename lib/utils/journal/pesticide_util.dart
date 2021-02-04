
import 'package:BrandFarm/models/journal/pesticide_model.dart';

class PesticideUtil {
  static Pesticide _pesticide;
  static void setPesticide(
    String pesticideMethod,
    double pesticideArea,
    String pesticideAreaUnit,
    String pesticideMaterialName,
    double pesticideMaterialUse,
    String pesticideMaterialUnit,
    double pesticideWater,
    String pesticideWaterUnit,
  ) async {
    Pesticide tempPesticide = Pesticide(
      pesticideArea: pesticideArea,
      pesticideAreaUnit: pesticideAreaUnit,
      pesticideMaterialName: pesticideMaterialName,
      pesticideMaterialUnit: pesticideMaterialUnit,
      pesticideMaterialUse: pesticideMaterialUse,
      pesticideMethod: pesticideMethod,
      pesticideWater: pesticideWater,
      pesticideWaterUnit: pesticideWaterUnit,
    );
    _pesticide = tempPesticide;
  }

  static Pesticide getPesticide() {
    return _pesticide;
  }
}
