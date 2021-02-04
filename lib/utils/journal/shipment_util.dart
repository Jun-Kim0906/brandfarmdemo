
import 'package:BrandFarm/models/journal/shipment_model.dart';

class ShipmentUtil {
  static Shipment _shipment;
  static void setShipment(
      String shipmentPlant,
      String shipmentPath,
      double shipmentUnit,
      String shipmentUnitSelect,
      String shipmentAmount,
      String shipmentGrade,
      int shipmentPrice) async {
    Shipment tempShipment = Shipment(
        shipmentAmount: shipmentAmount,
        shipmentGrade: shipmentGrade,
        shipmentPath: shipmentPath,
        shipmentPlant: shipmentPlant,
        shipmentPrice: shipmentPrice,
        shipmentUnit: shipmentUnit,
        shipmentUnitSelect: shipmentUnitSelect);
    _shipment = tempShipment;
  }

  static Shipment getShipment() {
    return _shipment;
  }
}
