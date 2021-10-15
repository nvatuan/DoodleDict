class HistoryItem {
  late String name;
  late String image;
  late DateTime created;

  get getName => this.name;

  set setName(name) => this.name = name;

  get getImage => this.image;

  set setImage(image) => this.image = image;

  get createdtime => this.created;

  set createdtime(value) => this.created = value;

  HistoryItem(String name, String image, DateTime created) {
    this.name = name;
    this.image = image;
    this.created = created;
  }
}
