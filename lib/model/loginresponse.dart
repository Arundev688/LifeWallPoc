


// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.jsonrpc,
    this.id,
    this.result,
  });

  String jsonrpc;
  dynamic id;
  Result result;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
  });

  String status;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}
