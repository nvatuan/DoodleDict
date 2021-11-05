class HistoryItem {
  late String name;
  late String image;
  late String created;
  late List<dynamic> lsImage;
  late Map<dynamic, dynamic> lsWord;

  HistoryItem(
      {required this.name,
      required this.image,
      required this.created,
      required this.lsImage,
      required this.lsWord});

  HistoryItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    created = json['created'];
    lsImage = json['lsImage'];
    lsWord = json['lsWord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['created'] = created;
    data['lsImage'] = lsImage;
    data['lsWord'] = lsWord;
    return data;
  }
}
