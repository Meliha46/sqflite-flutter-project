

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/product.dart';

// ignore: camel_case_types
class dbHelper {
    Database? _db;

   Future<Database?> get db async{
if(_db==null){
  _db=await initializedb();
}
return _db;
   }

  Future<Database> initializedb() async {
    String dbPath = join(await getDatabasesPath(), "etrade.db");
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database? db, int version) async {
    await db?.execute(
        "Create table products(id integer primary key,name text,description text,unitPrice integer)");
  }

  Future<List<Product>> getProduct() async {
    Database? db = await this.db;
    var result = await db?.query("products");
    return List.generate(result!.length,(i){
    return Product.fromobject(result[i]);
    });
  }
  Future<int?> insert(Product product) async {
    Database? db = await this.db;
    var result = await db?.insert("products", product.toMap());
    return result;
  }
  Future<int?> delete(int id) async {
    Database? db = await this.db;
    var result = await db?.rawDelete("delete from products whereid=$id");
    return result;
  }
  Future<int?> update(Product product) async {
    Database? db = await this.db;
    var result = await db?.update("products", product.toMap(),where: "id=?",whereArgs: [product.id]);
    return result;
  }


}