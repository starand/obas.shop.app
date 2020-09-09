import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/categories_screen.dart';
import './screens/category_screen.dart';
import './screens/settings_screen.dart';
import './screens/good_screen.dart';
import './screens/shops_map.dart';
import './models/categories.dart';
import './models/goods.dart';
import './helpers/custom_route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Categories>(
          create: (ctx) => Categories(),
        ),
        ChangeNotifierProvider<Goods>(
          create: (ctx) => Goods(),
        ),
      ],
      child: MaterialApp(
        title: 'Oba Brend Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.pink,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                subtitle1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  //fontFamily: 'RobotoCondensed',
                ),
              ),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          }),
        ),
        routes: {
          CategoriesScreen.routeName: (_) => CategoriesScreen(),
          CategoryScreen.routeName: (_) => CategoryScreen(),
          SettingsScreen.routeName: (_) => SettingsScreen(),
          ShopsMap.routeName: (_) => ShopsMap(),
          GoodScreen.routeName: (_) => GoodScreen(),
        },
      ),
    );
  }
}

// SHA1: 0F:A8:BD:16:F8:5A:F1:7C:70:00:9B:C9:10:99:62:00:A0:D5:F5:90
// SHA256: B6:D6:63:06:A6:17:D6:22:97:6C:43:28:9B:4F:8D:27:BA:D6:5D:93:13:00:06:55:C2:83:0C:08:42:41:9D:4C
