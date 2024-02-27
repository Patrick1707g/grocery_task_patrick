import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_task/common/domain/product.dart';


class WishlistRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Soll von Firestore kommen.
  final _tmpProductsList = <Product>[];
  // Temporärer StreamController, um die Produkte zu speichern, bis die Daten
  // aus Firestore kommen.
  final StreamController<List<Product>> _productsController =
      StreamController<List<Product>>();

  Stream<List<Product>> get products {
    return _productsController.stream;
  }

  /*Future<void> addProduct(Product product) async {
    _tmpProductsList.add(product);
    // Neues Event zum StreamController hinzufügen, damit dieses ausgegeben wird.
    _productsController.add(_tmpProductsList);
  }

  Future<void> removeProduct(Product product) async {
    _tmpProductsList.remove(product);
    // Neues Event zum StreamController hinzufügen, damit dieses ausgegeben wird.
    _productsController.add(_tmpProductsList);
  }*/
  Future<void> addProduct(Product product) async {
    final CollectionReference<Map<String, dynamic>> wishCollectionRef =
        _firestore.collection("wishlist");
         _tmpProductsList.add(product);
         _productsController.add(_tmpProductsList);
         
    wishCollectionRef.add({
      "name": product.name,
      "description": product.description,
      "price": double.parse(product.price.toString()),
      "imageAsset": product.imageAsset,
      "colorValue": product.colorValue,
    });
  }

  Future<void> removeProduct(Product product) async {
    _tmpProductsList.remove(product);
    // Neues Event zum StreamController hinzufügen, damit dieses ausgegeben wird.
    _productsController.add(_tmpProductsList);
  }
}
