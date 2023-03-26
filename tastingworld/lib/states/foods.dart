import 'package:get/get.dart';

class Foods extends GetxController {
  List<Foods> _items = [];

  List<Foods> get items => _items;

  void setItems(List<Foods> items) {
    _items = items;
    update();
  }
}
