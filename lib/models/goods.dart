import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './good.dart';

class Goods with ChangeNotifier {
  List<Good> _items = [];

  List<Good> get items {
    return [..._items];
  }

  Future<void> fetchGoods(int categoryId) {
    final url =
        'https://www.boyclothing.lviv.ua/oba-shop/good-list.php?cat=$categoryId';
    return http.get(url).then((response) {
      final data = json.decode(response.body) as List<dynamic>;

      List<Good> loadedGoods = [];
      data.forEach((elem) {
        final List<String> images = [];
        elem['images'].forEach((img) => images.add(img));

        if (images.length > 0 && images[0].length > 0) {
          loadedGoods.add(Good(
            id: elem['id'],
            code: elem['code'],
            name: elem['name'],
            price: elem['price'].toDouble(),
            images: images,
            present: elem['present'],
            discount: elem['discount'].toDouble(),
            producer: elem['producer'],
            producerId: elem['producerId'],
            season: elem['season'],
            seasonId: elem['seasonId'],
            uniqId: elem['uniqId'],
          ));
        }
      });

      _items = loadedGoods;
      notifyListeners();
      //print('Loading completed');
    }).catchError((error) {
      throw error;
    });
  }
}
