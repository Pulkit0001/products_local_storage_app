

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_storage_app/data_models/product_data_model.dart';
import 'package:products_storage_app/modules/products/views/product_view.dart';

class ProductsListItemView extends StatelessWidget {
  const ProductsListItemView({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: ListTile(
        title: Text(product.name),
        subtitle: Text(product.description),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ProductView(product: product,)),
          );
        },
      ),
    );

  }
}
