import 'dart:math';

import 'package:BrandFarm/blocs/profile/bloc.dart';
import 'package:BrandFarm/screens/setting/edit_screen.dart';
import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  ProfileBloc _profileBloc;

  TextEditingController _textEditingController;
  FocusNode pswNode;

  String userPsw;
  bool isCorrect = true;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    pswNode = FocusNode();
    userPsw = UserUtil.getUser().psw;
    _textEditingController = TextEditingController();
    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 0.0, end: 43.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
            // else if (status == AnimationStatus.dismissed) {
            //   controller.forward();
            // }
          });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            pswNode.unfocus();
            _textEditingController.clear();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '취소',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '패스워드를 입력해주세요',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                        ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Container(
                    height: 106,
                    width: 106,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: (state.profile.imgUrl.isNotEmpty)
                              ? CachedNetworkImageProvider(state.profile.imgUrl)
                              : AssetImage('assets/profile.png'),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    state.profile.name,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return _textField(context: context);
                    },
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  (!isCorrect)
                      ? Text(
                          '패스워드 오류. 다시 시도해주세요',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.w200,
                                fontSize: 18,
                                color: Color(0xFF545454),
                              ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _textField({BuildContext context}) {
    return Container(
      margin: EdgeInsets.only(
          left: animation.value + 43, right: 43 - animation.value),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Color(0xFFEAEAEA),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: _textEditingController,
        textAlign: TextAlign.center,
        focusNode: pswNode,
        onTap: () {
          pswNode.requestFocus();
          setState(() {
            isCorrect = true;
          });
        },
        onSubmitted: (text) {
          if (userPsw == text) {
            setState(() {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                            value: _profileBloc,
                            child: EditScreen(),
                          )));
            });
          } else {
            setState(() {
              isCorrect = false;
              _textEditingController.clear();
              controller.forward(from: 0.0);
            });
            Future.delayed(Duration(milliseconds: 500)).then((value) => {
              pswNode.requestFocus()
            });
          }
        },
        // style: TextStyle(fontSize: 16),
        obscureText: true,
        obscuringCharacter: "\u2B24",
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          hintText: '비밀번호를 입력하세요',
          hintStyle: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
