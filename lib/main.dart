import 'package:assignment_3/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';

import 'models/product.dart';

void main() {
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        )
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  late Realm realm;
  late RealmResults<Product> items;

  var firstCtrl = TextEditingController();
  var secondCtrl = TextEditingController();
  var thirdCtrl = TextEditingController();
  var fourthCtrl = TextEditingController();

  void loadRealmDB() {
    items = realm.all<Product>();
    //Provider call
  }

  void initStateBootleg() {
    var config = Configuration.local([Product.schema], schemaVersion: 2);
    realm = Realm(config);
    loadRealmDB();
  }

  @override
  Widget build(BuildContext context) {
    initStateBootleg();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('View Products'),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined)),
          IconButton(
              onPressed: () => addNewProduct(context), icon: Icon(Icons.add)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, products, child) {
                return ListView.builder(
                  itemCount: products.count,
                  itemBuilder: (BuildContext context, int index) {
                    var product = products.items[index];
                    return ListTile(
                      leading: Icon(product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_outline),
                      title: Text(product.name),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_cart_outlined)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void addNewProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstCtrl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Code'),
              ),
              Gap(12),
              TextField(
                controller: secondCtrl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
              ),
              Gap(12),
              TextField(
                controller: thirdCtrl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Description'),
              ),
              Gap(12),
              TextField(
                controller: fourthCtrl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Price'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel')),
            ElevatedButton(
                onPressed: () => doAddProductOnRealm(context),
                child: Text('ADD'))
          ],
        );
      },
    );
  }

  void clearControllers() {
    firstCtrl.clear();
    secondCtrl.clear();
    thirdCtrl.clear();
    fourthCtrl.clear();
  }

  void doAddProductOnRealm(BuildContext context) {
    var item = Product(firstCtrl.text, secondCtrl.text, thirdCtrl.text,
        double.tryParse(fourthCtrl.text) ?? 0,
        isFavorite: false);
    //adding in provider
    Provider.of<ProductProvider>(context, listen: false)
        .doAddNewProductProvider(item);
    //utilities
    clearControllers();
    loadRealmDB();
  }
}
