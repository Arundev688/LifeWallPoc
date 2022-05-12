

import 'package:lifewallpoc/model/loginresponse.dart';
import 'package:http/http.dart' as http;

class Repo {

  LoginResponse loginResponse;

  String BASE_URL = "lifewall-staging.odoo.com";

  @override
  Future<LoginResponse> getlogin(String name, String password) async {
    String json = '{"login":"$name","password":"$password"}';
    //Response response = await https.post(Uri.parse('https://reqres.in/api/login'),headers: {"Content-type": "application/json"}, body: json);
    var response = await http.post(
        Uri.http(BASE_URL, "/apptech_authenticate"),
        headers: {"Content-type": "application/json"}, body: json);
    print("result"+response.body);
    if (response.statusCode == 200) {
      loginResponse = loginResponseFromJson(response.body);
      return loginResponse;
    } else if (response.statusCode == 400) {
      return loginResponseFromJson(response.body);
    }
  }


}