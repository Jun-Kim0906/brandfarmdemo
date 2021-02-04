
import 'package:BrandFarm/models/facility_model.dart';

class FacilityUtil {
  static Facility _facility;
  static void setFacility(Facility facility) async {
    _facility = facility;
  }

  static Facility getFacility() {
    return _facility;
  }
}
