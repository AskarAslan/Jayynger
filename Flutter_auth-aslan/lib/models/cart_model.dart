import 'package:flutter/material.dart';

class CartModel {
  final int id;
  final String author;
  final String image;
  final String publication_date;
  final String title;
  final String text;
  CartModel({
    @required this.id,
    @required this.author,
    @required this.image,
    @required this.publication_date,
    @required this.title,
    @required this.text,
  });
}

class CartItems with ChangeNotifier {
  Map<String, CartModel> _items = {};

  Map<String, CartModel> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String productId, String title, String text, String publication_date) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
              (existingCartItem) => CartModel(
                  text: existingCartItem.text,
                  title: existingCartItem.title,
                  publication_date: existingCartItem.publication_date.toString()));
    } else {
      _items.putIfAbsent(
          productId,
              () => CartModel(
                  title: title,
                  text: text,
                  publication_date: publication_date.toString()));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }



  void clear() {
    _items = {};
    notifyListeners();
  }
}