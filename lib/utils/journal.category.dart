import 'package:meta/meta.dart';

const List<Map<String, dynamic>> accountCategory = [
  {"id": 0, "name": "파종/정식", "type": 0},
  {"id": 1, "name": "고용노력비", "type": 0},
  {"id": 2, "name": "비료비", "type": 0},
  {"id": 3, "name": "광열동력비", "type": 0},
  {"id": 4, "name": "소농구비", "type": 0},
  {"id": 5, "name": "소모품비", "type": 0},
  {"id": 6, "name": "수리비", "type": 0},
  {"id": 7, "name": "자재/부품비", "type": 0},
  {"id": 8, "name": "임차료", "type": 0},
  {"id": 9, "name": "수확판매", "type": 1},
  {"id": 99, "name": "기타", "type": 99}
];

const List<Map<String, dynamic>> journalCategory = [
  {
    "id": 0,
    "name": "출하정보",
  },
  {
    "id": 1,
    "name": "비료정보",
  },
  {
    "id": 2,
    "name": "농약정보",
  },
  {
    "id": 3,
    "name": "병,해충정보",
  },
  {
    "id": 4,
    "name": "정식정보",
  },
  {
    "id": 5,
    "name": "파종정보",
  },
  {
    "id": 6,
    "name": "제초정보",
  },
  {
    "id": 7,
    "name": "관수정보",
  },
  {
    "id": 8,
    "name": "인력투입정보",
  },
  {
    "id": 9,
    "name": "경운정보",
  },
];

String getAccountCategoryName({@required id}) {
  return accountCategory.where((Map<String, dynamic> item) {
    return item['id'] == id;
  }).elementAt(0)["name"];
}

int getJournalCategoryId({@required name}) {
  return journalCategory.where((Map<String, dynamic> item) {
    return item['name'] == name;
  }).elementAt(0)["id"];
}

String getJournalCategoryName({@required id}) {
  return journalCategory.where((Map<String, dynamic> item) {
    return item['id'] == id;
  }).elementAt(0)["name"];
}