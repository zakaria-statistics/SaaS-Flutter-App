import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/user_auth/presentation/backend/entities/user_entity.dart';

class LocalStorage {
  static const String _usersKey = 'users';

  Future<void> saveUsers(List<UserEntity> users) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userStrings = users.map((user) => jsonEncode(user.toJson())).toList();
    await prefs.setStringList(_usersKey, userStrings);
  }

  Future<List<UserEntity>> getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userStrings = prefs.getStringList(_usersKey);

    if (userStrings != null) {
      return userStrings.map((userString) => UserEntity.fromJson(jsonDecode(userString))).toList();
    }

    return [];
  }
}
