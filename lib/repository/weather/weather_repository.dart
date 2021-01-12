// weather repository

import 'package:BrandFarm/blocs/weather/weather_state.dart';

String getAmPm({String time}) {
  String half_time;
  String tmp;
  String iTime;
  tmp = time.substring(0, 2);
  if (tmp.contains('10')) {
    iTime = tmp;
  } else if (tmp.contains('0')) {
    iTime = tmp.substring(1);
  } else {
    iTime = tmp;
  }
  if (int.parse(iTime) >= 12) {
    half_time = '오후 ';
  } else {
    half_time = '오전 ';
  }
  return half_time;
}

String long_sky_list(
    {String precip_type, String skyType, int index}) {
  // print('$precip_type, $skyType');
  switch (precip_type) {
    case '0':
      {
        if (int.parse(skyType) < 6) {
          return '맑음';
        } else if (int.parse(skyType) > 5  && int.parse(skyType) < 9) {
          return '흐림';
        } else if (int.parse(skyType) > 8) {
          return '구름많음';
        } else {
          print('Unknown sky type');
        }
      }
      break;
    case '1':
    case '2':
    case '4':
    case '5':
    case '6':
      {
        return '비';
      }
      break;
    case '3':
    case '7':
      {
        return '눈';
      }
      break;
    default:
      {
        return '--';
      }
      break;
  }
}

String wind_dir({String dir}) {
  int wDir;
  double tmp1 = double.parse(dir);
  double tmp2 = (tmp1 + 22.5 * 0.5) / 22.5;
  wDir = tmp2.toInt();
  // print(dir);

  switch (wDir) {
    case 0:
      {
        return '북';
      }
      break;
    case 1:
      {
        return '북북동';
      }
      break;
    case 2:
      {
        return '북동';
      }
      break;
    case 3:
      {
        return '동북동';
      }
      break;
    case 4:
      {
        return '동';
      }
      break;
    case 5:
      {
        return '동남동';
      }
      break;
    case 6:
      {
        return '남동';
      }
      break;
    case 7:
      {
        return '남남동';
      }
      break;
    case 8:
      {
        return '남';
      }
      break;
    case 9:
      {
        return '남남서';
      }
      break;
    case 10:
      {
        return '남서';
      }
      break;
    case 11:
      {
        return '서남서';
      }
      break;
    case 12:
      {
        return '서';
      }
      break;
    case 13:
      {
        return '서북서';
      }
      break;
    case 14:
      {
        return '북서';
      }
      break;
    case 15:
      {
        return '북북서';
      }
      break;
    case 16:
      {
        return '북';
      }
      break;
    default:
      {
        return '--';
      }
      break;
  }
}

String regionLandCode ({String region}) {
  switch(region) {
    case '서울' :
    case '인천' :
    case '경기도' : {
      return '11B00000';
    }
    break;
    case '강원도영서' : {
      return '11D10000';
    }
    case '강원도영동' : {
      return '11D20000';
    }
    break;
    case '대전' :
    case '세종' :
    case '충청남도' : {
      return '11C20000';
    }
    break;
    case '충청북도' : {
      return '11C10000';
    }
    break;
    case '광주' :
    case '전라남도' : {
      return '11F20000';
    }
    break;
    case '전라북도' : {
      return '11F10000';
    }
    break;
    case '대구' :
    case '경상북도' : {
      return '11H10000';
    }
    break;
    case '부산' :
    case '울산' :
    case '경상남도' : {
      return '11H20000';
    }
    break;
    case '제주도' : {
      return '11G00000';
    }
    break;
    default : {
      return '--';
    }
    break;
  }
}

String regionCode({String region}) {
  switch (region) {
    case '서울':
      {
        return '11B10101';
      }
      break;
    case '인천':
      {
        return '11B20201';
      }
      break;
    case '수원':
      {
        return '11B20601';
      }
      break;
    case '파주':
      {
        return '11B20305';
      }
      break;
    case '춘천':
      {
        return '11D10301';
      }
      break;
    case '원주':
      {
        return '11D10401';
      }
      break;
    case '강릉':
      {
        return '11D20501';
      }
      break;
    case '대전':
      {
        return '11C20401';
      }
      break;
    case '서산':
      {
        return '11C20101';
      }
      break;
    case '세종':
      {
        return '11C20404';
      }
      break;
    case '서귀포':
      {
        return '11G00401';
      }
      break;
    case '광주':
      {
        return '11F20501';
      }
      break;
    case '목포':
      {
        return '21F20801';
      }
      break;
    case '여수':
      {
        return '11F20401';
      }
      break;
    case '전주':
      {
        return '11F10201';
      }
      break;
    case '군산':
      {
        return '21F10501';
      }
      break;
    case '부산':
      {
        return '11H20201';
      }
      break;
    case '울산':
      {
        return '11H20101';
      }
      break;
    case '창원':
      {
        return '11H20301';
      }
      break;
    case '대구':
      {
        return '11H10701';
      }
      break;
    case '청주':
      {
        return '11C10301';
      }
      break;
    case '제주':
      {
        return '11G00201';
      }
      break;
    case '안동':
      {
        return '11H10501';
      }
      break;
    case '포항':
      {
        return '11H10201';
      }
      break;
    default:
      {
        return '--';
      }
      break;
  }
}
