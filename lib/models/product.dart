import 'package:realm/realm.dart'; // import realm package

part 'product.realm.dart'; // declare a part file.

@RealmModel()
class _Product {
  late int code;
  late String name;
  late String description;
  late double price;
  bool? isFavorite = false;
}
