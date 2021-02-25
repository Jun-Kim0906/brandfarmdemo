import 'dart:ui';

import 'package:BrandFarm/blocs/authentication/bloc.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/fm_home/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FMHomeScreen extends StatefulWidget {
  @override
  _FMHomeScreenState createState() => _FMHomeScreenState();
}

class _FMHomeScreenState extends State<FMHomeScreen> {
  bool isVisible;
  bool showDrawer;
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    isVisible = true;
    showDrawer = true;
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return _webScreen(context: context);
  }

  Widget _webScreen({BuildContext context}) {
    return Scaffold(
      appBar: _appBar(context: context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth >= 1000) {
            return _big(context: context);
          } else {
            return _small(context: context);
          }
        },
      ),
    );
  }
  
  Widget _appBar({BuildContext context}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: AppBar(
        elevation: 1,
        title: Center(
          child: Row(
            children: [
              Image.asset('assets/fm_home_logo.png'),
              SizedBox(width: 114,),
              _appBarNotification(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBarNotification({BuildContext context}) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 4, 15, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(width: 1, color: Color(0xFFBCBCBC)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: Color(0xFFFDD015),),
          SizedBox(width: 13,),
          Text('날씨가 아직 춥습니다. 매니저분들 모두 농작물 관리에 주의해 주시길 바랍니다',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _small({BuildContext context}) {
    return Row(
      children: [
        _smallDrawer(context: context),
        Expanded(
          child: HomeBody(),
        ),
      ],
    );
  }

  Widget _big({BuildContext context}) {
    return Row(
      children: [
        _drawer(context: context),
        Expanded(
            child: HomeBody(),
        ),
      ],
    );
  }

  Widget _drawer({BuildContext context}) {
    return Drawer(
      elevation: 3,
      child: Column(
        children: [
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.widgets_outlined,
              color: Color(0xFFBDBDBD),
              size: 18,
            ),
            title: Text('Dashboard',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color(0x80000000),
            ),),
          ),
          ExpansionTile(
            leading: Icon(
              Icons.notification_important_outlined,
              color: Color(0xFFBDBDBD),
              size: 18,
            ),
            title: Text('공지사항',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color(0x80000000),
            ),),
            children: [],
          ),
          ExpansionTile(
            leading: Icon(
              Icons.mail_outline,
              color: Color(0xFFBDBDBD),
              size: 18,
            ),
            title: Text('영농계획',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color(0x80000000),
              ),),
            children: [],
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.person_outline,
              color: Color(0xFFBDBDBD),
              size: 18,
            ),
            title: Text('연락처',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color(0x80000000),
              ),),
          ),
          ExpansionTile(
            leading: Icon(
              Icons.chat_bubble_outline,
              color: Color(0xFFBDBDBD),
              size: 18,
            ),
            title: Text('구매요청',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color(0x80000000),
              ),),
            children: [],
          ),
          ExpansionTile(
            leading: Icon(
              Icons.article_outlined,
              color: Color(0xFFBDBDBD),
              size: 18,
            ),
            title: Text('필드관리',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color(0x80000000),
              ),),
            children: [],
          ),
          Divider(
            height: 50,
            thickness: 1,
            color: Color(0xFFEBEFF2),
            endIndent: defaultPadding,
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.more_horiz,
              color: Color(0xFFBDBDBD),
              size: 18,
            ),
            title: Text('설정',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color(0x80000000),
              ),),
          ),
          ListTile(
            onTap: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                AuthenticationLoggedOut(),
              );
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            leading: Icon(
              Icons.logout,
              color: Color(0xFFBDBDBD),
              size: 18,
            ),
            title: Text('로그아웃',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color(0x80000000),
              ),),
          ),
        ],
      ),
    );
  }

  Widget _smallDrawer({BuildContext context}) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      labelType: NavigationRailLabelType.none,
      destinations: [
        NavigationRailDestination(
          icon: Icon(
            Icons.widgets_outlined,
            color: Color(0xFFBDBDBD),
            size: 18,
          ),
          label: Text('Dashboard'),
        ),
        NavigationRailDestination(
          icon: Icon(
            Icons.notification_important_outlined,
            color: Color(0xFFBDBDBD),
            size: 18,
          ),
          label: Text('공지사항'),
        ),
        NavigationRailDestination(
          icon: Icon(
            Icons.mail_outline,
            color: Color(0xFFBDBDBD),
            size: 18,
          ),
          label: Text('영농계획'),
        ),
        NavigationRailDestination(
          icon: Icon(
            Icons.person_outline,
            color: Color(0xFFBDBDBD),
            size: 18,
          ),
          label: Text('연락처'),
        ),
        NavigationRailDestination(
          icon: Icon(
            Icons.chat_bubble_outline,
            color: Color(0xFFBDBDBD),
            size: 18,
          ),
          label: Text('구매요청'),
        ),
        NavigationRailDestination(
          icon: Icon(
            Icons.article_outlined,
            color: Color(0xFFBDBDBD),
            size: 18,
          ),
          label: Text('필드관리'),
        ),
        NavigationRailDestination(
          icon: Icon(
            Icons.more_horiz,
            color: Color(0xFFBDBDBD),
            size: 18,
          ),
          label: Text('설정'),
        ),
        NavigationRailDestination(
          icon: Icon(
            Icons.logout,
            color: Color(0xFFBDBDBD),
            size: 18,
          ),
          label: Text('로그아웃'),
        ),
      ],
    );
  }
}
