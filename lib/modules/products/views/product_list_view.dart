



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_storage_app/data_models/product_data_model.dart';
import 'package:products_storage_app/modules/products/views/edit_product_view.dart';
import 'package:products_storage_app/services/storage_services/sqlite_database.dart' as product_db;

import 'package:products_storage_app/modules/products/views/products_list_item_view.dart';

class ProductsListView extends StatefulWidget {
  const ProductsListView({Key? key}) : super(key: key);

  @override
  _ProductsListViewState createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {

   List<Product>? products  = [];

  @override
  void initState() {

    super.initState();
    getProducts();

  }

  Future<void> getProducts() async{
    await product_db.createInstance();
    products = await product_db.getAllProducts();
    setState(() {
      print("reset");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text("Products"),

      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: products!.length,itemBuilder: (context, index){
            return ProductsListItemView(product: products![index],);
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  EditProductView(type: EditProductView.ADD_TYPE)),
          );
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}


