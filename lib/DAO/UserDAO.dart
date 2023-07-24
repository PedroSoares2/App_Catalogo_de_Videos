import 'package:app_videos/DAO/SystemDAO.dart';
import 'package:sqflite/sqflite.dart';

import '../models/User.dart';

class UserDAO {

  saveUser(User user1) async {
    Database db = await SystemDAO.recoverDataBase();

    Map<String, dynamic> user = {
      "name": user1.name,
      "email": user1.email,
      "password": user1.password
    };

    int id = await db.insert("user", user);
    print("Usario inserido: $id");

  }

  Future<User?> getUserByUsernameAndPassword(String username, String password) async {
    Database db = await SystemDAO.recoverDataBase();

    print(username);
    print(password);


    List<Map<String, dynamic>> result = await db.query(
      "user",
      where: "name = ? AND password = ?",
      whereArgs: [username, password],
      limit: 1,
    );

    if (result.isNotEmpty) {
      Map<String, dynamic> userMap = result.first;

      User user = User(
        userMap["id"],
        userMap["name"],
        userMap["email"],
        userMap["password"],
      );

      return user;
    }

    return null;
  }

  Future<User?> getUserById(int id) async {
    Database db = await SystemDAO.recoverDataBase();

    List<Map<String, dynamic>> result = await db.query(
      "user",
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );

    if (result.isNotEmpty) {
      Map<String, dynamic> userMap = result.first;

      User user = User(
        userMap["id"],
        userMap["name"],
        userMap["email"],
        userMap["password"],
      );

      return user;
    }

    return null;
  }

  _deleteById(int id) async {
    Database db = await SystemDAO.recoverDataBase();

    int response = await db.delete(
      "user",
      where: "id=?",
      whereArgs: [id],
    );
  }

}