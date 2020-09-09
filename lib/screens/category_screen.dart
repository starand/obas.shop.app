import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../widgets/good_item.dart';
import '../models/goods.dart';
import '../utils.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/category';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var _isLoading = false;

  Future<void> _refreshGoods(BuildContext ctx) async {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final categoryId = routeArgs['id'] as int;
    print('Refreshing category #$categoryId..');

    try {
      _isLoading = true;
      await Provider.of<Goods>(ctx, listen: false).fetchGoods(categoryId);
    } catch (error) {
      Utils.buildErrorHint(ctx, 'Network error!');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) => _refreshGoods(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final title = routeArgs['title'];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(),
      body: Consumer<Goods>(
        builder: (ctx, goods, child) => _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => _refreshGoods(ctx),
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (ctx, idx) {
                    final elem = goods.items[idx];
                    return GoodItem(
                      key: ValueKey(elem.id),
                      title: elem.name,
                      goodId: elem.id,
                      imageUrl: elem.images[0],
                    );
                  },
                  itemCount: goods.items.length,
                ),
              ),
      ),
    );
  }
}
