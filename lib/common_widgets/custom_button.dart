import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_storage_app/services/storage_services/sqlite_database.dart'
    as product_db;

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);

  final Function onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {

        onPressed();
      },
      color: Colors.amber,
      child: Text(label),
    );
  }
}
