class History {
  String? title;
  String? content;
  String? time;
  History({
    this.title,
    this.content,
    this.time,
  });

  History.fromJson(dynamic json)
      : title = json['title'],
        content = json['content'],
        time = json['time'];

  Map toJson() {
    Map map = {};
    map['title'] = title;
    map['content'] = content;
    map['time'] = time;
    return map;
  }
}
