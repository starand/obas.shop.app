import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import '../widgets/cached_image.dart';

class GoodScreen extends StatelessWidget {
  static const routeName = '/good';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final title = routeArgs['title'];
    final id = routeArgs['id'];
    final imageUrl = routeArgs['image'];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Hero(
              tag: id,
              child: CachedImage(imageUrl, height: 300),
            ),
          ],
        ),
      ),
    );
  }
}
