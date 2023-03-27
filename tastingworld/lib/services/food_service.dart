import 'dart:convert';

import 'package:tastingworld/functions/functions.dart';
import 'package:tastingworld/functions/functions.dart' as functions;

import '../models/food.dart';

class FoodService {
  static Future<List<Food>> listAll() async {
    var body = List<Map<String, dynamic>>.from(
        json.decode((await get("/foods")).body));
    return body.map((e) => Food.fromMap(e)).toList();
  }

  static Future<List<String>> getCategories() async {
    var body =
        List<String>.from(json.decode((await get("/foods/categories")).body));
    return body;
  }

  static Future<List<Food>> getListByCategory(String category) async {
    var body = List<Map<String, dynamic>>.from(
        json.decode((await get("/foods/category=$category")).body));
    return body.map((e) => Food.fromMap(e)).toList();
  }

  static Future<List<Food>> getListByOriginCountry(String originCountry) async {
    var body = List<Map<String, dynamic>>.from(
        json.decode((await get("/foods/originCountry=$originCountry")).body));
    return body.map((e) => Food.fromMap(e)).toList();
  }

  static Future<Food> getByName(String name) async {
    var body = Map<String, dynamic>.from(
        json.decode((await get("/foods/name=$name")).body));
    return Food.fromMap(body);
  }

  static Future<Food> getById(String id) async {
    var body =
        Map<String, dynamic>.from(json.decode((await get("/foods/$id")).body));
    return Food.fromMap(body);
  }

  static Future<double> getRate(String id) async {
    var body = json.decode((await get("/foods/$id/rate")).body) as double;
    return body;
  }

  static Future<int> getRatedUserCount(String id) async {
    var body =
        json.decode((await get("/foods/$id/ratedUserCount")).body) as int;
    return body;
  }
  static Future<int> getCommentCount(String id) async {
    var body =
        json.decode((await get("/foods/$id/commentCount")).body) as int;
    return body;
  }

  static Future<Food> create(Food food) async {
    var body = Map<String, dynamic>.from(
        json.decode((await post("/food", food.toJson())).body));
    print(body);
    return Food.fromMap(body);
  }

  static Future<Food> update(Food food) async {
    print(food.toJson());
    var body = Map<String, dynamic>.from(
        json.decode((await put("/foods/${food.id}", food.toJson())).body));
    print(body);
    return Food.fromMap(body);
  }

  static Future<bool> delete(String id) async {
    var value = json.decode((await functions.delete("foods/$id")).body) as bool;
    return value;
  }
}
