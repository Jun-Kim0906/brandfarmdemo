import 'package:BrandFarm/blocs/comment/bloc.dart';
import 'package:BrandFarm/blocs/journal/bloc.dart';
import 'package:BrandFarm/blocs/journal_issue_modify/bloc.dart';
import 'package:BrandFarm/screens/sub_journal/sub_journal_issue_modify_screen.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/utils/todays_date.dart';
import 'package:BrandFarm/utils/unicode/unicode_util.dart';
import 'package:BrandFarm/utils/themes/farm_theme_data.dart';
import 'package:BrandFarm/widgets/department_badge.dart';
import 'package:BrandFarm/widgets/loading/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SubJournalDetailScreen extends StatefulWidget {
  String from;
  int index;
  List list;
  String issueListOptions;
  int issueOrder;

  SubJournalDetailScreen({
    Key key,
    String from,
    int state,
    int index,
    List list,
    String issueListOptions,
    int issueOrder,
  })  : from = from ?? 'journal',
        index = index ?? 0,
        list = list,
        issueListOptions = issueListOptions,
        issueOrder = issueOrder,
        super(key: key);

  @override
  _SubJournalDetailScreenState createState() => _SubJournalDetailScreenState();
}

class _SubJournalDetailScreenState extends State<SubJournalDetailScreen> {
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  TextEditingController _textEditingController;
  ScrollController _scrollController;
  JournalBloc _journalBloc;
  CommentBloc _commentBloc;

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  double height;
  bool _isVisible = true;
  String comment = '';
  FocusNode myfocusNode;
  bool _isClear = true;
  bool _isSubCommentClicked = false;
  int indx = 0;
  String cmtid = '';
  int numOfComments;

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    _journalBloc = BlocProvider.of<JournalBloc>(context);
    _commentBloc = BlocProvider.of<CommentBloc>(context);
    if (widget.from == 'issue') {
      _commentBloc.add(LoadComment());
    }
    if (widget.from == 'issue') {
      _commentBloc.add(GetComment(issid: widget.list[widget.index].issid));
    }
    if (widget.from == 'issue') {
      numOfComments = widget.list[widget.index].comments;
    }
    Future.delayed(Duration.zero, () {
      height = MediaQuery.of(context).size.height / 2;
      print(height);
    });
    myfocusNode = FocusNode();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      if (_textEditingController.text.length > 0) {
        setState(() {
          _isClear = false;
        });
      } else {
        setState(() {
          _isClear = true;
        });
      }
    });
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _bottomCommentSection();
    });
  }

  void _bottomCommentSection() {
    if (_scrollController.offset > height) {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          // print("**** ${_isVisible} up");
          if (this.mounted) {
            setState(() {
              _isVisible = false;
            });
          }
        }
      } else {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            // print("**** ${_isVisible} down");
            if (this.mounted) {
              setState(() {
                _isVisible = true;
              });
            }
          }
        }
      }
    } else {
      setState(() {
        _isVisible = true;
      });
    }
  }

  @override
  void dispose() {
    myfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JournalBloc, JournalState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocBuilder<CommentBloc, CommentState>(
          builder: (context, cstate) {
            return (cstate.isLoading)
                ? Loading()
                : Scaffold(
                    appBar: _appBar(context: context),
                    body: (widget.from == 'journal')
                        ? Stack(
                          children: [
                            _journalBody(
                                context: context,
                                state: state,
                              cstate: cstate,
                              ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              // alignment: Alignment(0,1),
                              alignment: _isVisible
                                  ? Alignment(0, 1)
                                  : Alignment(0, 1.5),
                              child: _writeComment(
                                context: context,
                                state: cstate,
                              ),
                            ),
                          ],
                        )
                        : Stack(
                            children: [
                              _issueBody(
                                context: context,
                                state: state,
                                cstate: cstate,
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                // alignment: Alignment(0,1),
                                alignment: _isVisible
                                    ? Alignment(0, 1)
                                    : Alignment(0, 1.5),
                                child: _writeComment(
                                  context: context,
                                  state: cstate,
                                ),
                              ),
                            ],
                          ),
                  );
          },
        );
      },
    );
  }

  Widget _appBar({BuildContext context}) {
    return AppBar(
      elevation: 1,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: (widget.from == 'issue')
          ? Text(
              '${widget.list[widget.index].title}',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.black,
              ),
            )
          : Text(
        '${widget.list[widget.index].title}',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            (widget.from == 'issue') ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (BuildContext context) =>
                                JournalIssueModifyBloc(),
                          ),
                          BlocProvider.value(
                            value: _journalBloc,
                          ),
                        ],
                        child: SubJournalIssueModifyScreen(
                          from: 'issue',
                          issid: widget.list[widget.index].issid,
                          obj: widget.list[widget.index],
                          comments: numOfComments,
                        ),
                      )),
            ) : Container();
          },
          child: Text(
            '편집',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _issueBody(
      {BuildContext context, JournalState state, CommentState cstate}) {
    List pic = state.imageList
        .where((element) => element.issid == widget.list[widget.index].issid)
        .toList();
    return GestureDetector(
      onTap: () {
        myfocusNode.unfocus();
        _textEditingController.clear();
        setState(() {
          _isSubCommentClicked = false;
        });
      },
      child: ListView(
        shrinkWrap: true,
        controller: _scrollController,
        children: [
          SizedBox(
            height: 13,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Container(
              height: 150,
              padding: EdgeInsets.fromLTRB(46, 23, 46, 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1,
                  color: Color(0x30000000),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 26,
                        child: Text('날짜',
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Color(0x70000000),
                                    )),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Text(
                        '${DateFormat('yMMMMEEEEd', 'ko').format(DateTime.fromMicrosecondsSinceEpoch(widget.list[widget.index].date.microsecondsSinceEpoch))}',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 52,
                        child: Text('카테고리',
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Color(0x70000000),
                                    )),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        getCategoryInfo(
                            category: widget.list[widget.index].category),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Color(0xFF219653),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 52,
                        child: Text('이슈상태',
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Color(0x70000000),
                                    )),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      DepartmentBadge(
                          department: getIssueState(
                              state: widget.list[widget.index].issueState)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
              widget.list[widget.index].contents,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          (pic.isNotEmpty)
              ? Divider(
                  height: 0,
                  thickness: 1,
                  color: Color(0x20000000),
                )
              : Container(),
          (pic.isNotEmpty)
              ? SizedBox(
                  height: 10,
                )
              : Container(),
          (pic.isNotEmpty)
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Row(
                    children: [
                      Text(
                        '사진',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Text(
                        '${pic.length}',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFF15B85B),
                            ),
                      ),
                    ],
                  ),
                )
              : Container(),
          (pic.isNotEmpty)
              ? SizedBox(
                  height: 9,
                )
              : Container(),
          (pic.isNotEmpty)
              ? _addPictureBar(context: context, pic: pic)
              : Container(),
          (pic.isNotEmpty)
              ? SizedBox(
                  height: 17,
                )
              : Container(),
          (cstate.comments.isNotEmpty)
              ? Divider(
                  height: 0,
                  thickness: 1,
                  color: Color(0x20000000),
                )
              : Container(),
          (cstate.comments.isNotEmpty)
              ? SizedBox(
                  height: 20,
                )
              : Container(),
          (cstate.comments.isNotEmpty)
              ? _comment(context: context, state: cstate)
              : Container(),
          (cstate.comments.isNotEmpty)
              ? SizedBox(
                  height: 91,
                )
              : Container(),
        ],
      ),
    );
  }

  String getCategoryInfo({int category}) {
    switch (category) {
      case 1:
        {
          return '작물';
        }
        break;
      case 2:
        {
          return '시설';
        }
        break;
      case 3:
        {
          return '기타';
        }
        break;
      default:
        {
          return '--';
        }
    }
  }

  String getIssueState({int state}) {
    switch (state) {
      case 1:
        {
          return 'todo';
        }
        break;
      case 2:
        {
          return 'doing';
        }
        break;
      case 3:
        {
          return 'done';
        }
        break;
      default:
        {
          return '--';
        }
        break;
    }
  }

  Widget _journalBody({BuildContext context, JournalState state, CommentState cstate}) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        TextEditingController().clear();
      },
      child: ListView(
        children: [
          SizedBox(
            height: 24,
          ),
          _journalDate(context: context, state: state),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
                child: Text(
              '일일 활동내역',
              style: Theme.of(context).textTheme.headline5
            )),
          ),
          SizedBox(
            height: 15,
          ),
          _infoContainer(context: context),
          SizedBox(
            height: 31,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              child: Row(
                children: [
                  Text(
                    '사진',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    '4',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF219653),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _imageList(context: context),
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '과정 기록',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )),
          ),
          SizedBox(
            height: 12,
          ),
          _record(context: context),
          SizedBox(
            height: 55,
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _journalDate({BuildContext context, JournalState state}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          child: Text(
            '${DateFormat('yMMMMEEEEd', 'ko').format(widget.list[widget.index].date.toDate())}',
            style: Theme.of(context).textTheme.subtitle2.copyWith(
              fontSize: 16.0, color: Theme.of(context).primaryColor)
          )),
    );
  }

  Widget _infoContainer({BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ExpansionTile(
              tilePadding: EdgeInsets.symmetric(horizontal: defaultPadding),
              collapsedBackgroundColor: Color(0xFFF3F3F3),
              backgroundColor: Color(0xFFF3F3F3),
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  '출하정보',
                  style: Theme.of(context)
                      .textTheme
                      .infoContainerTitleTextTheme
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 16,),
                      Row(
                        children: [
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Container(
                            width: 52,
                            child: Text(
                              '출하작물',
                              style: Theme.of(context)
                                  .textTheme
                                  .infoContainerTitleTextTheme,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            '딸기',
                            style: Theme.of(context)
                                .textTheme
                                .infoContainerBodyTextTheme,
                          ),
                        ],
                      ),
                      Divider(height: 32, thickness: 1, indent: 3, endIndent: 3,),
                      Row(
                        children: [
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Container(
                            width: 52,
                            child: Text(
                              '출하경로',
                              style: Theme.of(context)
                                  .textTheme
                                  .infoContainerTitleTextTheme,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            '얄리리 얄랑셩 얄라리 얄라',
                            style: Theme.of(context)
                                .textTheme
                                .infoContainerBodyTextTheme,
                          ),
                        ],
                      ),
                      Divider(height: 32, thickness: 1, indent: 3, endIndent: 3,),
                      Row(
                        children: [
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Container(
                            width: 52,
                            child: Text(
                              '출하단위',
                              style: Theme.of(context)
                                  .textTheme
                                  .infoContainerTitleTextTheme,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            '1',
                            style: Theme.of(context)
                                .textTheme
                                .infoContainerBodyTextTheme,
                          ),
                        ],
                      ),
                      Divider(height: 32, thickness: 1, indent: 3, endIndent: 3,),
                      Row(
                        children: [
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Container(
                            width: 52,
                            child: Text(
                              '출하숫자',
                              style: Theme.of(context)
                                  .textTheme
                                  .infoContainerTitleTextTheme,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            '50 kg',
                            style: Theme.of(context)
                                .textTheme
                                .infoContainerBodyTextTheme,
                          ),
                        ],
                      ),
                      Divider(height: 32, thickness: 1, indent: 3, endIndent: 3,),
                      Row(
                        children: [
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Container(
                            width: 52,
                            child: Text(
                              '등급',
                              style: Theme.of(context)
                                  .textTheme
                                  .infoContainerTitleTextTheme,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            '특',
                            style: Theme.of(context)
                                .textTheme
                                .infoContainerBodyTextTheme,
                          ),
                        ],
                      ),
                      Divider(height: 32, thickness: 1, indent: 3, endIndent: 3,),
                      Row(
                        children: [
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Container(
                            width: 52,
                            child: Text(
                              '단위가격',
                              style: Theme.of(context)
                                  .textTheme
                                  .infoContainerTitleTextTheme,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            '9000 원',
                            style: Theme.of(context)
                                .textTheme
                                .infoContainerBodyTextTheme,
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 22,),
        ],
      ),
    );
  }

  Widget _addPictureBar({
    BuildContext context,
    List pic,
  }) {
    return Container(
      height: 74,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: pic.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              SizedBox(
                width: defaultPadding,
              ),
              _image(
                context: context,
                url: pic[index].url,
              ),
              (index == pic.length - 1)
                  ? SizedBox(
                      width: defaultPadding,
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Widget _image({BuildContext context, String url}) {
    return Container(
      height: 74.0,
      width: 74.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            url,
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.srcATop),
        ),
      ),
    );
  }

  Widget _imageList({BuildContext context}) {
    return Container(
      height: 85,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return (index == 0)
                ? Row(
                    children: [
                      SizedBox(
                        width: defaultPadding,
                      ),
                      Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/strawberry.png'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.srcATop),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      SizedBox(
                        width: 1,
                        height: 85,
                      ),
                      Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/strawberry.png'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.srcATop),
                          ),
                        ),
                      ),
                      (index == 5)
                          ? SizedBox(
                              width: defaultPadding,
                            )
                          : Container(),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget _record({BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 11, 19, 11),
          child: Text(
            '포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항 포항항',
            style: TextStyle(
              fontSize: 16,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _comment({BuildContext context, CommentState state}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(state.comments.length, (index) {
          return Column(
            children: [
              commentTile(context: context, state: state, index: index),
              SizedBox(
                height: 20,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget commentTile({BuildContext context, CommentState state, int index}) {
    List scomments = state.scomments
        .where((cmt) => cmt.cmtid == state.comments[index].cmtid)
        .toList();
    String time = getTime(date: state.comments[index].date);
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 37,
                width: 37,
                decoration: new BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    state.comments[index].name,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  // SizedBox(
                  //   height: 3,
                  // ),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
              SizedBox(
                width: 7,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.comments[index].comment,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 11,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isSubCommentClicked = true;
                            cmtid = state.comments[index].cmtid;
                            indx = index;
                            myfocusNode.requestFocus();
                          });
                        },
                        child: Text(
                          '답글 달기',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                        ),
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      (state.comments[index].isExpanded)
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  // isExpanded = false;
                                  _commentBloc.add(CloseComment(index: index));
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    '답글 숨기기',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                  ),
                                  Container(
                                      width: 14,
                                      height: 14,
                                      child: FittedBox(
                                          child: Icon(
                                        Icons.arrow_drop_up_outlined,
                                        color: Colors.grey,
                                      ))),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ],
          ),
          (scomments.isNotEmpty)
              ? SizedBox(
                  height: 10,
                )
              : Container(),
          (scomments.isNotEmpty && !state.comments[index].isExpanded)
              ? Row(
                  children: [
                    SizedBox(
                      width: 77,
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            // isExpanded = true;
                            _commentBloc.add(ExpandComment(index: index));
                          });
                        },
                        child: Text('답글 ${scomments.length}개 펼치기',
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                    ),
                  ],
                )
              : Container(),
          (state.comments[index].isExpanded)
              ? showSubComments(context: context, scmts: scomments)
              : Container(),
        ],
      ),
    );
  }

  Widget showSubComments({BuildContext context, List scmts}) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(scmts.length, (index) {
          return Column(
            children: [
              subComment(context: context, scmts: scmts, index: index),
              (index != scmts.length - 1)
                  ? SizedBox(
                      height: 20,
                    )
                  : Container(),
            ],
          );
        }),
      ),
    );
  }

  Widget subComment({BuildContext context, List scmts, int index}) {
    String time = getTime(date: scmts[index].date);
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.subdirectory_arrow_right_outlined,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 37,
            width: 37,
            decoration: new BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${scmts[index].name}',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${time}',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '${scmts[index].scomment}',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getTime({Timestamp date}) {
    DateTime now = DateTime.now();
    DateTime _date =
        DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);
    int diffDays = now.difference(_date).inDays;
    if (diffDays < 1) {
      int diffHours = now.difference(_date).inHours;
      if (diffHours < 1) {
        int diffMinutes = now.difference(_date).inMinutes;
        if (diffMinutes < 1) {
          int diffSeconds = now.difference(_date).inSeconds;
          return '${diffSeconds}초 전';
        } else {
          return '${diffMinutes}분 전';
        }
      } else {
        return '${diffHours}시간 전';
      }
    } else if (diffDays >= 1 && diffDays <= 365) {
      int monthNow = int.parse(DateFormat('MM').format(now));
      int monthBefore = int.parse(DateFormat('MM').format(
          DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch)));
      int diffMonths = monthNow - monthBefore;
      if (diffMonths == 0) {
        return '${diffDays}일 전';
      } else {
        return '${diffMonths}달 전';
      }
    } else {
      double tmp = diffDays / 365;
      int diffYears = tmp.toInt();
      return '${diffYears}년 전';
    }
  }

  Widget _writeComment({BuildContext context, CommentState state}) {
    return Wrap(
      children: [
        (_isSubCommentClicked)
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                height: 44,
                color: Color(0xFFEDEDED),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${state.comments[indx].name}님에게 답글 남기는 중. . .'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isSubCommentClicked = false;
                        });
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: (myfocusNode.hasFocus) ? 65 : 91,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 1, color: Color(0x30000000)),
              )),
          child: Column(
            children: [
              SizedBox(
                height: 9,
              ),
              Row(
                children: [
                  Container(
                    height: 47,
                    width: 47,
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Expanded(
                    child: Theme(
                      child: TextField(
                        controller: _textEditingController,
                        focusNode: myfocusNode,
                        onTap: () {
                          myfocusNode.requestFocus();
                        },
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                          ),
                          hintText: '댓글 달기...',
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                comment = _textEditingController.text;
                              });
                              if (_isSubCommentClicked) {
                                if (widget.from == 'journal') {
                                  _commentBloc.add(AddSubComment(
                                    from: 'journal',
                                    id: widget.list[widget.index].jid,
                                    comment: comment,
                                    cmtid: cmtid,
                                  ));
                                } else {
                                  _commentBloc.add(AddSubComment(
                                    from: 'issue',
                                    id: widget.list[widget.index].issid,
                                    comment: comment,
                                    cmtid: cmtid,
                                  ));
                                }
                              } else {
                                if (widget.from == 'journal') {
                                  _commentBloc.add(AddComment(
                                    from: 'journal',
                                    id: widget.list[widget.index].jid,
                                    comment: comment,
                                  ));
                                } else {
                                  _commentBloc.add(AddComment(
                                    from: 'issue',
                                    id: widget.list[widget.index].issid,
                                    comment: comment,
                                  ));
                                }
                              }
                              setState(() {
                                _isSubCommentClicked = false;
                                numOfComments += 1;
                              });
                              _commentBloc.add(LoadComment());
                              _commentBloc.add(GetComment(
                                  issid: widget.list[widget.index].issid));
                              _textEditingController.clear();
                              _journalBloc.add(AddIssueComment(
                                  index: widget.index,
                                  issueListOptions: widget.issueListOptions,
                                  issueOrder: widget.issueOrder,
                                  issid: widget.list[widget.index].issid));
                            },
                            child: Container(
                                width: 30,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '게시',
                                      style: (_isClear)
                                          ? Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                color: Colors.grey,
                                              )
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                color: Color(0xFF15B833),
                                              ),
                                    ))),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        ),
                      ),
                      data: Theme.of(context).copyWith(
                        primaryColor: Color(0xFF15B85B),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
