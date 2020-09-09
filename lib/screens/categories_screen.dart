import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/categories.dart';
import '../widgets/category_item.dart';
import '../widgets/main_drawer.dart';
import '../utils.dart';

import '../models/auth_service.dart' show AuthService;

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool _isLoading = false;

  Future<void> _refreshCategories(BuildContext ctx) async {
    AuthService.getIdToken();
    //print('Refreshing categories..');
    try {
      _isLoading = true;
      await Provider.of<Categories>(context, listen: false).fetchCategories();
    } catch (error) {
      print(error);
      Utils.buildErrorHint(ctx, 'Network error!');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) => _refreshCategories(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Oba Brend Shop',
        ),
      ),
      drawer: MainDrawer(),
      body: Consumer<Categories>(
        builder: (ctx, categories, child) => RefreshIndicator(
          onRefresh: () => _refreshCategories(ctx),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  padding: const EdgeInsets.all(10),
                  children: categories.items
                      .map((data) =>
                          CategoryItem(data.title, data.id, data.image))
                      .toList(),
                ),
        ),
      ),
    );
  }
}
