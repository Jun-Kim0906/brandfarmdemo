
import 'package:BrandFarm/models/journal/seeding_model.dart';

class SeedingUtil {
  static Seeding _seeding;
  static void setSeeding(
    double seedingArea,
    String seedingAreaUnit,
    double seedingAmount,
    String seedingAmountUnit,
  ) async {
    Seeding tempSeeding = Seeding(
        seedingAmount: seedingAmount,
        seedingAmountUnit: seedingAmountUnit,
        seedingArea: seedingArea,
        seedingAreaUnit: seedingAreaUnit);
    _seeding = tempSeeding;
  }

  static Seeding getSeeding() {
    return _seeding;
  }
}
