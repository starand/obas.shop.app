import 'package:flutter/material.dart';

class Category {
  final int id;
  final String title;
  final String image;
  final String uniqId;

  const Category({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.uniqId,
  });
}
