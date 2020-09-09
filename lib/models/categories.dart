import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'category.dart';

class Categories with ChangeNotifier {
  List<Category> _items = [];

  List<Category> get items {
    return [..._items];
  }

  void addCategory() {
    //_items.add()
    notifyListeners();
  }

  Future<void> fetchCategories() {
    const url = 'https://www.boyclothing.lviv.ua/oba-shop/category-list.php';

    return http.get(url).then((response) {
      final data = json.decode(response.body) as List<dynamic>;
      final List<Category> loadedCategories = [];

      data.forEach((elem) {
        loadedCategories.add(Category(
          id: elem['id'],
          title: elem['name'],
          image: elem['image'],
          uniqId: elem['uniqId'],
        ));
      });

      _items = loadedCategories;
      notifyListeners();
      print('[+] Categories updated');
    }).catchError((error) {
      throw error;
    });
  }
}
