import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';

class WriteNoticeScreen extends StatefulWidget {
  @override
  _WriteNoticeScreenState createState() => _WriteNoticeScreenState();
}

class _WriteNoticeScreenState extends State<WriteNoticeScreen> {
  List<String> menu = [
    '모든 필드',
    '필드A',
    '필드B',
    '필드C',
  ];
  String val = '모든 필드';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: 398,
        width: 493,
        padding: EdgeInsets.fromLTRB(20, 18, 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('공지사항 작성하기',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
                SizedBox(width: 148,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close, color: Colors.black, size: 24,),
                ),
                SizedBox(width: 13,),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 28, thickness: 1, color: Color(0xFFE1E1E1),),
                  Row(children: [
                    Container(
                      height: 51,
                      width: 51,
                      child: CircleAvatar(
                        backgroundImage: (UserUtil.getUser().imgUrl.isNotEmpty)
                            ? CachedNetworkImageProvider(UserUtil.getUser().imgUrl)
                            : AssetImage('assets/profile.png'),
                      ),
                    ),
                    SizedBox(width: 7,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(UserUtil.getUser().name,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.black,
                          ),),
                        SizedBox(height: 4,),
                        _dropDown(),
                      ],
                    ),
                  ],),
                  SizedBox(height: 21,),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDown() {
    return DropdownBelow(
      value: val,
      items: menu.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      itemTextstyle: Theme.of(context).textTheme.bodyText2.copyWith(
        color: Color(0xFF6F6F6F),
      ),
      itemWidth: 93,
      boxPadding: EdgeInsets.symmetric(horizontal: 8),
      boxTextstyle: Theme.of(context).textTheme.bodyText2.copyWith(
        color: Color(0xFF6F6F6F),
      ),
      boxWidth: 93,
      boxHeight: 24,
      // icon: Icon(
      //   Icons.arrow_drop_down_outlined,
      //   color: Color(0xFFBEBEBE),
      // ),
      onChanged: (String value) {
        setState(() {
          val = value;
        });
      },
    );
  }
}
