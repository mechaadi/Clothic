class Donation {
  final String name;
  final String address;
  final int cloth_type; // 0 - shirt; 1 - trouser; 2 - shoe; 3 -
  final String user;
  final String image;
  final String id;

  Donation(
      this.name, this.address, this.cloth_type, this.user, this.image, this.id);

  Donation.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        address = json['address'],
        cloth_type = json['cloth_type'],
        image = json['image'],
        user = json['user'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'image': image,
        'cloth_type': cloth_type,
        'user': user,
        'id': id
      };
}
