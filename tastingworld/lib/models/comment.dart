import 'dart:convert';

import 'package:tastingworld/models/user.dart';

import 'food.dart';

class Comment {
  final int _id;
  final int _userId;
  final int _foodId;
  final String _comment;
  final DateTime _createdAt;
  final DateTime _updatedAt;
  final String? _username,_name,_surname;

  int get id => _id;
  int get userId => _userId;
  int get foodId => _foodId;
  String get comment => _comment;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;
  String? get username => _username;
  String? get name => _name;
  String? get surname => _surname;

  Comment({
    required int id,
    required int userId,
    required int foodId,
    required String comment,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String? username,
    required String? name,
    required String? surname,
  })  : _id = id,
        _userId = userId,
        _foodId = foodId,
        _comment = comment,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _username = username,
        _name = name,
        _surname = surname;

  Map<String, dynamic> toMap() {
    return {
      'comment': _comment,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId']!,
      foodId: map['foodId']!,
      comment: map['comment']!,
      createdAt: map['createdAt']!,
      updatedAt: map['updatedAt']!,
      username: map['username'],
      name: map['name'],
      surname: map['surname'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source));
}
