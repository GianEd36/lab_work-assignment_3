import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> productList = [];

  void doAddNewProductProvider(Product item) {
    productList.add(item);
    notifyListeners();
  }
}
