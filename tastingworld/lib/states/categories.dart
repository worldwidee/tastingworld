import 'package:get/get.dart';

class Categories extends GetxController {
  List<String> _items = [];

  List<String> get items => _items;

  void setItems(List<String> items) {
    _items = items;
  }
}
