import 'package:flutter/material.dart';
import 'package:instagram_flutter/model/user.dart';
import 'package:instagram_flutter/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get getUser => _user!;
  final AuthMethod _authMethod = AuthMethod();

  Future<void> refreshUser() async {
    UserModel user = await _authMethod.getUserdetail();
    _user = user;
    notifyListeners();
  }
}
