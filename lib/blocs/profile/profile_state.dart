import 'package:BrandFarm/models/user/user_model.dart';
import 'package:flutter/foundation.dart';

class ProfileState {
  bool isLoading;
  bool isEmailComplete;
  bool isPhoneComplete;
  bool isPswComplete;
  bool isImageComplete;
  bool isUploaded;
  User profile;

  ProfileState({
    @required this.isLoading,
    @required this.isEmailComplete,
    @required this.isPhoneComplete,
    @required this.isPswComplete,
    @required this.isImageComplete,
    @required this.isUploaded,
    @required this.profile,
  });

  factory ProfileState.empty() {
    return ProfileState(
      isLoading: false,
      isEmailComplete: false,
      isPhoneComplete: false,
      isPswComplete: false,
      isImageComplete: false,
      isUploaded: false,
      profile: User(
        id: '--',
        fcmToken: '--',
          email: '--',
        name: '--',
        position: 0,
        uid: '--',
        psw: '--',
        imgUrl: '--',
        phone: 'xxx-xxxx-xxxx'
      ),
    );
  }

  ProfileState copyWith({
    bool isLoading,
    bool isEmailComplete,
    bool isPhoneComplete,
    bool isPswComplete,
    bool isImageComplete,
    bool isUploaded,
    User profile,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isEmailComplete: isEmailComplete ?? this.isEmailComplete,
      isPhoneComplete: isPhoneComplete ?? this.isPhoneComplete,
      isPswComplete: isPswComplete ?? this.isPswComplete,
      isImageComplete: isImageComplete ?? this.isImageComplete,
      isUploaded: isUploaded ?? this.isUploaded,
      profile: profile ?? this.profile,
    );
  }

  ProfileState update({
    bool isLoading,
    bool isEmailComplete,
    bool isPhoneComplete,
    bool isPswComplete,
    bool isImageComplete,
    bool isUploaded,
    User profile,
  }) {
    return copyWith(
      isLoading: isLoading,
      isEmailComplete: isEmailComplete,
      isPhoneComplete: isPhoneComplete,
      isPswComplete: isPswComplete,
      isImageComplete: isImageComplete,
      isUploaded: isUploaded,
      profile: profile,
    );
  }

  @override
  String toString() {
    return '''ProfileState{
    isLoading: $isLoading,
    isEmailComplete: $isEmailComplete,
    isPhoneComplete: $isPhoneComplete,
    isPswComplete: $isPswComplete,
    isImageComplete: $isImageComplete,
    isUploaded: $isUploaded,
    profile: $profile,
    }
    ''';
  }
}
