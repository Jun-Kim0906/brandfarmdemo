import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Facility {
  final String fid;
  final String name;
  final double lat;
  final double lng;
  final int gridX;
  final int gridY;
  final int farmKind;
  final String category;
  final String addr;
  final String reg;
  final String updDttm;
  final String uid;
  final int buy;
  final int sell;
  final List<String> jItems;
  final int skyNow;
  final double tempNow;
  final double tempMax;
  final double tempMin;
  final int rainProb;
  final int humidity;
  final int index;
  final bool isAddedArchive;

  ///for expansion
  final bool shipment;
  final bool fertilizer;
  final bool pesticide;
  final bool pest;
  final bool planting;
  final bool seeding;
  final bool weeding;
  final bool watering;
  final bool workforce;
  final bool farming;

  Facility(
      {@required this.fid,
      @required this.name,
      @required this.lat,
      @required this.lng,
      @required this.gridX,
      @required this.gridY,
      @required this.farmKind,
      @required this.category,
      @required this.addr,
      @required this.reg,
      @required this.updDttm,
      @required this.uid,
      @required this.index,
      this.buy,
      this.sell,
      @required this.jItems,
      this.skyNow,
      this.tempNow,
      this.tempMax,
      this.tempMin,
      this.rainProb,
      this.humidity,
      @required this.shipment,
      @required this.fertilizer,
      @required this.pesticide,
      @required this.pest,
      @required this.planting,
      @required this.seeding,
      @required this.weeding,
      @required this.watering,
      @required this.workforce,
      @required this.farming,
      this.isAddedArchive});

  factory Facility.fromDs(DocumentSnapshot ds) {
    return Facility(
      fid: ds['fid'],
      name: ds['name'],
      lat: ds['lat'],
      lng: ds['lng'],
      gridX: ds['gridX'],
      gridY: ds['gridY'],
      index: ds['index'],
      farmKind: ds['farmKind'],
      category: ds['category'],
      addr: ds['addr'],
      reg: ds['reg'],
      updDttm: ds['updDttm'],
      uid: ds['uid'],
      buy: ds['buy'],
      sell: ds['sell'],
      jItems: List.from(ds['jItems']),
      skyNow: ds['skyNow'],
      tempNow: ds['tempNow'],
      tempMax: ds['tempMax'],
      tempMin: ds['tempMin'],
      rainProb: ds['rainProb'],
      humidity: ds['humidity'],
      isAddedArchive: ds['isAddedArchive'],

      ///for expansion
      shipment: ds['shipment'],
      fertilizer: ds['fertilizer'],
      pesticide: ds['pesticide'],
      pest: ds['pest'],
      planting: ds['planting'],
      seeding: ds['seeding'],
      weeding: ds['weeding'],
      watering: ds['watering'],
      workforce: ds['workforce'],
      farming: ds['farming'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fid': fid,
      'name': name,
      'lat': lat,
      'lng': lng,
      'index': index,
      'gridX': gridX,
      'gridY': gridY,
      'farmKind': farmKind,
      'category': category,
      'addr': addr,
      'reg': reg,
      'updDttm': updDttm,
      'jItems': jItems,
      'skyNow': skyNow,
      'tempNow': tempNow,
      'tempMax': tempMax,
      'tempMin': tempMin,
      'rainProb': rainProb,
      'humidity': humidity,
      "isAddedArchive": isAddedArchive,

      ///for expansion
      'shipment': shipment,
      'fertilizer': fertilizer,
      'pesticide': pesticide,
      'pest': pest,
      'planting': planting,
      'seeding': seeding,
      'weeding': weeding,
      'watering': watering,
      'workforce': workforce,
      'farming': farming,
      'jItems': jItems,
    };
  }
}
