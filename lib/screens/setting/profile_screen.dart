
import 'dart:io';

import 'package:BrandFarm/blocs/profile/bloc.dart';
import 'package:BrandFarm/screens/setting/edit_profile_image_screen.dart';
import 'package:BrandFarm/screens/setting/password_screen.dart';
import 'package:BrandFarm/utils/profile/profile_util.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/loading/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc _profileBloc;
  bool isDefaultPressed = false;
  File profileImage;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(GetProfile());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.isComplete == true && state.isUploaded == false) {
          LoadingDialog.onLoading(context);
          (isDefaultPressed)
              ? _profileBloc.add(ChangeBackToDefaultImage())
              : _profileBloc.add(ChangeProfileImage(img: profileImage));
        } else if (state.isComplete == true && state.isUploaded == true) {
          LoadingDialog.dismiss(context, () {
            Navigator.pop(context);
          });
          _profileBloc.add(Reset());
        }
      },
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
                                            ? NetworkImage(
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
                                        _pickImage(context: context);
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

  void _pickImage({BuildContext context,}) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: defaultPadding),
                    height: 208,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 6,
                        ),
                        Center(
                          child: Text(
                            '프로필 이미지 변경',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Color(0xFF868686),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        ListTile(
                          onTap: () {
                            setState(() {
                              isDefaultPressed = true;
                            });
                            _profileBloc.add(CompletePressed());
                          },
                          title: Center(
                            child: Text(
                              '기본 이미지로 변경',
                              style:
                              Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: 20,
                                color: Color(0xFF3183E3),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        ListTile(
                          onTap: () async {
                            File image;
                            image = await ProfileUtil().getCameraImage();
                            setState(() {
                              isDefaultPressed = false;
                              profileImage = image;
                            });
                            _profileBloc.add(CompletePressed());
                          },
                          title: Center(
                            child: Text(
                              '사진촬영',
                              style:
                              Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: 20,
                                color: Color(0xFF3183E3),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        ListTile(
                          onTap: () async {
                            File image;
                            image = await ProfileUtil().getAlbumImage();
                            setState(() {
                              isDefaultPressed = false;
                              profileImage = image;
                            });
                            _profileBloc.add(CompletePressed());
                          },
                          title: Center(
                            child: Text(
                              '앨범에서 사진 선택',
                              style:
                              Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: 20,
                                color: Color(0xFF3183E3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: defaultPadding),
                    height: 61,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      title: Text(
                        '취소',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color(0xFF3183E3),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                ],
              ),
            ],
          );
        });
  }
}
