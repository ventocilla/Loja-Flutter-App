import 'package:flutter/material.dart';
import 'package:loja_flutter_app/model/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(product.name), centerTitle: true),
      body: ListView(
        children: <Widget>[
          Image.network(product.images[0]),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(product.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('A partir de', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                ),
                Text('R\$ 19.90',style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: primaryColor)),
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text('Descrição', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                Text(product.description, style: const TextStyle(fontSize: 16),),
                const Text('Tamanhos'),
                SizedBox(
                  height: 44,
                  child: FlatButton(onPressed: (){},
                    child: const Text('Adicionar ao Carrinho'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
