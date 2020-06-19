import 'dart:convert';

User userFromJson(String str) => User.fromMap(json.decode(str));

String userToJson(User data) => json.encode(data.toMap());

class User {
    String id;
    int index;
    bool isActive;
    String picture;
    String name;
    String email;
    String phone;
    String address;
    String registered;
    int devices;

    User({
        this.id,
        this.index,
        this.isActive,
        this.picture,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.registered,
        this.devices,
    });

    User copyWith({
        String id,
        int index,
        bool isActive,
        String picture,
        String name,
        String email,
        String phone,
        String address,
        String registered,
        int devices,
    }) => 
        User(
            id: id ?? this.id,
            index: index ?? this.index,
            isActive: isActive ?? this.isActive,
            picture: picture ?? this.picture,
            name: name ?? this.name,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            address: address ?? this.address,
            registered: registered ?? this.registered,
            devices: devices ?? this.devices,
        );

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        index: json["index"],
        isActive: json["isActive"],
        picture: json["picture"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        registered: json["registered"],
        devices: json["devices"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "index": index,
        "isActive": isActive,
        "picture": picture,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "registered": registered,
        "devices": devices,
    };
}
