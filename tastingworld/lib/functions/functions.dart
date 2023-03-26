import 'package:http/http.dart' as http;

Future<http.Response> get(String path) async {
  var client = http.Client();
  var uri = Uri.http('localhost:8080', path);
  return await client.get(uri);
}

Future<http.Response> put(String path, String json) async {
  var client = http.Client();
  var uri = Uri.http('localhost:8080', path);
  return await client.put(uri,
      body: json, headers: {'Content-Type': 'application/json; charset=UTF-8'});
}

Future<http.Response> post(String path, String json) async {
  var client = http.Client();
  var uri = Uri.http('localhost:8080', path);
  return await client.post(uri,
      body: json, headers: {'Content-Type': 'application/json; charset=UTF-8'});
}

Future<http.Response> delete(String path) async {
  var client = http.Client();
  var uri = Uri.http('localhost:8080', path);
  return await client.delete(uri);
}
