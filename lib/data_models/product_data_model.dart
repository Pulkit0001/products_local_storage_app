
import 'dart:convert';

class Product {
  Product({
     this.id,
    required this.name,
    required this.price,
    required this.salePrice,
    required this.description,
    required this.colors,
    required this.stores,
    required this.picture
  });

  int? id;
  String name;
  int price;
  int salePrice;
  String description;
  List<String> colors;
  List<Store> stores;
  String picture;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> data) {
    final String colorsStr = data["colors"].substring(1, data["colors"].length-1);
    var colorsList = colorsStr.split(", ");
    final String storeStr = data["stores"].substring(1, data["stores"].length-1);
    var storesList = storeStr.split(", ");

    return Product(
      id: data["id"],
      name: data["name"],
      price: data["price"],
      salePrice: data["sale_price"],
      description: data["description"],
      colors: List<String>.from(colorsList.map((x) => x)),
      stores: List<Store>.from(
          storesList.map((x) => Store.fromRawJson(x))),
      picture: data['picture'],
    );
  }

    Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "price": price,
      "sale_price": salePrice,
      "description": description,
      "colors": List<dynamic>.from(colors.map((x) => x)).toString(),
      "stores": List<dynamic>.from(stores.map((x) => x.toRawJson())).toString(),
      "picture": picture
    };

}

class Store {
  Store({
    required this.address,
  });

  String address;

  factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
  };
}
