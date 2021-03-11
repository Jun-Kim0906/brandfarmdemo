import 'package:BrandFarm/blocs/fm_notification/bloc.dart';
import 'package:BrandFarm/models/field_model.dart';
import 'package:BrandFarm/models/notification/notification_model.dart';
import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteNoticeScreen extends StatefulWidget {
  @override
  _WriteNoticeScreenState createState() => _WriteNoticeScreenState();
}

class _WriteNoticeScreenState extends State<WriteNoticeScreen> {
  FMNotificationBloc _fmNotificationBloc;
  String noticeType;
  TextEditingController _titleController;
  TextEditingController _noticeController;
  FocusNode _titleNode;
  FocusNode _noticeNode;
  String _title;
  String _notice;
  bool canPost;
  bool isScheduled;

  @override
  void initState() {
    super.initState();
    _fmNotificationBloc = BlocProvider.of<FMNotificationBloc>(context);
    _fmNotificationBloc.add(GetFieldList());
    _titleController = TextEditingController();
    _noticeController = TextEditingController();
    _titleNode = FocusNode();
    _noticeNode = FocusNode();
    _title = '';
    _notice = '';
    noticeType = '일반';
    isScheduled = false;
  }

  @override
  Widget build(BuildContext context) {
    if (_title.isNotEmpty && _notice.isNotEmpty) {
      setState(() {
        canPost = true;
      });
    } else {
      setState(() {
        canPost = false;
      });
    }
    return BlocConsumer<FMNotificationBloc, FMNotificationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return (state.field.name.isNotEmpty)
            ? AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Container(
                  height: 398,
                  width: 493,
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '공지사항 작성하기',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                          ),
                          SizedBox(
                            width: 148,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                          SizedBox(
                            width: 13,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              height: 28,
                              thickness: 1,
                              color: Color(0xFFE1E1E1),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 51,
                                  width: 51,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        (UserUtil.getUser().imgUrl.isNotEmpty)
                                            ? CachedNetworkImageProvider(
                                                UserUtil.getUser().imgUrl)
                                            : AssetImage('assets/profile.png'),
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      UserUtil.getUser().name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                            color: Colors.black,
                                          ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        _selectField(state),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        _noticeType(),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 21,
                            ),
                            _writeTitle(),
                            SizedBox(
                              height: 12,
                            ),
                            _writeNotice(),
                            SizedBox(
                              height: 10,
                            ),
                            _scheduling(),
                            SizedBox(
                              height: 10,
                            ),
                            _completeButton(state),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container();
      },
    );
  }

  Widget _selectField(FMNotificationState state) {
    return DropdownBelow(
      value: state.field,
      items: state.fieldList.map<DropdownMenuItem<Field>>((Field value) {
        return DropdownMenuItem<Field>(
          value: value,
          child: Text(value.name),
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
      onChanged: (Field value) {
        setState(() {
          _fmNotificationBloc.add(SetField(field: value));
        });
      },
    );
  }

  Widget _noticeType() {
    return DropdownBelow(
      value: noticeType,
      items: <String>['일반', '중요'].map<DropdownMenuItem<String>>((String value) {
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
      onChanged: (String value) {
        setState(() {
          noticeType = value;
        });
      },
    );
  }

  Widget _writeTitle() {
    return Container(
      height: 32,
      width: 451,
      padding: EdgeInsets.fromLTRB(8, 7, 0, 0),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(7),
      ),
      child: TextField(
        controller: _titleController,
        focusNode: _titleNode,
        onTap: () {
          _titleNode.requestFocus();
        },
        onChanged: (text) {
          setState(() {
            _title = text;
          });
        },
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: 18,
              color: Colors.black,
            ),
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: '제목을 입력해주세요',
          hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 18,
                color: Color(0xFFA8A8A8),
              ),
        ),
      ),
    );
  }

  Widget _writeNotice() {
    return Container(
      height: 121,
      width: 451,
      padding: EdgeInsets.fromLTRB(8, 7, 0, 0),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(7),
      ),
      child: TextField(
        controller: _noticeController,
        focusNode: _noticeNode,
        onTap: () {
          _noticeNode.requestFocus();
        },
        onChanged: (text) {
          setState(() {
            _notice = text;
          });
        },
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: 18,
              color: Colors.black,
            ),
        minLines: null,
        maxLines: 5,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: '공지사항 내용을 입력해주세요',
          hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 18,
                color: Color(0xFFA8A8A8),
              ),
        ),
      ),
    );
  }

  Widget _scheduling() {
    return Container(
      width: 93,
      child: OutlinedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.timer_outlined,
              color: Color(0xFFC2C2C2),
              size: 14,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              '예약하기',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 12,
                    color: Color(0xFFC2C2C2),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _completeButton(FMNotificationState state) {
    return InkResponse(
      onTap: () {
        if (canPost) {
          if (isScheduled) {
            ;
          } else {
            _fmNotificationBloc.add(PostNotification(
                obj: NotificationNotice(
              uid: UserUtil.getUser().uid,
              name: UserUtil.getUser().name,
              imgUrl: UserUtil.getUser().imgUrl,
              fid: state.field.fid,
              farmid: state.farm.farmID,
              title: _title,
              content: _notice,
              postedDate: Timestamp.now(),
              scheduledDate: Timestamp.now(),
              isReadByFM: true,
              isReadByOffice: false,
              isReadBySFM: false,
              notid: '',
              type: noticeType,
            )));
            Navigator.pop(context);
          }
        }
      },
      child: Container(
        height: 35,
        width: 451,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: (canPost) ? Color(0xFF15B85B) : Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child: Text(
            '게시',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w600,
                  color: (canPost) ? Colors.white : Color(0xFFA8A8A8),
                ),
          ),
        ),
      ),
    );
  }
}
