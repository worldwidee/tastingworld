import 'dart:convert';

class Food {
  final int _id;
  final String _name,
      _imageUrl,
      _originCountry,
      _restaurant,
      _description,
      _category;

  int get id => _id;
  String get name => _name;
  String get imageUrl => _imageUrl;
  String get originCountry => _originCountry;
  String get restaurant => _restaurant;
  String get description => _description;
  String get category => _category;
  Food(
      {required int id,
      required String name,
      required String imageUrl,
      required String originCountry,
      required String restaurant,
      required String description,
      required String category})
      : _id = id,
        _name = name,
        _imageUrl = imageUrl,
        _originCountry = originCountry,
        _restaurant = restaurant,
        _description = description,
        _category = category;

  Map<String, String> toMap() {
    return {
      'id': _id.toString(),
      'name': _name,
      'imageUrl': _imageUrl,
      'originCountry': _originCountry,
      'restaurant': _restaurant,
      'description': _description,
      'category': _category
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        imageUrl: map['imageUrl'] ?? '',
        originCountry: map['originCountry'] ?? '',
        restaurant: map['restaurant'] ?? '',
        description: map['description'] ?? '',
        category: map['category'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) => Food.fromMap(json.decode(source));
}
