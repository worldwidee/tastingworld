import 'dart:convert';

import 'package:tastingworld/models/user.dart';
import 'package:tastingworld/models/vote.dart';
import 'package:tastingworld/functions/functions.dart' as functions;

import '../functions/functions.dart';

class VoteService {
  static Future<List<Vote>> listAll() async {
    var body = List<Map<String, dynamic>>.from(
        json.decode((await get("/votes")).body));
    print(body);
    return body.map((e) => Vote.fromMap(e)).toList();
  }

  static Future<Vote> getById(String id) async {
    var body =
        Map<String, dynamic>.from(json.decode((await get("/votes/$id")).body));
    return Vote.fromMap(body);
  }

  static Future<Vote> create(Vote vote) async {
    var body = Map<String, dynamic>.from(
        json.decode((await post("/vote", vote.toJson())).body));
    return Vote.fromMap(body);
  }

  static Future<Vote> update(Vote vote) async {
    var body = Map<String, dynamic>.from(
        json.decode((await put("/vote=${vote.id}", vote.toJson())).body));
    return Vote.fromMap(body);
  }

  static Future<bool> delete(String id) async {
    var value = json.decode((await functions.delete("vote/$id")).body) as bool;
    return value;
  }
}
