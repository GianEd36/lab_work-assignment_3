import 'package:realm/realm.dart'; // import realm package

part 'product.realm.dart'; // declare a part file.

@RealmModel()
class _Product {
  late String code;
  late String name;
  late String description;
  late double price;
  late bool isFavorite = false;
}
