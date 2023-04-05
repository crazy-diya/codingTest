import 'dart:convert';

ItemList itemListFromJson(String str) => ItemList.fromJson(json.decode(str));

String itemListToJson(ItemList data) => json.encode(data.toJson());

class ItemList {
  ItemList({
    this.data,
  });

  List<ItemBean>? data;

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        data:
            List<ItemBean>.from(json["data"].map((x) => ItemBean.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ItemBean {
  ItemBean({
    this.id,
    this.title,
    this.description,
    this.address,
    this.postcode,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    this.image,
  });

  int? id;
  String? title;
  String? description;
  String? address;
  String? postcode;
  String? phoneNumber;
  String? latitude;
  String? longitude;
  Images? image;

  factory ItemBean.fromJson(Map<String, dynamic> json) => ItemBean(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        address: json["address"],
        postcode: json["postcode"],
        phoneNumber: json["phoneNumber"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        image: json["image"] != null ? Images.fromJson(json["image"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "address": address,
        "postcode": postcode,
        "phoneNumber": phoneNumber,
        "latitude": latitude,
        "longitude": longitude,
        "image": image!.toJson(),
      };
}

class Images {
  Images({
    this.small,
    this.medium,
    this.large,
  });

  String? small;
  String? medium;
  String? large;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        small: json["small"],
        medium: json["medium"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "small": small,
        "medium": medium,
        "large": large,
      };
}
