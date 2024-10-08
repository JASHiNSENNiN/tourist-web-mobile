import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/user.dart';

class UserProvider extends ChangeNotifier{
  User _user = User(
    id: '', 
    name: '', 
    email: '', 
    password: '', 
    role: '', 
    token: ''
  );

  User get user => _user;

  void setUser(String user){
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}