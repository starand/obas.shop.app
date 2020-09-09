import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildListTile(String title, IconData data, Function tapHandler) {
    return ListTile(
      leading: Icon(
        data,
        size: 26,
        color: Colors.pink,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 20,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Divider(
            height: 20,
          ),
          Container(
            height: 60,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.purpleAccent,
            child: Text(
              'Oba Brend Menu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildListTile(
            'Каталог',
            Icons.list_rounded,
            () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          _buildListTile(
            'Список бажань',
            Icons.favorite_border,
            () {},
          ),
          _buildListTile(
            'Наші магазини',
            Icons.map_outlined,
            () => Navigator.of(context).pushReplacementNamed('/shops-map'),
          ),
          _buildListTile(
            'Налаштування',
            Icons.settings,
            () => Navigator.of(context).pushReplacementNamed('/settings'),
          ),
        ],
      ),
    );
  }
}
