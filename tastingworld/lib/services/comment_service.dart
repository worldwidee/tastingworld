import 'dart:convert';

import 'package:tastingworld/models/user.dart';
import 'package:tastingworld/models/comment.dart';
import 'package:tastingworld/functions/functions.dart' as functions;

import '../functions/functions.dart';

class CommentService {
  static Future<List<Comment>> listAll() async {
    var body = List<Map<String, dynamic>>.from(
        json.decode((await get("/comments")).body));
    return body.map((e) => Comment.fromMap(e)).toList();
  }

  static Future<Comment> getById(String id) async {
    var body =
        Map<String, dynamic>.from(json.decode((await get("/comments/$id")).body));
    return Comment.fromMap(body);
  }

  static Future<Comment> create(String comment, int userId, int foodId) async {
    var body = Map<String, dynamic>.from(json.decode((await post(
            "/users/$userId/foods/$foodId/comment",
            json.encode({"comment": comment})))
        .body));
    return Comment.fromMap(body);
  }

  static Future<Comment> update(String comment, String commentId) async {
    var body = Map<String, dynamic>.from(json.decode(
        (await put("/comments/$commentId", json.encode({"comment": comment})))
            .body));
    return Comment.fromMap(body);
  }

  static Future<bool> delete(String id) async {
    var value =
        json.decode((await functions.delete("comments/$id")).body) as bool;
    return value;
  }
}
