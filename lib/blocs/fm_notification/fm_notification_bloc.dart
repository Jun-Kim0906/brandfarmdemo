import 'package:BrandFarm/blocs/fm_notification/fm_notification_event.dart';
import 'package:BrandFarm/blocs/fm_notification/fm_notification_state.dart';
import 'package:BrandFarm/models/farm/farm_model.dart';
import 'package:BrandFarm/models/field_model.dart';
import 'package:BrandFarm/models/notification/notification_model.dart';
import 'package:BrandFarm/repository/fm_notification/fm_notification_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FMNotificationBloc
    extends Bloc<FMNotificationEvent, FMNotificationState> {
  FMNotificationBloc() : super(FMNotificationState.empty());

  @override
  Stream<FMNotificationState> mapEventToState(
      FMNotificationEvent event) async* {
    if (event is LoadFMNotification) {
      yield* _mapLoadFMNotificationToState();
    } else if (event is GetFieldList) {
      yield* _mapGetFieldListToState();
    } else if (event is SetField) {
      yield* _mapSetFieldToState(event.field);
    } else if (event is PostNotification) {
      yield* _mapPostNotificationToState(event.obj);
    }
  }

  Stream<FMNotificationState> _mapLoadFMNotificationToState() async* {
    yield state.update(isLoading: true);
  }

  Stream<FMNotificationState> _mapGetFieldListToState() async* {
    Farm farm = await FMNotificationRepository().getFarmInfo();
    List<Field> currFieldList = [
      Field(
          fieldCategory: farm.fieldCategory,
          fid: '',
          sfmid: '',
          lat: '',
          lng: '',
          city: '',
          province: '',
          name: '모든 필드')
    ];
    List<Field> newFieldList =
        await FMNotificationRepository().getFieldList(farm.fieldCategory);
    List<Field> totalFieldList = [
      ...currFieldList,
      ...newFieldList,
    ];

    yield state.update(
      farm: farm,
      fieldList: totalFieldList,
      field: totalFieldList[0],
    );
  }

  Stream<FMNotificationState> _mapSetFieldToState(Field field) async* {
    yield state.update(field: field);
  }

  Stream<FMNotificationState> _mapPostNotificationToState(
      NotificationNotice obj) async* {
    // post notification
    String _notid = '';
    _notid = FirebaseFirestore.instance.collection('Notification').doc().id;
    NotificationNotice _notice = NotificationNotice(
      uid: obj.uid,
      name: obj.name,
      imgUrl: obj.imgUrl,
      fid: obj.fid,
      farmid: obj.farmid,
      title: obj.title,
      content: obj.content,
      postedDate: obj.postedDate,
      scheduledDate: obj.scheduledDate,
      isReadByFM: obj.isReadByFM,
      isReadByOffice: obj.isReadByOffice,
      isReadBySFM: obj.isReadBySFM,
      notid: _notid,
      type: obj.type,
      department: obj.department,
    );

    FMNotificationRepository().postNotification(_notice);

    yield state.update(isLoading: false);
  }
}
