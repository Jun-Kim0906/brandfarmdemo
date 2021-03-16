import 'package:BrandFarm/blocs/fm_purchase/fm_purchase_bloc.dart';
import 'package:BrandFarm/blocs/fm_purchase/fm_purchase_state.dart';
import 'package:BrandFarm/models/field_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FMRequestPurchaseScreen extends StatefulWidget {
  @override
  _FMRequestPurchaseScreenState createState() =>
      _FMRequestPurchaseScreenState();
}

class _FMRequestPurchaseScreenState extends State<FMRequestPurchaseScreen> {
  FMPurchaseBloc _fmPurchaseBloc;
  TextEditingController _memoController;
  FocusNode _memoNode;
  String _memo;
  String _datetime;
  List<Material> materialList;

  @override
  void initState() {
    super.initState();
    _fmPurchaseBloc = BlocProvider.of<FMPurchaseBloc>(context);
    _memoController = TextEditingController();
    _memoNode = FocusNode();
    _memo = '';
    _datetime = DateTime.now().toIso8601String();
    materialList = [
      Material(
          num: 1,
          name: '',
          amount: '',
          unit: '',
          price: '',
          marketUrl: '',
          field: null),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FMPurchaseBloc, FMPurchaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            _memoNode.unfocus();
          },
          child: Scaffold(
            backgroundColor: Color(0xFFEEEEEE),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
                child: Container(
                  width: 897,
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(55, 31, 55, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '구매요청하기',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 747,
                            padding: EdgeInsets.fromLTRB(54, 34, 27, 30),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Color(0xFF15B85B),
                              ),
                            ),
                            child: Column(
                              children: [
                                _date(),
                                SizedBox(
                                  height: 37,
                                ),
                                _material(context),
                                SizedBox(
                                  height: 44,
                                ),
                                _writeMemo(),
                                SizedBox(
                                  height: 27,
                                ),
                                _button(),
                              ],
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color(0xFF15B85B),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            child: Icon(
                              Icons.close,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _date() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              '구매요청일자',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                  ),
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              '${_datetime}',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF15B85B),
                  ),
            ),
          ],
        ),
        Container(
            width: 139,
            height: 31,
            decoration: BoxDecoration(
              color: Color(0xFF15B85B),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                '구매정보 불러오기',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
              ),
            ))
      ],
    );
  }

  Widget _material(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: 666,
          child: ListView.builder(
              itemCount: materialList.length ?? 1,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '자재${materialList[index].num}',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                    ),
                    SizedBox(
                      width: 61,
                    ),
                    _materialContent(materialList[index], index),
                  ],
                );
              }),
        ),
        SizedBox(height: 18,),
        Row(
          children: [
            SizedBox(width: 78,),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Color(0xFF15B85B),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white,),
            ),
            SizedBox(width: 5,),
            Text('자재 추가하기',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Color(0x4D000000),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _materialContent(Material obj, int index) {
    return Container(
      height: 100,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _materialName(obj, index),
              SizedBox(height: 14,),
              _materialAmount(obj, index),
              SizedBox(height: 14,),
              _materialPrice(obj, index),
            ],
          ),
          SizedBox(width: 87,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _materialUrl(obj, index),
              SizedBox(height: 14,),
              _materialField(obj, index),
            ],
          ),
        ],
      ),
    );
  }

  Widget _materialName(Material obj, int index) {
    return Row(
      children: [
        Container(
          height: 17,
          width: 37,
          child: Text('자재명',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: Color(0x4D000000),
            ),
          ),
        ),
        SizedBox(width: 17,),
        Container(
          height: 23,
          width: 157,
          decoration: BoxDecoration(
            color: Color(0x0A000000),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            onChanged: (text) {
              Material changedVal = Material(
                num: obj.num,
                name: text,
                amount: obj.amount,
                unit: obj.unit,
                price: obj.price,
                marketUrl: obj.marketUrl,
                field: obj.field,
              );
              setState(() {
                materialList.removeAt(index);
                materialList.insert(index, changedVal);
              });
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget _materialAmount(Material obj, int index) {
    return Row(
      children: [
        Container(
          height: 17,
          width: 37,
          child: Text('수량',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: Color(0x4D000000),
            ),
          ),
        ),
        SizedBox(width: 17,),
        Container(
          height: 23,
          width: 81,
          decoration: BoxDecoration(
            color: Color(0x0A000000),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            onChanged: (text) {
              Material changedVal = Material(
                num: obj.num,
                name: obj.name,
                amount: text,
                unit: obj.unit,
                price: obj.price,
                marketUrl: obj.marketUrl,
                field: obj.field,
              );
              setState(() {
                materialList.removeAt(index);
                materialList.insert(index, changedVal);
              });
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget _materialPrice(Material obj, int index) {
    return Row(
      children: [
        Container(
          height: 17,
          width: 37,
          child: Text('가격',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: Color(0x4D000000),
            ),
          ),
        ),
        SizedBox(width: 17,),
        Container(
          height: 23,
          width: 139,
          decoration: BoxDecoration(
            color: Color(0x0A000000),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            onChanged: (text) {
              Material changedVal = Material(
                num: obj.num,
                name: obj.name,
                amount: obj.amount,
                unit: obj.unit,
                price: text,
                marketUrl: obj.marketUrl,
                field: obj.field,
              );
              setState(() {
                materialList.removeAt(index);
                materialList.insert(index, changedVal);
              });
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget _materialUrl(Material obj, int index) {
    return Container(
      height: 23,
      width: 267,
      decoration: BoxDecoration(
        color: Color(0x0A000000),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        onChanged: (text) {
          Material changedVal = Material(
            num: obj.num,
            name: obj.name,
            amount: obj.amount,
            unit: obj.unit,
            price: obj.price,
            marketUrl: text,
            field: obj.field,
          );
          setState(() {
            materialList.removeAt(index);
            materialList.insert(index, changedVal);
          });
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '판매처 (판매처 링크)',
        ),
      ),
    );
  }

  Widget _materialField(Material obj, int index) {
    return Row(
      children: [
        Container(
          height: 17,
          width: 37,
          child: Text('적용대상',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: Color(0x4D000000),
            ),
          ),
        ),
        SizedBox(width: 17,),
        Container(
          height: 23,
          width: 139,
          decoration: BoxDecoration(
            color: Color(0x0A000000),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            onChanged: (text) {
              Material changedVal = Material(
                num: obj.num,
                name: obj.name,
                amount: obj.amount,
                unit: obj.unit,
                price: obj.price,
                marketUrl: obj.marketUrl,
                field: obj.field,
              );
              setState(() {
                materialList.removeAt(index);
                materialList.insert(index, changedVal);
              });
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget _writeMemo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '메모',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w200,
                color: Colors.black,
              ),
        ),
        SizedBox(
          width: 44,
        ),
        Container(
          height: 95,
          width: 554,
          child: Theme(
            data: ThemeData(
              primaryColor: Color(0xFF15B85B),
            ),
            child: TextField(
              controller: _memoController,
              focusNode: _memoNode,
              onTap: () {
                _memoNode.requestFocus();
              },
              onChanged: (text) {
                _memo = text;
              },
              keyboardType: TextInputType.text,
              maxLength: 6,
              minLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xFF15B85B),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 31,
          decoration: BoxDecoration(
            color: Color(0xFF15B85B),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextButton(
            onPressed: () {},
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 100,
          height: 31,
          decoration: BoxDecoration(
            color: Color(0xFF15B85B),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextButton(
            onPressed: () {},
            child: Text(
              '등록',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class Material {
  int num;
  String name;
  String amount;
  String unit;
  String price;
  String marketUrl;
  Field field;

  Material({
    @required this.num,
    @required this.name,
    @required this.amount,
    @required this.unit,
    @required this.price,
    @required this.marketUrl,
    @required this.field,
  });
}
