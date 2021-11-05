import 'dart:convert';
import 'package:myapp/model/items.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:developer' as developer;

Future<List<HistoryItem>> readHistory() async {
  final prefs = await SharedPreferences.getInstance();
  // prefs.setString('history', '[]');
  // prefs.setString('history',
  //     "[{\"name\":\"apple\",\"image\":\"apple_1.jpg\",\"created\":\"10-10-2021 12:02:03 AM\"},{\"name\":\"dog\",\"image\":\"dog_1.jpg\",\"created\":\"10-10-2020 12:02:03 AM\"},{\"name\":\"cat\",\"image\":\"cat_1.jpg\",\"created\":\"10-10-2020 10:02:03 AM\"}]");
  var content = '';
  if (prefs.getString('history') != null) {
    content = prefs.getString('history')!;
  } else {
    prefs.setString('history', '[]');
    content = '[]';
  }
  final listObj = jsonDecode(content);
  final List<HistoryItem> listHistory = [];
  for (var item in listObj) {
    listHistory.add(HistoryItem.fromJson(item));
  }
  return listHistory;
}

Future<void> writeHistory(HistoryItem historyItem) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonContent = historyItem.toJson();
  var content = prefs.getString('history') ?? "[]";

  final listObj = jsonDecode(content);
  listObj.add(jsonContent);
  prefs.setString('history', jsonEncode(listObj));
  content = prefs.getString('history') ?? "[]";
}
