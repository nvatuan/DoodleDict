import 'package:intl/intl.dart';

class HistoryItem {
  late String name;
  late String image;
  late String created;

  HistoryItem({required this.name, required this.image, required this.created});

  HistoryItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['image'] = image;
    data['created'] = created;
    return data;
  }
}
