import 'dart:convert';
import 'dart:developer' as developer;
import 'package:myapp/model/items.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<HistoryItem>> readHistory() async {
  final prefs = await SharedPreferences.getInstance();
  // prefs.setString('history', '[]');
  // prefs.setString('history',
  //     "[{\"name\":\"apple\",\"image\":\"apple_1.jpg\",\"created\":\"10-10-2021 12:02:03 AM\"},{\"name\":\"dog\",\"image\":\"dog_1.jpg\",\"created\":\"10-10-2020 12:02:03 AM\"},{\"name\":\"cat\",\"image\":\"cat_1.jpg\",\"created\":\"10-10-2020 10:02:03 AM\"}]");
  var content;
  if (prefs.getString('history') != null) {
    content = prefs.getString('history');
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
  developer.log("1");
  final prefs = await SharedPreferences.getInstance();
  developer.log("2");
  final jsonContent = historyItem.toJson();
  developer.log("3");
  var content = prefs.getString('history') ?? "[]";
  developer.log("4");
  developer.log(content);

  final listObj = jsonDecode(content);
  developer.log("5");
  listObj.add(jsonContent);
  developer.log("6");
  prefs.setString('history', jsonEncode(listObj));
  content = prefs.getString('history') ?? "[]";
  developer.log(content);
}





// // class HistoryStorage {
// Future<String> get _localPath async {
//   developer.log("1");
//   final directory = await getApplicationDocumentsDirectory();
//   developer.log("2");
//   return directory.path;
// }

// Future<File> get _localFile async {
//   developer.log("xyzz");

//   final path = await _localPath;
//   developer.log(path);
//   return File('$path/history.json');
// }

// Future<List<HistoryItem>> readHistory() async {
//   developer.log("asasa");
//   final file = await _localFile;
//   developer.log("asasa");

//   // Read the file
//   final String content = await file.readAsString();
//   List<Map<String, dynamic>> listObj = await jsonDecode(content);

//   final List<HistoryItem> listHistory =
//       listObj.map((obj) => HistoryItem.fromJson(obj)).toList();

//   return listHistory;
// }

// Future<void> writeHistory(HistoryItem historyItem) async {
//   final file = await _localFile;
//   Map<String, dynamic> jsonContent = historyItem.toJson();

//   final String content = await file.readAsString();
//   List<Map<String, dynamic>> listObj = await jsonDecode(content);
//   listObj.add(jsonContent);

//   file.writeAsStringSync(jsonEncode(listObj), mode: FileMode.append);
// }
// // }
