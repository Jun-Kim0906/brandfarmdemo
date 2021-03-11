import 'package:BrandFarm/models/field_model.dart';
import 'package:BrandFarm/models/notification/notification_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class FMNotificationEvent extends Equatable{
  const FMNotificationEvent();

  @override
  List<Object> get props => [];
}

class LoadFMNotification extends FMNotificationEvent{}

class GetFieldList extends FMNotificationEvent {}

class SetField extends FMNotificationEvent {
  final Field field;

  const SetField({
    @required this.field,
  });

  // @override
  // List<Object> get props => [navTo];

  @override
  String toString() => 'SetField { field : $field}';
}

class PostNotification extends FMNotificationEvent{
  final NotificationNotice obj;

  const PostNotification({
    @required this.obj,
  });

  @override
  String toString() => '''PostNotification { 
    obj: $obj,
  }''';
}