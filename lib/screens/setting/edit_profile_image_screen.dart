import 'package:BrandFarm/blocs/profile/bloc.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileImageScreen extends StatefulWidget {
  @override
  _EditProfileImageScreenState createState() => _EditProfileImageScreenState();
}

class _EditProfileImageScreenState extends State<EditProfileImageScreen> {
  ProfileBloc _profileBloc;
  bool isDefaultPressed = false;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.isComplete == true && state.isUploaded == false) {
          LoadingDialog.onLoading(context);
          (isDefaultPressed)
              ? _profileBloc.add(ChangeBackToDefaultImage())
              : _profileBloc.add(ChangeProfileImage());
        } else if (state.isComplete == true && state.isUploaded == true) {
          LoadingDialog.dismiss(context, () {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Scaffold(
            backgroundColor: Color(0x99000000),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultPadding),
                  height: 208,
                  decoration: BoxDecoration(
                    color: Color(0x90FFFFFF),
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
                          _profileBloc.add(CompletePressed());
                          setState(() {
                            isDefaultPressed = true;
                          });
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
                        onTap: () {},
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
                        onTap: () {},
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
          ),
        );
      },
    );
  }
}
