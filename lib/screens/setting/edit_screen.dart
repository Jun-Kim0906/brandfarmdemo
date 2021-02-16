import 'package:BrandFarm/blocs/profile/bloc.dart';
import 'package:BrandFarm/screens/setting/edit_profile_email_screen.dart';
import 'package:BrandFarm/screens/setting/edit_profile_phone_num_screen.dart';
import 'package:BrandFarm/screens/setting/edit_profile_psw_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
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
              '내 정보 변경',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 18,
                  ),
            ),
          ),
          body: Column(
            children: [
              Divider(
                height: 1,
                thickness: 1,
                color: Color(0x20000000),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BlocProvider.value(
                        value: _profileBloc..add(Reset()),
                      child: EditProfilePhoneNumScreen(num: state.profile.phone,),
                    ))
                  );
                },
                leading: Text(
                  '연락처 변경',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: (state.profile.phone.isEmpty) ? Text(
                  '추가',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ) : Text(state.profile.phone,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Color(0x30000000),
                  ),),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: Color(0x20000000),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BlocProvider.value(
                        value: _profileBloc..add(Reset()),
                        child: EditProfileEmailScreen(email: state.profile.email,),
                      ))
                  );
                },
                leading: Text(
                  '메일주소 변경',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: (state.profile.email.isEmpty) ? Text(
                  '추가',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ) : Text(state.profile.email,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Color(0x30000000),
                ),),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: Color(0x20000000),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BlocProvider.value(
                        value: _profileBloc..add(Reset()),
                        child: EditProfilePswScreen(psw: state.profile.psw,),
                      ))
                  );
                },
                leading: Text(
                  '비밀번호 변경',
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
        );
      },
    );
  }
}
