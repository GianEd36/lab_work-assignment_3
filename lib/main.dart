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
        ChangeNotifierProvider(create: (context) => ProductProvider(),)
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

  void loadRealmDB() {
    items = realm.all<Product>();
    //Provider call
  }

  void initStateBootleg() {
    var config = Configuration.local([Product.schema]);
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
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              var item = items[index];
              return ListTile(
                leading: Icon(item.isFavorite ? Icons.favorite_outline : Icons.favorite) ,
                title: Text(item.name),
              );
            },
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
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Code'),
              ),
              Gap(12),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
              ),
              Gap(12),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Description'),
              ),
              Gap(12),
              TextField(
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
            ElevatedButton(onPressed: () {}, child: Text('ADD'))
          ],
        );
      },
    );
  }
}
