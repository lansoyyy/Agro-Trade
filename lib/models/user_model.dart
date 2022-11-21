class UserModel{
  String? uid;
  String? name;
  String? address;
  String? contact;
  String? email;
  String? role;

  UserModel({this.uid, this.name, this.address, this.contact, this.email, this.role});

//receive data from server
  factory UserModel.fromMap(map)
  {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map ['name'],
      address: map ['address'],
      contact: map ['contactnum'],

    );
  }
//sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'address': address,
      'contact': contact,
    };
  }
}