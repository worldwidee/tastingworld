import 'package:get/get.dart';

import '../models/food.dart';

class Foods extends GetxController {
  List<Food> _items = [];

  List<Food> get items => _items;

  void setItems(List<Food> items) {
    _items = items;
    update();
  }
}
