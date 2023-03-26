import 'dart:convert';

class User {
  final int _id;
  final String _username, _password, _name, _surname;

  int get id => _id;
  String get username => _username;
  String get password => _password;
  String get name => _name;
  String get surname => _surname;
  User(
      {required int id,
      required String username,
      required String password,
      required String name,
      required String surname})
      : _id = id,
        _username = username,
        _password = password,
        _name = name,
        _surname = surname;

  Map<String, String> toMap() {
    return {
      'id': _id.toString(),
      'username': _username,
      'password': _password,
      'name': _name,
      'surname': _surname,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id']?.toInt() ?? 0,
        username: map['username'] ?? '',
        password: map['password'] ?? '',
        name: map['name'] ?? '',
        surname: map['surname'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
