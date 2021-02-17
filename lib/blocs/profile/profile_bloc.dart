import 'dart:io';

import 'package:BrandFarm/blocs/profile/profile_event.dart';
import 'package:BrandFarm/blocs/profile/profile_state.dart';
import 'package:BrandFarm/models/profile/profile_model.dart';
import 'package:BrandFarm/repository/profile/profile_repository.dart';
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
      yield* _mapCompletePressedToState();
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
    Profile profile;
    profile = await ProfileRepository().getProfile(uid: UserUtil.getUser().uid);

    yield state.update(
      isLoading: false,
      profile: profile,
    );
  }

  Stream<ProfileState> _mapCompletePressedToState() async* {
    yield state.update(isComplete: true);
  }

  Stream<ProfileState> _mapEditPhoneNumToState({String num}) async* {
    Profile profile;
    profile = Profile(
      email: state.profile.email,
      name: state.profile.name,
      addr: state.profile.addr,
      imgUrl: state.profile.imgUrl,
      phone: num,
      position: state.profile.position,
      profid: state.profile.profid,
      psw: state.profile.psw,
      uid: state.profile.uid,
    );

    await ProfileRepository().updateProfile(profile: profile);

    yield state.update(
      isUploaded: true,
      profile: profile,
    );
  }

  Stream<ProfileState> _mapEditEmailToState({String email}) async* {
    Profile profile;
    profile = Profile(
      email: email,
      name: state.profile.name,
      addr: state.profile.addr,
      imgUrl: state.profile.imgUrl,
      phone: state.profile.phone,
      position: state.profile.position,
      profid: state.profile.profid,
      psw: state.profile.psw,
      uid: state.profile.uid,
    );

    await ProfileRepository().updateProfile(profile: profile);

    yield state.update(
      isUploaded: true,
      profile: profile,
    );
  }

  Stream<ProfileState> _mapEditPasswordToState({String psw}) async* {
    Profile profile;
    profile = Profile(
      email: state.profile.email,
      name: state.profile.name,
      addr: state.profile.addr,
      imgUrl: state.profile.imgUrl,
      phone: state.profile.phone,
      position: state.profile.position,
      profid: state.profile.profid,
      psw: psw,
      uid: state.profile.uid,
    );

    await ProfileRepository().updatePassword(profile: profile);

    yield state.update(
      isUploaded: true,
      profile: profile,
    );
  }

  Stream<ProfileState> _mapResetToState() async* {
    yield state.update(
      isComplete: false,
      isLoading: false,
      isUploaded: false,
    );
  }

  Stream<ProfileState> _mapChangeBackToDefaultImageToState() async* {
    Profile profile;
    profile = Profile(
      email: state.profile.email,
      name: state.profile.name,
      addr: state.profile.addr,
      imgUrl: '',
      phone: state.profile.phone,
      position: state.profile.position,
      profid: state.profile.profid,
      psw: state.profile.psw,
      uid: state.profile.uid,
    );

    await ProfileRepository().updateImage(profile: profile,);

    yield state.update(
      isUploaded: true,
      profile: profile,
    );
  }

  Stream<ProfileState> _mapChangeProfileImageToState({File img}) async* {
    String url = await ProfileRepository().uploadImageToStorage(img, state.profile.profid);

    Profile profile = await Profile(
      email: state.profile.email,
      name: state.profile.name,
      addr: state.profile.addr,
      imgUrl: url,
      phone: state.profile.phone,
      position: state.profile.position,
      profid: state.profile.profid,
      psw: state.profile.psw,
      uid: state.profile.uid,
    );

    await ProfileRepository().updateImage(profile: profile,);

    yield state.update(
      isUploaded: true,
      profile: profile,
    );
  }
}
