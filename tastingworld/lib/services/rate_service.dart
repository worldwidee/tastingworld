import 'dart:convert';

import 'package:tastingworld/models/user.dart';
import 'package:tastingworld/models/comment.dart';
import 'package:tastingworld/functions/functions.dart' as functions;

import '../functions/functions.dart';
import '../models/rate.dart';

class RateService {
  static Future<List<Rate>> listAll() async {
    var body = List<Map<String, dynamic>>.from(
        json.decode((await get("/rates")).body));
    return body.map((e) => Rate.fromMap(e)).toList();
  }

  static Future<Rate> getById(String id) async {
    var body =
        Map<String, dynamic>.from(json.decode((await get("/rates/$id")).body));
    return Rate.fromMap(body);
  }

  static Future<Rate> create(double rate, int userId, int foodId) async {
    var body = Map<String, dynamic>.from(json.decode((await post(
            "/users/$userId/foods/$foodId/rate",
            json.encode({"rate": rate})))
        .body));
    return Rate.fromMap(body);
  }

  static Future<Rate> update(double rate, String rateId) async {
    var body = Map<String, dynamic>.from(json.decode(
        (await put("/rates/$rateId", json.encode({"rate": rate})))
            .body));
    return Rate.fromMap(body);
  }

  static Future<bool> delete(String id) async {
    var value =
        json.decode((await functions.delete("rates/$id")).body) as bool;
    return value;
  }
}
