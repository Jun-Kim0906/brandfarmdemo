import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/screens/sub_journal/add/editCategory.dart';
import 'package:BrandFarm/screens/sub_journal/add/photoAdd.dart';
import 'package:BrandFarm/screens/sub_journal/sub_journal_input_activity_screen.dart';
import 'package:BrandFarm/utils/column_builder.dart';
import 'package:BrandFarm/utils/journal.category.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/brandfarm_date_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SubJournalCreateScreen extends StatefulWidget {
  @override
  _SubJournalCreateScreenState createState() => _SubJournalCreateScreenState();
}

class _SubJournalCreateScreenState extends State<SubJournalCreateScreen> {
  JournalCreateBloc _journalCreateBloc;
  ScrollController _progressScrollController;
  FocusNode _focusNode;
  ScrollController _scrollController = ScrollController();

  Color textFieldBorderColor;
  bool isFocus = false;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _progressScrollController = ScrollController(initialScrollOffset: 0.0);
    textFieldBorderColor = Color(0x4d000000);
    _focusNode = FocusNode()
      ..addListener(() {
        if (isFocus) {
          setState(() {
            textFieldBorderColor = Color(0x4d000000);
          });
        } else {
          setState(() {
            textFieldBorderColor = Theme.of(context).colorScheme.primary;
          });
        }
        isFocus = !isFocus;
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        cubit: _journalCreateBloc,
        listener: (BuildContext context, JournalCreateState state){
          if (state.isSuggestion == true) {
            Future.delayed(Duration(milliseconds: 100), () {
              _scrollController.animateTo(
                  MediaQuery.of(context).size.height * 0.3,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease);
            });
          }
        },
        child: BlocBuilder<JournalCreateBloc, JournalCreateState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomPadding: true,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  '성장일지 작성',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                centerTitle: true,
              ),
              body: BlocProvider<JournalCreateBloc>.value(
                value: _journalCreateBloc,
                child: GestureDetector(
                  onTap: (){
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: ListView(
                    shrinkWrap: true,
                    controller: _scrollController,
                    physics: ClampingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      InputDateBar(
                        journalCreateBloc: _journalCreateBloc,
                        state: state,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InputTitleBar(
                        journalCreateBloc: _journalCreateBloc,
                        state: state,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      InputActivityBar(
                        state: state,
                        journalCreateBloc: _journalCreateBloc,
                      ),
                      _addedCategory(),
                      SizedBox(
                        height: 15.0,
                      ),
                      PhotoAdd(
                        journalImg: null,
                      ),
                      // AddPictureBar(),
                      SizedBox(
                        height: 15.0,
                      ),
                      AddProgressBar(
                        textFieldBorderColor: textFieldBorderColor,
                        scrollController: _progressScrollController,
                        focusNode: _focusNode,
                        journalCreateBloc: _journalCreateBloc,
                        state: state,
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: CustomBottomButton(
                title: '완료',
                onPressed: (){},
              ),
            );
          },
        ));
  }

  Widget _addedCategory() {
    return _journalCreateBloc.state.widgets.isEmpty
        ? Container()
        : Container(
            child: ColumnBuilder(
              itemBuilder: (BuildContext context, int index) {
                return Ink(
                  padding: EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: defaultPadding),
                  color: Colors.white,
                  child: ListTile(
                    dense: true,
                    trailing: Text(
                      '수정',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 18.0, color: Color(0xb3000000)),
                    ),
                    onTap: () {
                      _journalCreateBloc.add(CategoryChanged(
                          category: getJournalCategoryId(
                              name: _journalCreateBloc
                                  .state.widgets[index].name)));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BlocProvider<JournalCreateBloc>.value(
                                      value: _journalCreateBloc,
                                      child: EditCategory(
                                        index: _journalCreateBloc
                                            .state.widgets[index].index,
                                        category: _journalCreateBloc
                                            .state.widgets[index].name,
                                        listIndex: index,
                                      ))));
                    },
                    title: Row(
                      children: [
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          _journalCreateBloc.state.widgets[index].name,
                          style: Opacity70TileStyle,
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _journalCreateBloc.state.widgets.length,
            ),
          );
  }
}

class InputDateBar extends StatelessWidget {
  const InputDateBar({
    Key key,
    @required JournalCreateBloc journalCreateBloc,
    @required this.state,
  })  : _journalCreateBloc = journalCreateBloc,
        super(key: key);

  final JournalCreateBloc _journalCreateBloc;
  final JournalCreateState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          Text(
              '${DateFormat('yMMMMEEEEd', 'ko').format(state.selectedDate.toDate())}',
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontSize: 16.0, color: Theme.of(context).primaryColor)),
          Spacer(),
          IconButton(
              icon: SvgPicture.asset(
                'assets/svg_icon/calendar_icon.svg',
                color: Color(0xb3000000),
              ),
              onPressed: () async {
                final picked = await BrandFarmDatePicker(
                  context: context,
                  initialDate: state.selectedDate.toDate(),
                  firstDate: DateTime(2015, 1),
                  lastDate: DateTime(2100),
                  helpText: '날짜 선택',
                  locale: Locale('ko', 'KO'),
                );

                if (picked != null && picked != state.selectedDate.toDate()) {
                  _journalCreateBloc.add(
                      DateSelected(selectedDate: Timestamp.fromDate(picked)));
                }
              }),
        ],
      ),
    );
  }
}

class InputTitleBar extends StatelessWidget {
  const InputTitleBar({
    Key key,
    @required JournalCreateBloc journalCreateBloc,
    @required this.state,
  })  : _journalCreateBloc = journalCreateBloc,
        super(key: key);

  final JournalCreateBloc _journalCreateBloc;
  final JournalCreateState state;

  @override
  Widget build(BuildContext context) {
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
            onChanged: (title) {
              _journalCreateBloc.add(TitleChanged(title: title));
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
}

class InputActivityBar extends StatefulWidget {
  const InputActivityBar({
    Key key,
    @required this.state,
    @required JournalCreateBloc journalCreateBloc,
  })  : _journalCreateBloc = journalCreateBloc,
        super(key: key);

  final JournalCreateBloc _journalCreateBloc;
  final JournalCreateState state;

  @override
  _InputActivityBarState createState() => _InputActivityBarState();
}

class _InputActivityBarState extends State<InputActivityBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          Text('일일 활동내역 입력', style: Theme.of(context).textTheme.headline5),
          Spacer(),
          TextButton(
            onPressed: () {
              mainBottomSheet(context);
            },
            child: Text(
              '추가',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 18.0, color: Color(0xb3000000)),
            ),
          )
        ],
      ),
    );
  }

  void mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (BuildContext context) {
          return BlocProvider<JournalCreateBloc>.value(
            value: widget._journalCreateBloc,
            child: MyBottomSheet(),
          );
        });
  }
}

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  JournalCreateBloc _journalCreateBloc;

  @override
  void initState() {
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JournalCreateBloc, JournalCreateState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: defaultPadding,
                  right: defaultPadding,
                  top: defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        _journalCreateBloc.add(CategoryChanged(category: -1));
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '취소',
                        style: Theme.of(context).textTheme.subtitle1,
                      )),
                  TextButton(
                      onPressed: state.category == -1
                          ? null
                          : () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BlocProvider<JournalCreateBloc>.value(
                                              value: _journalCreateBloc,
                                              child:
                                                  SubJournalInputActivityScreen())));
                            },
                      child: Text('완료',
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: state.category == -1
                                  ? Color(0x4D000000)
                                  : Color(0xff000000)))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Wrap(
                  children: journalCategory.map((Map<String, dynamic> item) {
                return categoryItem(item['name'], item['id'], context, state);
              }).toList()),
            ),
          ],
        );
      },
    );
  }

  Widget categoryItem(String buttonText, int id, BuildContext context,
      JournalCreateState state) {
    Color isButtonSelected;
    if (state.category != null && state.category == id) {
      isButtonSelected = Theme.of(context).primaryColor;
      print(state.category);
    } else {
      isButtonSelected = Color(0x4D000000);
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.4827,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15.0),
          child: InkWell(
            onTap: () {
              _journalCreateBloc.add(CategoryChanged(
                  category: getJournalCategoryId(name: buttonText)));
            },
            child: Ink(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              width: MediaQuery.of(context).size.width * 0.349,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: isButtonSelected,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x40000000),
                      offset: Offset(0.0, 4.0),
                      spreadRadius: 0.0,
                      blurRadius: 4.0,
                    )
                  ]),
              child: Center(
                child: Text(
                  buttonText,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: isButtonSelected),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddPictureBar extends StatelessWidget {
  const AddPictureBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return index == 0
                  ? Row(
                      children: [
                        SizedBox(
                          width: defaultPadding,
                        ),
                        Center(
                          child: InkWell(
                              onTap: () {},
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
                        ),
                      ],
                    )
                  : Container();
            },
          ),
        ),
      ],
    );
  }
}

class AddProgressBar extends StatelessWidget {
  const AddProgressBar({
    Key key,
    @required this.textFieldBorderColor,
    @required ScrollController scrollController,
    @required FocusNode focusNode,
    @required JournalCreateBloc journalCreateBloc,
    @required this.state,
  })  : _scrollController = scrollController,
        _focusNode = focusNode,
        _journalCreateBloc = journalCreateBloc,
        super(key: key);

  final Color textFieldBorderColor;
  final ScrollController _scrollController;
  final FocusNode _focusNode;
  final JournalCreateBloc _journalCreateBloc;
  final JournalCreateState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: defaultPadding, right: defaultPadding, bottom: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('과정 기록', style: Theme.of(context).textTheme.headline5),
          SizedBox(
            height: 15.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: textFieldBorderColor,
              ),
            ),
            child: CupertinoScrollbar(
              controller: _scrollController,
              child: TextField(
                focusNode: _focusNode,
                minLines: null,
                maxLines: 8,
                scrollPadding: EdgeInsets.zero,
                style: Theme.of(context).textTheme.bodyText1,
                scrollController: _scrollController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                  isDense: true,
                  hintText: '내용을 입력해주세요',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 18.0, color: Color(0x2C000000)),
                  border: InputBorder.none,
                ),
                onChanged: (content) {
                  _journalCreateBloc.add(ContentChanged(content: content));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _title;

  CustomBottomButton({Key key, VoidCallback onPressed, @required String title})
      : _onPressed = onPressed,
        _title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.086,
      child: RaisedButton(
        child: Text(
          _title ?? '다음',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: 20.0, color: Theme.of(context).colorScheme.onPrimary),
        ),
        onPressed: _onPressed,
      ),
    );
  }
}
