import 'package:flutter/material.dart';

class Utils {
  static void buildErrorHint(ctx, message) {
    Scaffold.of(ctx).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(ctx).accentColor,
    ));
  }
}
