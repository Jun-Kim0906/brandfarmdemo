
import 'package:BrandFarm/blocs/journal/bloc.dart';
import 'package:BrandFarm/blocs/journal_issue_create/bloc.dart';
import 'package:BrandFarm/utils/sub_journal/get_image.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/utils/todays_date.dart';
import 'package:BrandFarm/widgets/loading/loading.dart';
import 'package:BrandFarm/widgets/sub_journal/bottom_navigation_button.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../utils/user/user_util.dart';

class SubJournalIssueModifyScreen extends StatefulWidget {
  final int index;
  final String from;

  SubJournalIssueModifyScreen({Key key, @required int index, String from})
      : index = index ?? 0,
        from = from ?? 'journal',
        super(key: key);

  @override
  _SubJournalIssueModifyScreenState createState() =>
      _SubJournalIssueModifyScreenState();
}

class _SubJournalIssueModifyScreenState
    extends State<SubJournalIssueModifyScreen> {
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  JournalIssueCreateBloc _journalIssueCreateBloc;
  JournalBloc _journalBloc;

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  // Timestamp tnow = Timestamp.fromDate(DateTime.now());
  Timestamp tnow = Timestamp.now();

  // DateTime dnow = Timestamp.now().toDate();
  // DateTime dnow = DateTime.fromMicrosecondsSinceEpoch(tnow.microsecondsSinceEpoch);
  // DateTime dnow = DateTime.fromMillisecondsSinceEpoch(tnow.millisecondsSinceEpoch);
  // DateTime dnow = DateTime.now();
  int category = 1;
  int issueState = 1;
  String title = '';
  String contents = '';

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    _journalIssueCreateBloc = BlocProvider.of<JournalIssueCreateBloc>(context);
    _journalBloc = BlocProvider.of<JournalBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JournalIssueCreateBloc, JournalIssueCreateState>(
      listener: (context, state) {
        if (state.isComplete == true && state.isUploaded == false) {
          // print('isUpload false');
          LoadingDialog.onLoading(context);
          _journalIssueCreateBloc.add(UploadJournal(
            fid: '--',
            category: category,
            sfmid: '--',
            contents: contents,
            title: title,
            uid: UserUtil.getUser().uid,
            issueState: issueState,
          ));
        } else if (state.isComplete == true && state.isUploaded == true) {
          // print('isUpload true');
          _journalBloc.add(GetInitialList());
          LoadingDialog.dismiss(context, () {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, cstate) {
        return BlocBuilder<JournalBloc, JournalState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  '이슈일지 작성',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.0,
                    ),
                    _dateBar(context: context, state: state),
                    SizedBox(
                      height: 37.0,
                    ),
                    _inputTitleBar(),
                    SizedBox(
                      height: 51.0,
                    ),
                    _chooseCategory(),
                    SizedBox(
                      height: 45.0,
                    ),
                    _chooseIssueState(),
                    SizedBox(
                      height: 48.0,
                    ),
                    _addPictureBar(context: context, state: cstate),
                    SizedBox(
                      height: 43.0,
                    ),
                    _inputIssueContents(),
                    SizedBox(height: 72,),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationButton(
                title: '완료',
                onPressed: () {
                  _journalIssueCreateBloc.add(PressComplete());
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _dateBar({BuildContext context, JournalState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          (widget.from == 'issue') ? Text('${DateFormat('yMMMMEEEEd', 'ko')
              .format(state.issueList[widget.index].date.toDate())}',
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontSize: 16.0, color: Theme.of(context).primaryColor))
              : Text('${DateFormat('yMMMMEEEEd', 'ko')
              .format(state.orderByRecent[widget.index].date.toDate())}',
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontSize: 16.0, color: Theme.of(context).primaryColor)) ,
          Spacer(),
          SvgPicture.asset(
            'assets/svg_icon/calendar_icon.svg',
            color: Color(0xb3000000),
          ),
        ],
      ),
    );
  }

  Widget _inputTitleBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('제목', style: Theme.of(context).textTheme.headline5),
          SizedBox(width: 8.0),
          Expanded(
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    title = text;
                  });
                },
                style:
                Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18.0),
                decoration: InputDecoration(
                    hintText: '2021_0405_한동이네딸기농장',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 18.0, color: Color(0x2C000000)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(5.0)),
              ))
        ],
      ),
    );
  }

  Widget _chooseCategory() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('카테고리 선택', style: Theme.of(context).textTheme.headline5),
          SizedBox(
            width: 10,
          ),
          FlatButton(
            minWidth: 0,
            height: 0,
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                category = 1;
              });
            },
            child: Text(
              '작물',
              style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.w500,
                color:
                (category == 1) ? Color(0xFF219653) : Color(0x40000000),
              ),
            ),
          ),
          // SizedBox(width: 29,),
          FlatButton(
            minWidth: 0,
            height: 0,
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                category = 2;
              });
            },
            child: Text(
              '시설',
              style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.w500,
                color:
                (category == 2) ? Color(0xFF219653) : Color(0x40000000),
              ),
            ),
          ),
          // SizedBox(width: 28,),
          FlatButton(
            minWidth: 0,
            height: 0,
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                category = 3;
              });
            },
            child: Text(
              '기타',
              style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.w500,
                color:
                (category == 3) ? Color(0xFF219653) : Color(0x40000000),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget _chooseIssueState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('이슈 상태', style: Theme.of(context).textTheme.headline5),
          SizedBox(
            width: 10,
          ),
          FlatButton(
            minWidth: 0,
            height: 0,
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                issueState = 1;
              });
            },
            child: Text(
              '예상',
              style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.w500,
                color: (issueState == 1)
                    ? Color(0xFF219653)
                    : Color(0x40000000),
              ),
            ),
          ),
          // SizedBox(width: 29,),
          FlatButton(
            minWidth: 0,
            height: 0,
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                issueState = 2;
              });
            },
            child: Text(
              '진행',
              style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.w500,
                color: (issueState == 2)
                    ? Color(0xFF219653)
                    : Color(0x40000000),
              ),
            ),
          ),
          // SizedBox(width: 28,),
          FlatButton(
            minWidth: 0,
            height: 0,
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                issueState = 3;
              });
            },
            child: Text(
              '완료',
              style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.w500,
                color: (issueState == 3)
                    ? Color(0xFF219653)
                    : Color(0x40000000),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget _addPictureBar({BuildContext context, JournalIssueCreateState state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text('사진첨부', style: Theme.of(context).textTheme.headline5),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          height: 100.0,
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: (state?.imageList?.isEmpty ?? true)
                ? 1
                : state.imageList.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  (index == 0)
                      ? SizedBox(
                    width: defaultPadding,
                  )
                      : Container(),
                  (index == 0)
                      ? Center(
                    child: InkWell(
                        onTap: () {
                          _pickImage(context: context, state: state);
                        },
                        child: Container(
                          height: 74.0,
                          width: 74.0,
                          decoration:
                          BoxDecoration(color: Color(0x1a000000)),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 34.0,
                            ),
                          ),
                        )),
                  )
                      : Container(),
                  (state?.imageList?.isNotEmpty ?? true)
                      ? SizedBox(
                    width: defaultPadding,
                  )
                      : Container(),
                  (state?.imageList?.isNotEmpty ?? true)
                      ? _image(
                    context: context,
                    state: state,
                    index: index,
                  )
                      : Container(),
                  (index == state.imageList.length - 1)
                      ? SizedBox(
                    width: defaultPadding,
                  )
                      : Container(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _image(
      {BuildContext context, JournalIssueCreateState state, int index}) {
    bool isNull = state.imageList[index] == null;
    return Badge(
      // padding: EdgeInsets.zero,
      toAnimate: false,
      badgeContent: InkResponse(
        onTap: () {
          _journalIssueCreateBloc
              .add(DeleteImageFile(removedFile: state.imageList[index]));
        },
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: 11,
        ),
      ),
      badgeColor: Colors.black,
      shape: BadgeShape.circle,
      child: isNull
          ? Container(
        height: 74.0,
        width: 74.0,
        color: Colors.grey,
        child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 0, 61, 165)),
            )),
      )
          : Container(
        height: 74.0,
        width: 74.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(
              state.imageList[index],
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.srcATop),
          ),
        ),
      ),
    );
  }

  Widget _inputIssueContents() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('과정 기록', style: Theme.of(context).textTheme.headline5),
          SizedBox(
            height: 8.0,
          ),
          Scrollbar(
            child: TextField(
              onChanged: (text) {
                setState(() {
                  contents = text;
                });
              },
              scrollPhysics: ClampingScrollPhysics(),
              minLines: null,
              maxLines: 8,
              style: Theme.of(context).textTheme.bodyText1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: '내용을 입력해주세요',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 18.0, color: Color(0x2C000000)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(),
                  )),
            ),
          )
        ],
      ),
    );
  }

  void _pickImage({BuildContext context, JournalIssueCreateState state}) {
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
                  leading: Text('앨범'),
                  title: Text(''),
                  onTap: () => {
                    Navigator.pop(context),
                    getImage(
                      state: state,
                      journalIssueCreateBloc: _journalIssueCreateBloc,
                      from: 'SubJournalIssueCreateScreen',
                    ),
                  }),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
              ListTile(
                leading: Text('카메라'),
                title: Text(''),
                onTap: () => {
                  Navigator.pop(context),
                  getCameraImage(
                    state: state,
                    journalIssueCreateBloc: _journalIssueCreateBloc,
                    from: 'SubJournalIssueCreateScreen',
                  ),
                },
              ),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
            ],
          );
        });
  }
}
