import 'dart:math';

import 'package:brandfarmdemo/blocs/authentication/bloc.dart';
import 'package:brandfarmdemo/layout/adaptive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brandfarmdemo/repository/user/user_repository.dart';
import 'package:brandfarmdemo/blocs/login/bloc.dart';
import 'package:brandfarmdemo/widgets/login/login.dart';

const _horizontalPadding = 24.0;

double desktopLoginScreenMainAreaWidth({BuildContext context}) {
  return min(
    360,
    MediaQuery.of(context).size.width - 2 * _horizontalPadding,
  );
}

class LoginScreen extends StatefulWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserRepository get _userRepository => widget._userRepository;
  LoginBloc _loginBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onLoginEmailChanged);
    _passwordController.addListener(_onLoginPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return BlocListener(
      cubit: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        if (state.isFailure) {
          _showMyDialog(context);
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (isDesktop) {
          return LayoutBuilder(
            builder: (context, constraints) => Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.darken),
                image: AssetImage('assets/login_backgroundimg.jpg'),
                fit: BoxFit.cover,
              )),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Center(
                      child: Container(
                    width: desktopLoginScreenMainAreaWidth(context: context),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _FarmLogo(),
                          SizedBox(height: 40),
                          _UsernameTextField(
                              emailController: _emailController, state: state),
                          SizedBox(height: 16),
                          _PasswordTextField(
                              passwordController: _passwordController,
                              state: state),
                          SizedBox(height: 24),
                          LoginButton(
                            onPressed: isLoginButtonEnabled(state)
                                ? _onFormSubmitted
                                : null,
                            isValid: isLoginButtonEnabled(state),
                          ),
                        ],
                      ),
                    ),
                  )),
                ),
              ),
            ),
          );
        } else {
          return Stack(
            children: [
              Scaffold(
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: Center(
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: _horizontalPadding,
                        ),
                        child: Column(
                          children: [
                            _FarmLogo(),
                            SizedBox(height: 24),
                            _UsernameTextField(
                                emailController: _emailController, state: state),
                            SizedBox(height: 12),
                            _PasswordTextField(
                                passwordController: _passwordController,
                                state: state),
                            SizedBox(height: 16),
                            LoginButton(
                              onPressed: isLoginButtonEnabled(state)
                                  ? _onFormSubmitted
                                  : null,
                              isValid: isLoginButtonEnabled(state),
                            ),
                            SizedBox(height: 70),
                          ],
                        ),
                      ),
                    ),
                  )),
              Visibility(
                  visible: state.isSubmitting,
                  child: Container(
                    color: Colors.black26,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(),
                    ),
                  ))
            ],
          );
        }
      }),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginEmailChanged() {
    _loginBloc.add(
      LoginEmailChanged(email: _emailController.text),
    );
  }

  void _onLoginPasswordChanged() {
    _loginBloc.add(
      LoginPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}

class _FarmLogo extends StatelessWidget {
  const _FarmLogo();

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    return ExcludeSemantics(
      child: Column(
        children: [
          Image.asset('assets/brandfarm.png', height: 80),
          SizedBox(height: 16),
          Text('Brand Farm',
              style: isDesktop
                  ? Theme.of(context)
                      .textTheme
                      .headline2
                      .apply(color: Color(0xffffffff))
                  : Theme.of(context)
                      .textTheme
                      .headline3),
        ],
      ),
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  _UsernameTextField({this.emailController, this.state});

  final TextEditingController emailController;
  final LoginState state;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffffffff),
        hintText: '사원번호',
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.disabled,
      autocorrect: false,
      validator: (_) {
        return !state.isEmailValid ? '사원번호를 입력하세요' : null;
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  _PasswordTextField({this.passwordController, this.state});

  final TextEditingController passwordController;
  final LoginState state;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffffffff),
        hintText: '패스워드',
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      autovalidateMode: AutovalidateMode.disabled,
      autocorrect: false,
      validator: (_) {
        return !state.isPasswordValid ? 'Invalid Password' : null;
      },
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('안내'),
        content: Text('BrandFarm 로그인에 실패하였습니다.\n 다시 시도해 주시기 바랍니다.'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('확인'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
