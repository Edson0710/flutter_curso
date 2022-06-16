import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  
    String? id;
    String? email;
    String? name;
    String? lastName;
    String? phone;
    String? image;
    String? password;

    User({
        this.id,  //NULL SAFETY
        this.email,
        this.name,
        this.lastName,
        this.phone,
        this.image,
        this.password,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        lastName: json["lastName"],
        phone: json["phone"],
        image: json["image"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "lastName": lastName,
        "phone": phone,
        "image": image,
        "password": password,
    };
}
