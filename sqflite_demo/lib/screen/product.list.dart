


import 'package:flutter/material.dart';

import 'package:sqflite_demo/models/product.dart';
import 'package:sqflite_demo/screen/product.add.dart';

import 'Product.detail.dart';
import '../controller/dbhelper.dart';


class ProductList extends StatefulWidget{
  const ProductList({super.key});

  @override
  State<ProductList> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList> {
  var dbhelper = dbHelper();
  late List<Product> products;
  var productCount = 0;

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        tooltip: "Yeni ürün ekle",
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.black26, child: Text("P"),),
              title: Text(products[position].name),
              subtitle: Text(products[position].description),
              onTap: () {
                goToProductDetail(products[position]);
              },
            ),
          );
        });
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProductAdd()));
    if (result == true) {
        getProducts();
      }
    
  }

  void getProducts() {
    var productFuture = dbHelper().getProduct();
    productFuture.then((data) {
      setState(() {
        products = data;
        productCount = data.length;
      });
    });
 
  }


  void goToProductDetail(Product product) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetails(product)));
    if(result){
        getProducts();
      }
  }
}


