import 'package:flutter/material.dart';
import 'package:loja_flutter_app/common/custom_drawer/custom_drawer.dart';
import 'package:loja_flutter_app/model/page_manager.dart';
import 'package:loja_flutter_app/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => PageManager(pageController),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(title: const Text('Home'), centerTitle: true),
            ),
            ProductsScreen(),
            Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(title: const Text('Home_3'), centerTitle: true),
            ),
            Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(title: const Text('Home_4'), centerTitle: true),
            ),
            //Container(color: Colors.red),
            //Container(color: Colors.yellow),
            //Container(color: Colors.green),
          ],
        ),
    );
  }
}
