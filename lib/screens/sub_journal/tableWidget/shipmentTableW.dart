import 'package:BrandFarm/screens/sub_journal/tableWidget/customExpansionTileRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:BrandFarm/utils/themes/constants.dart';

class ShipmentTable extends StatelessWidget {
  const ShipmentTable(
      this.title,
      this.shipmentPlant,
      this.shipmentPath,
      this.shipmentUnitSelect,
      this.shipmentUnit,
      this.shipmentAmount,
      this.shipmentGrade,
      this.shipmentPrice);

  final String title;
  final String shipmentPlant;
  final String shipmentPath;
  final String shipmentUnitSelect;
  final String shipmentUnit;
  final String shipmentAmount;
  final String shipmentGrade;
  final String shipmentPrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  collapsedBackgroundColor: Color(0xFFF3F3F3),
                  backgroundColor: Color(0xFFF3F3F3),
                  title: Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  children: [
                    Container(
                      color: Colors.white,
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerTheme: DividerThemeData(indent: 3.0, endIndent: 3.0, space: 32, thickness: 1.0)),
                        child: Column(
                          children: [
                            SizedBox(height: defaultPadding,),
                            CustomExpansionTileRow(
                              title: '출하작물',
                              content: shipmentPlant,
                            ),
                            Divider(),
                            CustomExpansionTileRow(
                              title: '출하경로',
                              content: shipmentPath,
                            ),
                            Divider(),
                            CustomExpansionTileRow(
                              title: '출하단위',
                              content: shipmentUnit + " " + shipmentUnitSelect,
                            ),
                            Divider(),
                            CustomExpansionTileRow(
                              title: '출하숫자',
                              content: shipmentAmount,
                            ),
                            Divider(),
                            CustomExpansionTileRow(
                              title: '등급',
                              content: shipmentGrade,
                            ),
                            Divider(),
                            CustomExpansionTileRow(
                              title: '단위가격',
                              content: shipmentPrice,
                            ),
                            SizedBox(height: defaultPadding,),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: defaultPadding,)
        ],
      ),
    );
  }
}
