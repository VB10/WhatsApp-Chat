class UserChat {
  String date;
  String image;
  String message;
  String name;

  UserChat({this.date, this.image, this.message, this.name});

  UserChat.fromJson(Map<String, dynamic> json) {
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
}
