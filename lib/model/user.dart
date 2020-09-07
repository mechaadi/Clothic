class User {
  String name;
  String email;
  String address;
  int userType;
  String profilePic;
  String id;

  User(this.name, this.email, this.address, this.userType, this.profilePic,
      this.id);

  User.named(
      {this.name,
      this.email,
      this.address,
      this.userType,
      this.profilePic,
      this.id});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        address = json['address'],
        userType = json['userType'],
        profilePic = json['profilePic'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'address': address,
        'userType': userType,
        'profilePic': profilePic,
        'id': id
      };
}
