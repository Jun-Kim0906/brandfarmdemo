import 'dart:async';
import 'package:BrandFarm/models/field_model.dart';
import 'package:BrandFarm/models/user/user_model.dart';
import 'package:BrandFarm/utils/feild_util.dart';
import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:BrandFarm/repository/user/user_repository.dart';

part 'authentication_state.dart';
part 'authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository, super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
     // final name = (await _userRepository.getUser()).email;
      yield* _mapAuthenticationLoggedInToState();
    } else {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
//    yield AuthenticationSuccess((await _userRepository.getUser()).email);
    try {
      UserUtil.setUser(User.fromSnapshot(await FirebaseFirestore.instance
          .collection('User')
          .doc((await UserRepository().getUser()).uid)
          .get()));
      QuerySnapshot fieldList = await FirebaseFirestore.instance
          .collection('Field')
          .where('sfmid', isEqualTo: (await UserRepository().getUser()).uid).get();
      FieldUtil.setField(Field.fromSnapshot(fieldList.docs.first));
      print('Login User Field ID : ' + FieldUtil.getField().fid);
      print('Login User Name : ' + UserUtil.getUser().name);
      yield AuthenticationSuccess(UserUtil.getUser().name);
      // yield AuthenticationSuccess('Username');
    } catch (e) {
      print(e);
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    yield AuthenticationFailure();
    _userRepository.signOut();
  }
}
