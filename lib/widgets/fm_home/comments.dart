import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 26, 18, 0),
            height: 1000,
            width: 814,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    SizedBox(width: 31,),
                    Text('최근 업데이트',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                    ),),
                    SizedBox(width: 10,),
                    Text('+${10}',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF15B85B),
                      ),),
                  ],
                ),
                Divider(height: 40, thickness: 1, color: Color(0xFFDFDFDF),),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return (index % 2 == 0)
                        ? _updateInfo()
                        : _updateInfo();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _updateInfo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 31,),
                Container(
                  width: 37,
                  height: 37,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                      radius: 19.0,
                      backgroundImage: (UserUtil.getUser().imgUrl.isEmpty
                          || UserUtil.getUser().imgUrl == '--')
                          ? AssetImage('assets/profile.png')
                          : NetworkImage(UserUtil.getUser().imgUrl)),
                ),
                SizedBox(width: 8,),
                Text('최브팜',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),),
                Text('님이',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),),
                SizedBox(width: 6,),
                Text('2021년 4월 5일의 기록',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2489FF),
                  ),),
                Text('에 댓글을 남겼습니다',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),),
              ],
            ),
            Row(
              children: [
                Text('38분 전',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Color(0xFF828282),
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),),
                SizedBox(width: 18,),
              ],
            )
          ],
        ),
        SizedBox(height: defaultPadding,),
        // padding: EdgeInsets.fromLTRB(16, 26, 18, 0),
        Row(
          children: [
            SizedBox(width: 102,),
            Card(
              elevation: 3,
              child: Container(
                width: 596,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          child: Container(
                            height: 60,
                            width: 3,
                            color: Color(0x15B85B),
                          ),
                        ),
                        SizedBox(width: 13,),
                        Container(
                          width: 37,
                          height: 37,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                              radius: 19.0,
                              backgroundImage: (UserUtil.getUser().imgUrl.isEmpty
                                  || UserUtil.getUser().imgUrl == '--')
                                  ? AssetImage('assets/profile.png')
                                  : NetworkImage(UserUtil.getUser().imgUrl)),
                        ),
                        SizedBox(width: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('최브팜',
                                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),),
                                    SizedBox(width: 6,),
                                    Text('수고하셨습니다. 끝까지 힘써주세요',
                                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),),
                                  ],
                                ),
                                SizedBox(height: 3,),
                                Row(
                                  children: [
                                    Text('1시간 전',
                                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                                        fontSize: 12,
                                        color: Color(0x73000000),
                                      ),),
                                    SizedBox(width: 13,),
                                    Text('답글 달기',
                                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                                        fontSize: 12,
                                        color: Color(0x73000000),
                                      ),)
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){},
                          icon: Icon(Icons.favorite_border, size: 20, color: Color(0x4D000000),),
                        ),
                        SizedBox(width: 25,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 64,),
          ],
        ),
        Divider(height: 60, thickness: 1, color: Color(0xFFDFDFDF),),
      ],
    );
  }
}
