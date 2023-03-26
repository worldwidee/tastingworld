import 'dart:convert';

import 'package:tastingworld/models/user.dart';
import 'package:tastingworld/models/vote.dart';
import 'package:tastingworld/functions/functions.dart' as functions;

import '../functions/functions.dart';

class UserService {
  static Future<User> getById(String id) async {
    var body =
        Map<String, dynamic>.from(json.decode((await get("/users/$id")).body));
    return User.fromMap(body);
  }

  static Future<List<Vote>> getVotesById(String id) async {
    var body = List<Map<String, dynamic>>.from(
        json.decode((await get("/user=$id/votes")).body));
    return body.map((e) => Vote.fromMap(e)).toList();
  }

  static Future<bool> checkIfRated(String id, String foodId) async {
    var body = json.decode((await get("/user=$id/food=$foodId")).body) as bool;
    return body;
  }

  static Future<bool> checkWhatUserRatedAs(String id, String foodId) async {
    var body =
        json.decode((await get("/user=$id/food=$foodId/ratedAs")).body) as bool;
    return body;
  }

  static Future<User> create(User user) async {
    var body = Map<String, dynamic>.from(
        json.decode((await post("/user", user.toJson())).body));
    return User.fromMap(body);
  }

  static Future<User> update(User user) async {
    var body = Map<String, dynamic>.from(
        json.decode((await put("/user=${user.id}", user.toJson())).body));
    return User.fromMap(body);
  }

  static Future<bool> delete(String id) async {
    var value = json.decode((await functions.delete("user/$id")).body) as bool;
    return value;
  }
}
