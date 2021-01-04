import 'package:brandfarmdemo/layout/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brandfarmdemo/blocs/login/bloc.dart';
import 'package:brandfarmdemo/blocs/authentication/bloc.dart';
import 'package:brandfarmdemo/repository/user/user_repository.dart';
import 'package:brandfarmdemo/widgets/login/login.dart';

class LoginForm extends StatefulWidget {
  // final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        // _userRepository = userRepository,
        super(key: key);

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  // UserRepository get _userRepository => widget._userRepository;

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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.1, height * 0.03, width * 0.1, height * 0.03),
            child: Form(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.289,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.05, bottom: height * 0.01),
                        child: Column(
                          children: [
                            Image.asset('assets/brandfarm.png', height: 30),
                            Text(
                              'Brand Farm',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xff343434),
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              isDesktop?'Desktop':'mobile',
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
//                      icon: Icon(Icons.email),
//                        labelText: 'Email',
                      hintText: '사원번호',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff27D878))),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.disabled,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? '사원번호를 입력하세요' : null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: '패스워드',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff27D878))),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.disabled,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          width: width * 0.772,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: LoginButton(
                              onPressed: isLoginButtonEnabled(state)
                                  ? _onFormSubmitted
                                  : null,
                              isValid: isLoginButtonEnabled(state),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.023,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     SizedBox(
                        //       height: height * 0.036,
                        //       width: width * 0.386,
                        //       child: FittedBox(
                        //           fit: BoxFit.fitWidth,
                        //           child: CreateAccountButton(
                        //               userRepository: _userRepository)),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton(
                              onPressed: () {},
                              child: Text('아이디 찾기'),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text('비밀번호 찾기'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.089,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     SizedBox(
                        //       height: height * 0.043,
                        //       width: width * 0.386,
                        //       child: FittedBox(
                        //           fit: BoxFit.fitWidth,
                        //           child: GoogleLoginButton()),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
