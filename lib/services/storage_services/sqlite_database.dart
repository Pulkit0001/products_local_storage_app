import 'package:path/path.dart';
import 'package:products_storage_app/data_models/product_data_model.dart';
import 'package:sqflite/sqflite.dart';

late Database _database;

const String _PRODUCT_TABLE = "product_table";

Future<void> createInstance() async {
  _database = await openDatabase(
    join(await getDatabasesPath(), 'product_database.db'),
    onUpgrade: (db, version, newVersion) {
      db.execute(
        'CREATE TABLE $_PRODUCT_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, price INTEGER, sale_price INTEGER, colors TEXT, stores TEXT, picture TEXT)',
      );
      print("created");
      return;
    },
    version: 10,
  );
}

Future<bool> addProduct(Product product) async {
  final db = await _database;
  final res = await db.insert(
    _PRODUCT_TABLE,
    product.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  if (res > 0) {
    return true;
  }
  return false;
}

Future<bool> updateProduct(Product product) async {
  try {
    final db = _database;
    await db.update(
      _PRODUCT_TABLE,
      product.toJson(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
    return true;
  } catch (e) {
    print(e.toString());
  }
  return false;
}

Future<List<Product>> getAllProducts() async {
  final db = _database;

  final List<Map<String, dynamic>> maps = await db.query(_PRODUCT_TABLE);

  return List.generate(maps.length, (i) {
    try {
      return Product.fromJson(maps[i]);
    }catch(e){
      print("");
    }
    return Product(id: 0, name: "name", price: 0, salePrice: 0, description: "", colors: [], stores: [], picture:  "");
  });
}

Future<bool> deleteProduct(int id) async {
  try {
    final db = _database;
    await db.delete(
      _PRODUCT_TABLE,
      where: 'id = ?',
      whereArgs: [id],
    );
    return true;
  } catch (e) {
    print(e.toString());
  }
  return false;
}
