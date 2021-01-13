import 'package:BrandFarm/utils/unicode/unicode_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FMHomeScreenWidget extends StatefulWidget {
  @override
  _FMHomeScreenWidgetState createState() => _FMHomeScreenWidgetState();
}

class _FMHomeScreenWidgetState extends State<FMHomeScreenWidget> {
  String fieldListOptions = '거리순';
  int index = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        // height: 500,
        padding: EdgeInsets.all(10),
        child: ListView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/brandfarm.png',
                      height: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '농장 관리',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Container(
                  height: 23,
                  width: 65,
                  color: Colors.white,
                  child: RaisedButton(
                    elevation: 0.0,
                    color: Colors.white,
                    padding: EdgeInsets.all(2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Color(0xFFD6D6D6)),
                    ),
                    child: FittedBox(
                      child: Row(
                        children: [
                          Text(fieldListOptions),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                    onPressed: () {
                      _settingModalBottomSheet(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: (){},
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '한동이네 딸기 농장',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '16',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              Container(
                                height: 30,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      degrees + 'C',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(CupertinoIcons.sun_max),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '경북 포항시',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return new Wrap(
            children: <Widget>[
              ListTile(
                  leading: Text('가나다순'),
                  title: Text(''),
                  trailing: (index == 1)
                      ? Icon(Icons.check)
                      : Container(height: 1, width: 1,),
                  onTap: () => {
                        Navigator.pop(context),
                    setState(() {
                      fieldListOptions = '가나다순';
                      index = 1;
                    }),
                  }),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
              ListTile(
                leading: Text('거리순'),
                title: Text(''),
                trailing: (index == 2)
                    ? Icon(Icons.check)
                    : Container(height: 1, width: 1,),
                onTap: () => {
                  Navigator.pop(context),
                  setState(() {
                    fieldListOptions = '거리순';
                    index = 2;
                  }),
                },
              ),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
              ListTile(
                leading: Text('최근 열람순'),
                title: Text(''),
                trailing: (index == 3)
                    ? Icon(Icons.check)
                    : Container(height: 1, width: 1,),
                onTap: () => {
                  Navigator.pop(context),
                  setState(() {
                    fieldListOptions = '최근 열람순';
                    index = 3;
                  }),
                },
              ),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
              ListTile(
                leading: Text('잘생긴순'),
                title: Text(''),
                trailing: (index == 4)
                    ? Icon(Icons.check)
                    : Container(height: 1, width: 1,),
                onTap: () => {
                  Navigator.pop(context),
                setState(() {
                  fieldListOptions = '잘생긴순';
                  index = 4;
                }),
                },
              ),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
            ],
          );
        });
  }
}
