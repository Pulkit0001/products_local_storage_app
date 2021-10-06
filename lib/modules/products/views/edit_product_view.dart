

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:products_storage_app/common_widgets/custom_button.dart';
import 'package:products_storage_app/common_widgets/custom_input_field.dart';
import 'package:products_storage_app/data_models/product_data_model.dart';
import 'package:products_storage_app/services/storage_services/sqlite_database.dart' as product_db;


class EditProductView extends StatelessWidget {
  static const EDIT_TYPE = "Update";
  static const ADD_TYPE = "Add";
  final String type;
  Product? product;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController storeController = TextEditingController();
  XFile? _storedImage;
  String? newPath = "";
  EditProductView({Key? key, required this.type, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(type == EDIT_TYPE){
      nameController.text = product!.name;
      descriptionController.text = product!.description;
      priceController.text = product!.price.toString();
      salePriceController.text = product!.salePrice.toString();
      storeController.text = product!.stores[0].address;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("$type Product"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  GestureDetector(
                      onTap: (){
                        _takePicture();
                      },
                      child: CircleAvatar(radius: 54,foregroundImage: FileImage(File(newPath!)),)),

                  CustomInputField(label: "Name", controller: nameController),
                  CustomInputField(
                      label: "Description", controller: descriptionController),
                  CustomInputField(keyboardType: TextInputType.number , label: "Price", controller: priceController),
                  CustomInputField(keyboardType: TextInputType.number,
                      label: "Sale Price", controller: salePriceController),
                  CustomInputField(label: "Stores", controller: storeController),
                  Spacer(),
                  CustomButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate())  {
                          final Product p = type == EDIT_TYPE?Product(
                              id: product!.id,
                              name: nameController.text,
                              price: int.parse(priceController.text),
                              salePrice: int.parse(salePriceController.text),
                              description: descriptionController.text,
                              colors: ["Red", "Green", "Golden"],
                              stores: [Store(address: storeController.text)],
                            picture: newPath!
                          ):
                          Product(
                              //id: product!.id,
                              name: nameController.text,
                              price: int.parse(priceController.text),
                              salePrice: int.parse(salePriceController.text),
                              description: descriptionController.text,
                              colors: ["Red", "Green", "Golden"],
                              stores: [Store(address: storeController.text)],
                              picture: newPath!
                          )
                          ;
                          showDialog(context: context, builder: (context) => CircularProgressIndicator());
                          try {
                            await product_db.createInstance();
                            if (type == EDIT_TYPE) {
                              await product_db.updateProduct(p);
                            } else {
                              await product_db.addProduct(p);
                            }
                          }
                          catch(e){
                            print(e.toString());
                          }
                          Navigator.pop(context);

                        }
                      },
                      label: type)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    _storedImage = imageFile;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    newPath = '${appDir.path}/$fileName';

    await imageFile.saveTo(newPath!);
  }
}
