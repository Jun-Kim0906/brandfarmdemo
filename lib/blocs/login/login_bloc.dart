import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:BrandFarm/blocs/login/bloc.dart';
import 'package:BrandFarm/repository/user/user_repository.dart';
import 'package:BrandFarm/widgets/validator/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository, super(LoginState.initial());
  
  //
  // @override
  // LoginState get initialState => LoginState.initial();

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> events,
      TransitionFunction<LoginEvent, LoginState> transitionFn,
      ) {
    final nonDebounceStream = events.where((event) {
      return (event is! LoginEmailChanged && event is! LoginPasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is LoginEmailChanged || event is LoginPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChanged) {
      yield* _mapLoginEmailChangedToState(event.email);
    } else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChangedToState(event.password);
    }
    // else if (event is LoginWithGooglePressed) {
    //   yield* _mapLoginWithGooglePressedToState();
    // }
    else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapLoginEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapLoginPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

//   Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
// //    yield LoginState.loading();
//     try {
//       await _userRepository.signInWithGoogle();
//
//       yield LoginState.loading();
//
//       String uid = (await UserRepository().getUser()).uid;
//       String name = (await UserRepository().getUser()).displayName;
//       String email = (await UserRepository().getUser()).email;
//
//       await Firestore.instance.collection("User").document(uid).setData({
//         'email': email,
//         'fcmToken': '',
//         "name": name,
//         "uid": uid,
//       });
//       yield LoginState.success();
//     } catch (_) {
//       yield LoginState.failure();
//     }
//   }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
