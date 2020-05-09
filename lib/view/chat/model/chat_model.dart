class ChatModel {
  String date;
  String image;
  String message;
  String name;

  ChatModel({this.date, this.image, this.message, this.name});

  ChatModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    image = json['image'];
    message = json['message'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['image'] = this.image;
    data['message'] = this.message;
    data['name'] = this.name;
    return data;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ChatModel &&
        o.date == date &&
        o.image == image &&
        o.message == message &&
        o.name == name;
  }

  @override
  int get hashCode {
    return date.hashCode ^ image.hashCode ^ message.hashCode ^ name.hashCode;
  }
}
