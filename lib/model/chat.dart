class Chat {
  String message;
  String time;
  String user;


  Chat(
      this.user, this.message, this.time);

  Chat.named(
      {this.user,
      this.message,
      this.time
      });

  Chat.fromJson(Map<String, dynamic> json)
      : user = json['user'],
        message = json['message'],
        time = json['time'];

  Map<String, dynamic> toJson() => {
        'name': user,
        'address': message,
        'image': time
      };
}
