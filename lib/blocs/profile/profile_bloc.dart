import 'dart:io';

import 'package:BrandFarm/blocs/profile/profile_event.dart';
import 'package:BrandFarm/blocs/profile/profile_state.dart';
import 'package:BrandFarm/models/user/user_model.dart';
import 'package:BrandFarm/repository/profile/profile_repository.dart';
import 'package:BrandFarm/utils/resize_image.dart';
import 'package:BrandFarm/utils/user/user_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.empty());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfile) {
      yield* _mapLoadProfileToState();
    } else if (event is GetProfile) {
      yield* _mapGetProfileToState();
    } else if (event is CompletePressed) {
      yield* _mapCompletePressedToState(from: event.from);
    } else if (event is EditPhoneNum) {
      yield* _mapEditPhoneNumToState(num: event.num);
    } else if (event is EditEmail) {
      yield* _mapEditEmailToState(email: event.email);
    } else if (event is EditPassword) {
      yield* _mapEditPasswordToState(psw: event.psw);
    } else if (event is Reset) {
      yield* _mapResetToState();
    } else if (event is ChangeBackToDefaultImage) {
      yield* _mapChangeBackToDefaultImageToState();
    } else if (event is ChangeProfileImage) {
      yield* _mapChangeProfileImageToState(img: event.img);
    }
  }

  Stream<ProfileState> _mapLoadProfileToState() async* {
    yield state.update(isLoading: true);
  }

  Stream<ProfileState> _mapGetProfileToState() async* {
    User profile;
    profile = await ProfileRepository().getProfile();

    yield state.update(
      isLoading: false,
      profile: profile,
    );
  }

  Stream<ProfileState> _mapCompletePressedToState({int from}) async* {
    // 1 : image, 2 : phone, 3 : email, 4 : password
    if(from == 1) {
      yield state.update(isImageComplete: true);
    } else if(from == 2) {
      yield state.update(isPhoneComplete: true);
    } else if(from == 3) {
      yield state.update(isEmailComplete: true);
    } else if(from == 4) {
      yield state.update(isPswComplete: true);
    } else {
      print('Wrong Complete Integer');
    }
  }

  Stream<ProfileState> _mapEditPhoneNumToState({String num}) async* {
    User profile;
    profile = User(
      id: state.profile.id,
      fcmToken: state.profile.fcmToken,
      email: state.profile.email,
      name: state.profile.name,
      imgUrl: state.profile.imgUrl,
      phone: num,
      position: state.profile.position,
      psw: state.profile.psw,
      uid: state.profile.uid,
    );

    await UserUtil.setUser(User(
      id: state.profile.id,
      fcmToken: state.profile.fcmToken,
      email: state.profile.email,
      name: state.profile.name,
      imgUrl: state.profile.imgUrl,
      phone: num,
      position: state.profile.position,
      psw: state.profile.psw,
      uid: state.profile.uid,
    ));

    await ProfileRepository().updateProfile();

    yield state.update(
      isUploaded: true,
      profile: profile,
    );
  }

  Stream<ProfileState> _mapEditEmailToState({String email}) async* {
    User profile;
    profile = User(
      id: state.profile.id,
      fcmToken: state.profile.fcmToken,
      email: email,
      name: state.profile.name,
      imgUrl: state.profile.imgUrl,
      phone: state.profile.phone,
      position: state.profile.position,
      psw: state.profile.psw,
      uid: state.profile.uid,
    );

    await UserUtil.setUser(User(
      id: state.profile.id,
      fcmToken: state.profile.fcmToken,
      email: email,
      name: state.profile.name,
      imgUrl: state.profile.imgUrl,
      phone: state.profile.phone,
      position: state.profile.position,
      psw: state.profile.psw,
      uid: state.profile.uid,
    ));

    await ProfileRepository().updateProfile();

    yield state.update(
      isUploaded: true,
      profile: profile,
    );
  }

  Stream<ProfileState> _mapEditPasswordToState({String psw}) async* {
    String prev = await UserUtil.getUser().psw;
    User profile;
    profile = User(
      id: state.profile.id,
      fcmToken: state.profile.fcmToken,
      email: state.profile.email,
      name: state.profile.name,
      imgUrl: state.profile.imgUrl,
      phone: state.profile.phone,
      position: state.profile.position,
      psw: psw,
      uid: state.profile.uid,
    );

    await UserUtil.setUser(User(
      id: state.profile.id,
      fcmToken: state.profile.fcmToken,
      email: state.profile.email,
      name: state.profile.name,
      imgUrl: state.profile.imgUrl,
      phone: state.profile.phone,
      position: state.profile.position,
      psw: psw,
      uid: state.profile.uid,
    ));

    await ProfileRepository().updatePassword(prev: prev);

    yield state.update(
      isUploaded: true,
      profile: profile,
    );
  }

  Stream<ProfileState> _mapResetToState() async* {
    yield state.update(
      isEmailComplete: false,
      isPhoneComplete: false,
      isPswComplete: false,
      isImageComplete: false,
      isLoading: false,
      isUploaded: false,
    );
  }

  Stream<ProfileState> _mapChangeBackToDefaultImageToState() async* {
    User profile;
    profile = User(
      id: state.profile.id,
      fcmToken: state.profile.fcmToken,
      email: state.profile.email,
      name: state.profile.name,
      imgUrl: '',
      phone: state.profile.phone,
      position: state.profile.position,
      psw: state.profile.psw,
      uid: state.profile.uid,
    );

    await UserUtil.setUser(User(
      id: state.profile.id,
      fcmToken: state.profile.fcmToken,
      email: state.profile.email,
      name: state.profile.name,
      imgUrl: '',
      phone: state.profile.phone,
      position: state.profile.position,
      psw: state.profile.psw,
      uid: state.profile.uid,
    ));

    await ProfileRepository().updateImage();

    yield state.update(
      isUploaded: true,
      profile: profile,
    );
  }

  Stream<ProfileState> _mapChangeProfileImageToState({File img}) async* {
    String url = await ProfileRepository()
        .uploadImageToStorage(await resizeImage(img));

    User profile = await User(
      id: state.profile.id,
      fcmToken: state.profile.fcmToken,
      email: state.profile.email,
      name: state.profile.name,
      imgUrl: url,
      phone: state.profile.phone,
      position: state.profile.position,
      psw: state.profile.psw,
      uid: state.profile.uid,
    );

    await UserUtil.setUser(User(
      id: state.profile.id,
      fcmToken: state.profile.fcmToken,
      email: state.profile.email,
      name: state.profile.name,
      imgUrl: url,
      phone: state.profile.phone,
      position: state.profile.position,
      psw: state.profile.psw,
      uid: state.profile.uid,
    ));

    await ProfileRepository().updateImage();

    yield state.update(
      isUploaded: true,
      profile: profile,
    );
  }
}
