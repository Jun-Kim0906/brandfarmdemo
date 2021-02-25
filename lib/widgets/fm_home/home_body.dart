import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/fm_home/comments.dart';
import 'package:BrandFarm/widgets/fm_home/create_announcement.dart';
import 'package:BrandFarm/widgets/fm_home/plan.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  HomeBody({
    Key key,
  }) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color(0xFFEEEEEE),
      padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, 0),
      child: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: ListView(
            shrinkWrap: true,
            children: [
              CreateAnnouncement(),
              SizedBox(height: defaultPadding,),
              Plan(),
              SizedBox(height: defaultPadding,),
              Comments(),
              SizedBox(height: defaultPadding,),
            ],
          ),
        ),
      ),
    );
  }
}
