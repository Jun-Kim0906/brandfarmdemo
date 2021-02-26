import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';

class SearchAndOptionsBar extends StatefulWidget {
  @override
  _SearchAndOptionsBarState createState() => _SearchAndOptionsBarState();
}

class _SearchAndOptionsBarState extends State<SearchAndOptionsBar> {
  String order;
  String productName;

  @override
  void initState() {
    super.initState();
    order = '최근 순';
    productName = '자재명';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // _orderButton(),
        _productName(),
        // Row(
        //   children: [
        //     _productName(),
        //     SizedBox(width: 5,),
        //     TextField(
        //       decoration: InputDecoration(
        //         border: OutlineInputBorder(),
        //         labelText: 'Password',
        //       ),
        //     ),
        //     SizedBox(width: 207,),
        //   ],
        // ),
      ],
    );
  }

  Widget _orderButton() {
    return DropdownBelow(
      boxHeight: 45,
      boxWidth: 120,
      itemWidth: 120,
      boxPadding: EdgeInsets.fromLTRB(13, 12, 0, 12),
      value: order,
      items: <String>['최근 순', '오래된 순']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      style: Theme.of(context).textTheme.bodyText2.copyWith(
        fontSize: 13,
        color: Color(0xB3000000),
      ),
      boxTextstyle: Theme.of(context).textTheme.bodyText2.copyWith(
        fontSize: 13,
        color: Color(0xB3000000),
      ),
      itemTextstyle: Theme.of(context).textTheme.bodyText2.copyWith(
        fontSize: 13,
        color: Color(0xB3000000),
      ),
      onChanged: (String newValue) {
        setState(() {
          order = newValue;
        });
      },
    );
  }

  Widget _productName() {
    return DropdownBelow(
      boxHeight: 45,
      boxWidth: 120,
      itemWidth: 120,
      boxPadding: EdgeInsets.fromLTRB(13, 12, 0, 12),
      value: productName,
      items: <String>['자재명', '자재명', '자재명']
          .map<DropdownMenuItem<String>>((String value2) {
        return DropdownMenuItem<String>(value: value2, child: Text(value2));
      }).toList(),
      style: Theme.of(context).textTheme.bodyText2.copyWith(
        fontSize: 13,
        color: Color(0xB3000000),
      ),
      boxTextstyle: Theme.of(context).textTheme.bodyText2.copyWith(
        fontSize: 13,
        color: Color(0xB3000000),
      ),
      itemTextstyle: Theme.of(context).textTheme.bodyText2.copyWith(
        fontSize: 13,
        color: Color(0xB3000000),
      ),
      onChanged: (String newValue2) {
        setState(() {
          productName = newValue2;
        });
      },
    );
  }
}
