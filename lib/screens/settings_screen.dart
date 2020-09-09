import 'package:flutter/material.dart';
import 'package:oba_app/widgets/main_drawer.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Налаштування'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}
