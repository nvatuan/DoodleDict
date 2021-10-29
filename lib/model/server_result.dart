class ServerResult {
  late Map word;
  late List<dynamic> img;

  ServerResult({required this.word, required this.img});

  ServerResult.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    data['img'] = img;
    return data;
  }
}
