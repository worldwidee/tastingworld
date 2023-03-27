import 'dart:convert';

import 'package:tastingworld/models/user.dart';

import 'food.dart';

class Rate {
  final int _id;
  final int _userId;
  final int _foodId;
  final double _rate;
  final DateTime _createdAt;
  final DateTime _updatedAt;

  int get id => _id;
  int get userId => _userId;
  int get foodId => _foodId;
  double get rate => _rate;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  Rate({
    required int id,
    required int userId,
    required int foodId,
    required double rate,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : _id = id,
        _userId = userId,
        _foodId = foodId,
        _rate = rate,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  Map<String, dynamic> toMap() {
    return {
      'rate': _rate,
    };
  }

  factory Rate.fromMap(Map<String, dynamic> map) {
    return Rate(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId']!,
      foodId: map['foodId']!,
      rate: map['rate']!,
      createdAt: map['createdAt']!,
      updatedAt: map['updatedAt']!,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rate.fromJson(String source) => Rate.fromMap(json.decode(source));
}
