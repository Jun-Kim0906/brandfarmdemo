import 'package:BrandFarm/models/profile/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:BrandFarm/utils/todays_date.dart';

class ProfileState {
  bool isLoading;
  bool isComplete;
  bool isUploaded;
  Profile profile;

  ProfileState({
    @required this.isLoading,
    @required this.isComplete,
    @required this.isUploaded,
    @required this.profile,
  });

  factory ProfileState.empty() {
    return ProfileState(
      isLoading: false,
      isComplete: false,
      isUploaded: false,
      profile: Profile(
          email: '--',
        profid: '--',
        name: '--',
        position: 0,
        uid: '--',
        psw: '--',
        imgUrl: '--',
        addr: '--',
        phone: 'xxx-xxxx-xxxx'
      ),
    );
  }

  ProfileState copyWith({
    bool isLoading,
    bool isComplete,
    bool isUploaded,
    Profile profile,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isComplete: isComplete ?? this.isComplete,
      isUploaded: isUploaded ?? this.isUploaded,
      profile: profile ?? this.profile,
    );
  }

  ProfileState update({
    bool isLoading,
    bool isComplete,
    bool isUploaded,
    Profile profile,
  }) {
    return copyWith(
      isLoading: isLoading,
      isComplete: isComplete,
      isUploaded: isUploaded,
      profile: profile,
    );
  }

  @override
  String toString() {
    return '''ProfileState{
    isLoading: $isLoading,
    isComplete: $isComplete,
    isUploaded: $isUploaded,
    profile: $profile,
    }
    ''';
  }
}
