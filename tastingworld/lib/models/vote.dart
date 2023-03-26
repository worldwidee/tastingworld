import 'dart:convert';

import 'package:tastingworld/models/user.dart';

import 'food.dart';

class Vote {
  final int _id;
  final User _user;
  final Food _food;
  final bool _rate;

  int get id => _id;
  bool get rate => _rate;
  User get user => _user;
  Food get food => _food;

  Vote({
    required int id,
    required User user,
    required Food food,
    required bool rate,
  })  : _id = id,
        _user = user,
        _food = food,
        _rate = rate;

  Map<String, dynamic> toMap() {
    return {
      'id': _id.toString(),
      'user': _user.toMap(),
      'food': _food.toMap(),
      'rate': _rate,
    };
  }

  factory Vote.fromMap(Map<String, dynamic> map) {
    return Vote(
      id: map['id']?.toInt() ?? 0,
      user: User.fromMap(map['user']),
      food: Food.fromMap(map['food']),
      rate: map['rate'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vote.fromJson(String source) => Vote.fromMap(json.decode(source));
}
