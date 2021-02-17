import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ProfileEvent extends Equatable{
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class GetProfile extends ProfileEvent {}

class CompletePressed extends ProfileEvent {}

class Reset extends ProfileEvent {}

class EditPhoneNum extends ProfileEvent {
  final String num;

  const EditPhoneNum({@required this.num});

  @override
  List<Object> get props => [num];

  @override
  String toString() => '''EditPhoneNum { 
    num: $num, 
  }''';
}

class EditEmail extends ProfileEvent {
  final String email;

  const EditEmail({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => '''EditEmail { 
    email: $email, 
  }''';
}

class EditPassword extends ProfileEvent {
  final String psw;

  const EditPassword({@required this.psw});

  @override
  List<Object> get props => [psw];

  @override
  String toString() => '''EditPassword { 
    psw: $psw, 
  }''';
}

class ChangeBackToDefaultImage extends ProfileEvent {}

class ChangeProfileImage extends ProfileEvent {
  final File img;

  const ChangeProfileImage({@required this.img});

  @override
  List<Object> get props => [img];

  @override
  String toString() => '''ChangeProfileImage { 
    img: $img, 
  }''';
}