// To parse this JSON data, do
//
//     final urun = urunFromMap(jsonString);

import 'dart:convert';

Urun urunFromMap(String str) => Urun.fromMap(json.decode(str));

String urunToMap(Urun data) => json.encode(data.toMap());

class Urun {
  Urun({
    required this.itemGroupId,
    required this.id,
    required this.storeCode,
    required this.pickupMethod,
    required this.pickupSla,
    required this.title,
    required this.description,
    required this.link,
    required this.imageLink,
    required this.additionalImageLink,
    required this.brand,
    required this.gender,
    required this.color,
    required this.ageGroup,
    required this.size,
    required this.quantity,
    required this.sizeSystem,
    required this.condition,
    required this.availability,
    required this.price,
    required this.shipping,
    required this.service,
    required this.googleProductCategory,
  });

  final String itemGroupId;
  final String id;
  final String storeCode;
  final String pickupMethod;
  final String pickupSla;
  final String title;
  final String description;
  final String link;
  final String imageLink;
  final List<String> additionalImageLink;
  final String brand;
  final String gender;
  final String color;
  final String ageGroup;
  final String size;
  final int quantity;
  final String sizeSystem;
  final String condition;
  final String availability;
  final String price;
  final Shipping shipping;
  final String service;
  final int googleProductCategory;

  factory Urun.fromMap(Map<String, dynamic> json) => Urun(
        itemGroupId: json["item_group_id"],
        id: json["id"],
        storeCode: json["store_code"],
        pickupMethod: json["pickup_method"],
        pickupSla: json["pickup_sla"],
        title: json["title"],
        description: json["description"],
        link: json["link"],
        imageLink: json["image_link"],
        additionalImageLink:
            List<String>.from(json["additional_image_link"].map((x) => x)),
        brand: json["brand"],
        gender: json["gender"],
        color: json["color"],
        ageGroup: json["age_group"],
        size: json["size"],
        quantity: json["quantity"],
        sizeSystem: json["size_system"],
        condition: json["condition"],
        availability: json["availability"],
        price: json["price"],
        shipping: Shipping.fromMap(json["shipping"]),
        service: json["service"],
        googleProductCategory: json["google_product_category"],
      );

  Map<String, dynamic> toMap() => {
        "item_group_id": itemGroupId,
        "id": id,
        "store_code": storeCode,
        "pickup_method": pickupMethod,
        "pickup_sla": pickupSla,
        "title": title,
        "description": description,
        "link": link,
        "image_link": imageLink,
        "additional_image_link":
            List<dynamic>.from(additionalImageLink.map((x) => x)),
        "brand": brand,
        "gender": gender,
        "color": color,
        "age_group": ageGroup,
        "size": size,
        "quantity": quantity,
        "size_system": sizeSystem,
        "condition": condition,
        "availability": availability,
        "price": price,
        "shipping": shipping.toMap(),
        "service": service,
        "google_product_category": googleProductCategory,
      };
}

class Shipping {
  Shipping({
    required this.country,
    required this.service,
    required this.price,
  });

  final String country;
  final String service;
  final String price;

  factory Shipping.fromMap(Map<String, dynamic> json) => Shipping(
        country: json["country"],
        service: json["service"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "country": country,
        "service": service,
        "price": price,
      };
}
