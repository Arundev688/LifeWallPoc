


import 'package:flutter/cupertino.dart';
import 'package:lifewallpoc/model/ProductListResponse.dart';
import 'package:lifewallpoc/model/loginresponse.dart';
import 'package:lifewallpoc/service/repo.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
} //used to check network connection

enum DataStatus { Loading, Success, Failed }


class Dataprovider with ChangeNotifier {
  Status _status = Status.Uninitialized;

  LoginResponse loginResponse;
  ProductListResponse productListResponse;

  Future<LoginResponse> getlogin(String name, String password) async {
    _status = Status.Authenticating;
    notifyListeners();

    await Repo().getlogin(name, password).then((data) {
      if (data != null) {
        _status = Status.Authenticated;
        notifyListeners();
      } else {
        _status = Status.Unauthenticated;
      }
      loginResponse = data;
    });
    return loginResponse;
  }


  Future<ProductListResponse> getproduct(String name, String password) async{
    _status = Status.Authenticating;

    await Repo().getProducts(name, password).then((value) {
      if(value != null){
        _status = Status.Authenticated;
        notifyListeners();
      } else {
        _status = Status.Unauthenticated;
      }
      productListResponse = value;
    });
    return productListResponse;
  }


}