import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_storage_app/common_widgets/custom_button.dart';
import 'package:products_storage_app/data_models/product_data_model.dart';
import 'package:products_storage_app/modules/products/views/edit_product_view.dart';
import 'package:products_storage_app/services/storage_services/sqlite_database.dart';

import 'detail_image_screen.dart';

class ProductView extends StatelessWidget {
  final Product product;
  const ProductView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailImageScreen(path: '',);
                }));
              },
              child: Hero(
                tag: 'imageHero',
                child: Image.file(
                  File(product.picture),
                ),
              ),
            ),
            Text(
              product.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
            ),
            Text(
              product.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Price",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                Spacer(),
                Text(
                  product.price.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.amber),
                )
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  "Sale Price",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                Spacer(),
                Text(
                  product.salePrice.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.amber),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text("Colors Available",textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),


              ],
            ),
            ListView.builder(
              shrinkWrap: true,
                itemCount: product.colors.length,
                itemBuilder: (context, index){
              return ListTile(title: Text(product.colors[index]),);
            }),
            Row(
              children: [
                Text("Stores Available at", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),

              ],
            ),
            ListView.builder(
              shrinkWrap: true,
                itemCount: product.stores.length,
                itemBuilder: (context, index){
                  return ListTile(title: Text(product.stores[index].address),);
                }),
            Spacer(),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  EditProductView(type: EditProductView.EDIT_TYPE,product: product)),
                    );
                  },
                  label: 'Update',
                )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: CustomButton(
                  onPressed: () async  {

                    await deleteProduct(product.id!);
                    Navigator.pop(context);

                  },
                  label: 'Delete',
                ))
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
