import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:BrandFarm/utils/themes/constants.dart';

import 'customExpansionTileRow.dart';

class FertilizerTable extends StatelessWidget {
  const FertilizerTable(
      this.title,
      this.fertilizerMethod,
      this.fertilizerArea,
      this.fertilizerAreaUnit,
      this.fertilizerMaterialName,
      this.fertilizerMaterialUse,
      this.fertilizerMaterialUnit,
      this.fertilizerWater,
      this.fertilizerWaterUnit);

  final String title;
  final String fertilizerMethod;
  final String fertilizerArea;
  final String fertilizerAreaUnit;
  final String fertilizerMaterialName;
  final double fertilizerMaterialUse;
  final String fertilizerMaterialUnit;
  final double fertilizerWater;
  final String fertilizerWaterUnit;

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
                              title: '살포방식',
                              content: fertilizerMethod,
                            ),
                            Divider(),
                            CustomExpansionTileRow(
                              title: '면적',
                              content: fertilizerArea + fertilizerAreaUnit,
                            ),
                            Divider(),
                            CustomExpansionTileRow(
                              title: '자재이름',
                              content: fertilizerMaterialName,
                            ),
                            Divider(),
                            CustomExpansionTileRow(
                              title: '자재사용량',
                              content: fertilizerMaterialUse.toString() +
                                  fertilizerMaterialUnit,
                            ),
                            Divider(),
                            CustomExpansionTileRow(
                              title: '물 사용량',
                              content: fertilizerWater.toString() + fertilizerWaterUnit,
                            ),
                            Divider(),
                            fertilizerMethod == "전충살포"?Container():CustomExpansionTileRow(
                              title: '희석 비율',
                              content: "${(fertilizerMaterialUse / fertilizerWater).toStringAsFixed(2)}",
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
