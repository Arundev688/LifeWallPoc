



// To parse this JSON data, do
//
//     final productListResponse = productListResponseFromJson(jsonString);

import 'dart:convert';

ProductListResponse productListResponseFromJson(String str) => ProductListResponse.fromJson(json.decode(str));

String productListResponseToJson(ProductListResponse data) => json.encode(data.toJson());

class ProductListResponse {
  ProductListResponse({
    this.jsonrpc,
    this.id,
    this.result,
  });

  String jsonrpc;
  dynamic id;
  Result result;

  factory ProductListResponse.fromJson(Map<String, dynamic> json) => ProductListResponse(
    jsonrpc: json["jsonrpc"],
    id: json["id"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonrpc": jsonrpc,
    "id": id,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.status,
    this.productsList,
  });

  String status;
  List<ProductsList> productsList;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    status: json["status"],
    productsList: List<ProductsList>.from(json["products_list"].map((x) => ProductsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "products_list": List<dynamic>.from(productsList.map((x) => x.toJson())),
  };
}

class ProductsList {
  ProductsList({
    this.id,
    this.name,
    this.defaultCode,
    this.price,
    this.imageBase64,
  });

  int id;
  String name;
  String defaultCode;
  double price;
  String imageBase64;

  factory ProductsList.fromJson(Map<String, dynamic> json) => ProductsList(
    id: json["id"],
    name: json["name"],
    defaultCode: json["default_code"],
    price: json["price"],
    imageBase64: json["image_base64"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "default_code": defaultCode,
    "price": price,
    "image_base64": imageBase64,
  };
}
