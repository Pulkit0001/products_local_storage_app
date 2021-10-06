


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailImageScreen extends StatelessWidget {
  const DetailImageScreen({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.file(
                File(path),
            ),
          ),
        ),
      ),
    );
  }
}
