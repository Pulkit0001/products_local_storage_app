


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_storage_app/common_widgets/custom_button.dart';
import 'package:products_storage_app/modules/products/views/edit_product_view.dart';
import 'package:products_storage_app/modules/products/views/product_list_view.dart';

class DashBoardView extends StatelessWidget {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STORAGE"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          // direction: Axis.vertical,
          // alignment: WrapAlignment.center,
          // runAlignment: WrapAlignment.center,
          children: [
            CustomButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductsListView()),
              );

            },
              label: "Show Products",
            ),
            SizedBox(height: 10,),
            CustomButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  EditProductView(type: EditProductView.ADD_TYPE)),
              );
            },
              label: "Add Product",
            )
          ],
        ),
      ),
    );
  }
}
