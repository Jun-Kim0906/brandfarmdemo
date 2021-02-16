import 'dart:math';

import 'package:BrandFarm/blocs/profile/bloc.dart';
import 'package:BrandFarm/screens/setting/edit_profile_image_screen.dart';
import 'package:BrandFarm/screens/setting/password_screen.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:BrandFarm/widgets/loading/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(GetProfile());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return (state.isLoading)
            ? Loading()
            : Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF219653),
                    ),
                  ),
                  centerTitle: true,
                  title: Text(
                    '프로필 / 계정 설정',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 18,
                        ),
                  ),
                ),
                body: Container(
                  child: Column(
                    children: [
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0x20000000),
                      ),
                      Container(
                        height: 106,
                        padding: EdgeInsets.fromLTRB(
                            defaultPadding, 12, defaultPadding, 12),
                        child: Row(
                          children: [
                            Container(
                              height: 82,
                              width: 82,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: (state.profile.imgUrl.isNotEmpty)
                                            ? CachedNetworkImageProvider(
                                                state.profile.imgUrl)
                                            : AssetImage('assets/profile.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 82,
                                    width: 82,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [
                                          0.75,
                                          0.75,
                                        ],
                                        colors: [
                                          Colors.transparent,
                                          Colors.black,
                                        ],
                                      ),
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    left: 0,
                                    bottom: 0,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (context, a1, a2) =>
                                                  BlocProvider.value(
                                                    value: _profileBloc..add(Reset()),
                                                    child:
                                                        EditProfileImageScreen(),
                                                  ),
                                              transitionsBuilder:
                                                  (c, anim, a2, child) =>
                                                      FadeTransition(
                                                          opacity: anim,
                                                          child: child),
                                              transitionDuration:
                                                  Duration(milliseconds: 300),
                                              opaque: false),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.zero,
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            Text(
                                              '편집',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.profile.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  getPosition(position: state.profile.position),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        fontSize: 12,
                                        color: Color(0xFF15B85B),
                                      ),
                                ),
                                Text(
                                  state.profile.addr ?? '주소',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        fontSize: 12,
                                        color: Color(0x30000000),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0x20000000),
                      ),
                      ListTile(
                        onTap: () {
                          // Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                      value: _profileBloc,
                                      child: PasswordScreen(),
                                    )),
                          );
                        },
                        leading: Text(
                          '내 정보 변경',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0x20000000),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  String getPosition({int position}) {
    switch (position) {
      case 0:
        {
          return '오피스 매니저';
        }
        break;
      case 1:
        {
          return '필드 매니저';
        }
        break;
      case 2:
        {
          return '쉐드 매니저';
        }
        break;
      case 3:
        {
          return '서브 필드매니저';
        }
        break;
    }
    return '';
  }
}
