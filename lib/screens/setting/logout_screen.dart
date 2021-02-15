import 'package:BrandFarm/blocs/authentication/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutScreen extends StatefulWidget {
  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x99000000),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: 111,
            width: 270,
            child: Column(
              children: [
                Container(
                  height: 66,
                  child: Center(
                    child: Text('로그아웃 하시겠습니까?',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 17,
                      ),),
                  ),
                ),
                Divider(height: 1, thickness: 1, color: Color(0x303C3C43),),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 44,
                        width: 135,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(width: 1, color: Color(0x303C3C43),),
                          ),
                        ),
                        child: Center(
                          child: Text('닫기',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 17,
                              color: Color(0xFF007AFF),
                            ),),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          AuthenticationLoggedOut(),
                        );
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: Container(
                        height: 44,
                        width: 135,
                        child: Center(
                          child: Text('확인',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 17,
                              color: Color(0xFF007AFF),
                            ),),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
