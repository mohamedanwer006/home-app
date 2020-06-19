import 'dart:convert';

Credentials credentialsFromJson(String str) => Credentials.fromMap(json.decode(str));

String credentialsToJson(Credentials data) => json.encode(data.toMap());

///use  model to save user email and password 
///so you can send this data to iot device 

class Credentials {
    String email;
    String password;

    Credentials({
        this.email,
        this.password,
    });

    factory Credentials.fromMap(Map<String, dynamic> json) => Credentials(
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
    );

    Map<String, dynamic> toMap() => {
        "email": email == null ? null : email,
        "password": password == null ? null : password,
    };
}
