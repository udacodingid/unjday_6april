import 'package:flutter/material.dart';
import 'package:unjday_6april/model/model_user.dart';
import 'package:http/http.dart' as http;

class NetworkProvider{
  Future<ModelUser> getDataUser() async{
    final response = await http.get(Uri.parse('https://reqres.in/api/users'));
    ModelUser getUsers = modelUserFromJson(response.body);
    return getUsers;

  }
}