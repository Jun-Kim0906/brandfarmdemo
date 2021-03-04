import 'package:BrandFarm/blocs/fm_journal/fm_journal_bloc.dart';
import 'package:BrandFarm/blocs/fm_journal/fm_journal_event.dart';
import 'package:BrandFarm/utils/unicode/unicode_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FMJournalList extends StatefulWidget {
  @override
  _FMJournalListState createState() => _FMJournalListState();
}

class _FMJournalListState extends State<FMJournalList> {
  FMJournalBloc _fmJournalBloc;

  @override
  void initState() {
    super.initState();
    _fmJournalBloc = BlocProvider.of<FMJournalBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      // physics: ClampingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Card(
                elevation: 3,
                child: InkResponse(
                  onTap: (){
                    _fmJournalBloc.add(ChangeScreen(navTo: 2));
                  },
                    child: _cardBody(),
                ),
              ),
            ),
            SizedBox(height: 17,),
          ],
        );
      },
    );
  }

  Widget _cardBody() {
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
          SizedBox(width: 3.28,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('05',
                  style: GoogleFonts.lato(
                      fontSize: 50,
                      fontWeight: FontWeight.w300,
                      color: Colors.black)),
              Text('화요일',
                  style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Color(0x80000000))),
            ],
          ),
          SizedBox(width: 44,),
          VerticalDivider(width: 1, thickness: 1, color: Color(0x1A000000), indent: 11, endIndent: 11,),
          SizedBox(width: 23,),
          Container(
            width: 380,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 11,),
                    Text('2021년 4월 5일 일지',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w200,
                        fontSize: 18,
                        color: Colors.black,
                      ),),
                  ],
                ),
                Text('얄리리 얄리리 얄리리 얄리리 얄리리 얄리리 얄리리 얄리리얄리리얄리리 얄리리 얄리리 얄리리 얄리리 얄리리 얄리리 얄리리 얄리리 얄리리',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('댓글 ${3} ${dot} 2021-04-05',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.w200,
                            fontSize: 12,
                            color: Color(0x80000000),
                          ),),
                      ],
                    ),
                    SizedBox(height: 11,),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 30,),
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
                    )
                ),
              ),
              SizedBox(width: 20,),
            ],
          ),
        ],
      ),
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
