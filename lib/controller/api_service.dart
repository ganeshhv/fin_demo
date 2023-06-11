import 'dart:convert';

import 'package:fin/model/error_model.dart';
import 'package:fin/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiService{
  static const String URL = 'https://dog.ceo/api/breeds/image/random';

  Future fetchRandomDogImageApi() async {
    final response = await http.get(Uri.parse(URL));

    try{
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['message'];
      }
      else{
        return ErrorModel(errorCode: response.statusCode.toString(), message: "Something Went Wrong!");
      }
    }
    catch(e){
      return ErrorModel(errorCode: "0", message: e.toString());
    }
  }


  Future<User> fetchUserProfileApi() async {
    User user;
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));

    debugPrint('Failed to fetch user profile. Response status code: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    try{
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        user =  User.fromJson(responseData['results'][0]);
      }
      else{
        throw ErrorModel(errorCode: response.statusCode.toString(), message: "Something Went Wrong!");
      }
    }
    catch(e){
      print(e.toString());
      throw Exception([ErrorModel(errorCode: "0", message: e.toString())]);
    }
    return Future.value(user);
  }

}



