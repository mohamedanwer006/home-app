import 'dart:convert';

Collection collectionFromJson(String str) => Collection.fromMap(json.decode(str));

String collectionToJson(Collection data) => json.encode(data.toMap());

class Collection {
    String id;
    DateTime createdAt;
    DateTime updatedAt;
    String name;
    int v;
    String picture;
    List<String> devices;
    String createdBy;

    Collection({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.v,
        this.picture,
        this.devices,
        this.createdBy,
    });

    Collection copyWith({
        String id,
        DateTime createdAt,
        DateTime updatedAt,
        String name,
        int v,
        String picture,
        List<String> devices,
        String createdBy,
    }) => 
        Collection(
            id: id ?? this.id,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            name: name ?? this.name,
            v: v ?? this.v,
            picture: picture ?? this.picture,
            devices: devices ?? this.devices,
            createdBy: createdBy ?? this.createdBy,
        );

    factory Collection.fromMap(Map<String, dynamic> json) => Collection(
        id: json["_id"] == null ? null : json["_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        name: json["name"] == null ? null : json["name"],
        v: json["__v"] == null ? null : json["__v"],
        picture: json["picture"] == null ? null : json["picture"],
        devices: json["devices"] == null ? null : List<String>.from(json["devices"].map((x) => x)),
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "name": name == null ? null : name,
        "__v": v == null ? null : v,
        "picture": picture == null ? null : picture,
        "devices": devices == null ? null : List<dynamic>.from(devices.map((x) => x)),
        "createdBy": createdBy == null ? null : createdBy,
    };
}


// collection
// 5e93e11b8d70440004aaa8f3
//devices
// 5e922ff9cbb28432f45c4d7d
// 5e9124c9d80c373888e048ba
// 5e93e2198d70440004aaa8f6
