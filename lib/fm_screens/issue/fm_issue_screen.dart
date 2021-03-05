import 'package:BrandFarm/blocs/fm_issue/bloc.dart';
import 'package:BrandFarm/blocs/fm_journal/fm_journal_bloc.dart';
import 'package:BrandFarm/blocs/fm_journal/fm_journal_event.dart';
import 'package:BrandFarm/fm_screens/issue/fm_issue_detail_screen.dart';
import 'package:BrandFarm/widgets/department_badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:BrandFarm/utils/unicode/unicode_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FMIssueList extends StatefulWidget {
  @override
  _FMIssueListState createState() => _FMIssueListState();
}

class _FMIssueListState extends State<FMIssueList> {
  FMJournalBloc _fmJournalBloc;
  FMIssueBloc _fmIssueBloc;

  @override
  void initState() {
    super.initState();
    _fmIssueBloc = BlocProvider.of<FMIssueBloc>(context);
    _fmJournalBloc = BlocProvider.of<FMJournalBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FMIssueBloc, FMIssueState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Card(
                    elevation: 3,
                    child: InkResponse(
                      onTap: () {
                        _fmJournalBloc.add(ChangeScreen(navTo: 3));
                      },
                      child: CardBody(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}

class CardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      width: 706,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipPath(
                clipper: TriangleClipper(),
                child: Container(
                  height: 34,
                  width: 34,
                  decoration: BoxDecoration(
                    color: Color(0xFFF7685B),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 3.28,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Container(
              width: 515,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 43,
                        height: 22,
                        child: FittedBox(
                          child: DepartmentBadge(
                            department: getIssueState(state: 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '2021_04_05_작물영양이슈',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                            ),
                      ),
                    ],
                  ),
                  Text(
                    '얄리리 얄리리 얄리리 얄리리얄리리얄리리 얄리리 얄리리 얄리리 얄리리 얄리리 얄리리 얄리리 얄리리 얄리리 얄리리 얄리리',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w200,
                          color: Color(0xB3000000),
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        '댓글 ${4} ${dot} 2021-04-05',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.w200,
                              fontSize: 12,
                              color: Color(0x80000000),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 28,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 106,
                width: 106,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/strawberry.png'),
                  fit: BoxFit.cover,
                )),
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
        ],
      ),
    );
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
    }
  }
}
