import 'package:flutter/material.dart';
import 'package:loja_flutter_app/common/custom_drawer/custom_drawer.dart';
import 'package:loja_flutter_app/model/product_manager.dart';
import 'package:provider/provider.dart';
import 'compoments/product_list_tile.dart';
import 'compoments/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ProductManager>(builder: (_, productManager,__){
          if(productManager.search.isEmpty){
            return const Text('Products');
          } else {
            return LayoutBuilder(
                builder: (_,constraints){
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(
                          context: context,builder: (_) => SearchDialog(initialText: productManager.search),
                      );
                      if(search != null){
                        productManager.search = search;
                      }
                    },
                    child: Container(
                        width: constraints.biggest.width,
                        child: Text(
                            productManager.search,
                            textAlign: TextAlign.center,
                        ),
                    ),
                  );
                }
            );
          }
          //return const Text('Products'),;
        }),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(
              builder: (_, productManager,__){
                if(productManager.search.isEmpty){
                  return IconButton(icon: Icon(Icons.search), onPressed: () async {
                    final search = await showDialog<String>(
                        context: context,builder: (_) =>
                        SearchDialog(initialText: productManager.search),
                    );
                    if(search != null){
                      productManager.search = search;
                    }
                  });
                } else {
                  return IconButton(icon: Icon(Icons.close), onPressed: () async {
                    productManager.search = '';
                  });
                }
              }),
        ],
      ),
      drawer: CustomDrawer(),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(product: filteredProducts[index]);
            },
          );
        },
      ),
    );
  }
}
