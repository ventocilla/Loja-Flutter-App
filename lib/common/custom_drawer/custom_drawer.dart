import 'package:flutter/material.dart';

import 'custom_drawer_header.dart';
import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                const Color.fromARGB(255, 208, 236, 241),
                Colors.grey[300],
              ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          ListView(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                CustomDrawerHeader(),
                const Divider(),
                const DrawerTile(iconData: Icons.home, title: 'Inicio', page: 0),
                const DrawerTile(iconData: Icons.list, title: 'Produtos', page: 1),
                const DrawerTile(iconData: Icons.playlist_add_check, title: 'Meus Pedidos', page: 2),
                const DrawerTile(iconData: Icons.location_on, title: 'Lojas', page: 3),
              ],
          ),
        ],
      ),
    );
  }
}
