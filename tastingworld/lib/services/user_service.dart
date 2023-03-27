import 'dart:convert';

import 'package:tastingworld/models/user.dart';
import 'package:tastingworld/models/comment.dart';
import 'package:tastingworld/functions/functions.dart' as functions;

import '../functions/functions.dart';

class UserService {
  static Future<User> getById(String id) async {
    var body =
        Map<String, dynamic>.from(json.decode((await get("/users/$id")).body));
    return User.fromMap(body);
  }

  static Future<List<Comment>> getCommentsById(String id) async {
    var body = List<Map<String, dynamic>>.from(
        json.decode((await get("/users/$id/comments")).body));
    return body.map((e) => Comment.fromMap(e)).toList();
  }

  static Future<bool> checkIfFoodHasCommentByUser(String id, String foodId) async {
    var body = json.decode((await get("/users/$id/foods/$foodId/isCommentExist")).body) as bool;
    return body;
  }

  static Future<List<Comment>> getUserCommentsOfFood(String id, String foodId) async {
    var body = List<Map<String, dynamic>>.from(
        json.decode((await get("/users/$id/foods/$foodId/comments")).body));
    return body.map((e) => Comment.fromMap(e)).toList();
  }

  static Future<User> create(User user) async {
    var body = Map<String, dynamic>.from(
        json.decode((await post("/user", user.toJson())).body));
    return User.fromMap(body);
  }

  static Future<User> update(User user) async {
    var body = Map<String, dynamic>.from(
        json.decode((await put("/users/${user.id}", user.toJson())).body));
    return User.fromMap(body);
  }

  static Future<bool> delete(String id) async {
    var value = json.decode((await functions.delete("users/$id")).body) as bool;
    return value;
  }
}
