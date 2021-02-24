import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'customExpansionTileRow.dart';

class PestTable extends StatelessWidget {
  const PestTable(this.title, this.data1, this.data2, this.data3);

  final String title;
  final String data1;
  final String data2;
  final String data3;

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
                              title: '종류',
                              content: data1,
                            ),
                            Divider(),
                            CustomExpansionTileRow(
                              title: '확산정도',
                              content: data2 + data3,
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
