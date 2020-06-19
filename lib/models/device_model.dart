import 'dart:convert';

Device deviceFromJson(String str) => Device.fromMap(json.decode(str));

String deviceToJson(Device data) => json.encode(data.toMap());

class Device {
    String id;
    DateTime createdAt;
    DateTime updatedAt;
    String macAddress;
    String tag;
    int version;
    int intensity;
    String value;
    int v;
    String name;
    String email;
    String picture;
    String createdBy;

    Device({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.macAddress,
        this.tag,
        this.version,
        this.intensity,
        this.value,
        this.v,
        this.name,
        this.email,
        this.picture,
        this.createdBy,
    });

    Device copyWith({
        String id,
        DateTime createdAt,
        DateTime updatedAt,
        String macAddress,
        String tag,
        int version,
        int intensity,
        String value,
        int v,
        String name,
        String email,
        String picture,
        String createdBy,
    }) => 
        Device(
            id: id ?? this.id,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            macAddress: macAddress ?? this.macAddress,
            tag: tag ?? this.tag,
            version: version ?? this.version,
            intensity: intensity ?? this.intensity,
            value: value ?? this.value,
            v: v ?? this.v,
            name: name ?? this.name,
            email: email ?? this.email,
            picture: picture ?? this.picture,
            createdBy: createdBy ?? this.createdBy,
        );

    factory Device.fromMap(Map<String, dynamic> json) => Device(
        id: json["_id"] == null ? null : json["_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        macAddress: json["macAddress"] == null ? null : json["macAddress"],
        tag: json["tag"] == null ? null : json["tag"],
        version: json["version"] == null ? null : json["version"],
        intensity: json["intensity"] == null ? null : json["intensity"],
        value: json["value"] == null ? null : json["value"],
        v: json["__v"] == null ? null : json["__v"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        picture: json["picture"] == null ? null : json["picture"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "macAddress": macAddress == null ? null : macAddress,
        "tag": tag == null ? null : tag,
        "version": version == null ? null : version,
        "intensity": intensity == null ? null : intensity,
        "value": value == null ? null : value,
        "__v": v == null ? null : v,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "picture": picture == null ? null : picture,
        "createdBy": createdBy == null ? null : createdBy,
    };
}
