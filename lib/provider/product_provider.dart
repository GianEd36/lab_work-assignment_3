import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  // late Realm realm;
  // late RealmResults<Product> products;

  final List<Product> _productList = [];

  List<Product> get items => _productList;

  int get count {
    return _productList.length;
  }

  void doAddNewProductProvider(Product item) {
    _productList.add(item);
    //adding in realm
    // realm.write(() {
    //   realm.add(item);
    // });
    notifyListeners();
  }
}
