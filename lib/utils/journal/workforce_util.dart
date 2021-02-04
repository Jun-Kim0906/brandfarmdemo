
import 'package:BrandFarm/models/journal/workforce_model.dart';

class WorkforceUtil {
  static Workforce _workforce;
  static void setWorkforce(
    int workforceNum,
    int workforcePrice,
  ) async {
    Workforce tempWorkforce =
        Workforce(workforceNum: workforceNum, workforcePrice: workforcePrice);
    _workforce = tempWorkforce;
  }

  static Workforce getWorkforce() {
    return _workforce;
  }
}
