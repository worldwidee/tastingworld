import 'dart:convert';

import 'comment.dart';

class Food {
  final int _id;
  final String _name,
      _imageUrl,
      _originCountry,
      _restaurant,
      _description,
      _category;
  List<Comment> comments = [];
  String? _rate;
  int? _rateCount;
  int get id => _id;
  String get name => _name;
  String get imageUrl => _imageUrl;
  String get originCountry => _originCountry;
  String get restaurant => _restaurant;
  String get description => _description;
  String get category => _category;
  String? get rate => _rate;
  int? get rateCount => _rateCount;
  Food({
    required int id,
    required String name,
    required String imageUrl,
    required String originCountry,
    required String restaurant,
    required String description,
    required String category,
    required List<Comment> comments,
    required String? rate,
    required int? rateCount,
  })  : _id = id,
        _name = name,
        _imageUrl = imageUrl,
        _originCountry = originCountry,
        _restaurant = restaurant,
        _description = description,
        _category = category,
        _rate = rate,
        _rateCount = rateCount;

  Map<String, String> toMap() {
    return {
      'name': _name,
      'imageUrl': _imageUrl,
      'originCountry': _originCountry,
      'restaurant': _restaurant,
      'description': _description,
      'category': _category
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    List<Comment> comments = [];
    if (map['comments'] != null && map['comments'] is List) {
      List<dynamic> list = map['comments'] as List<dynamic>;
      comments = list.map((e) => Comment.fromMap(e)).toList();
    }
    return Food(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      originCountry: map['originCountry'] ?? '',
      restaurant: map['restaurant'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      comments: comments,
      rate: map['avarageRate'],
      rateCount: map['rateCount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) => Food.fromMap(json.decode(source));
}
