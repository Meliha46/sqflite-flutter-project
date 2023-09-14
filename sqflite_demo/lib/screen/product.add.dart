
import 'package:flutter/material.dart';
import 'package:sqflite_demo/models/product.dart';

import '../controller/dbhelper.dart';

class ProductAdd extends StatefulWidget{
  const ProductAdd({super.key});

  @override
  State<StatefulWidget> createState() {
   return ProductAddState();
  }

}

class ProductAddState extends State{
  var dbhelper=dbHelper();
  TextEditingController txtName= TextEditingController();
  TextEditingController txtDescription=TextEditingController();
  TextEditingController txtunitPrice=TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("Yeni Ürün Ekle"),
     ),
     body: Padding(
       padding: const EdgeInsets.all(30.0),
    child: Column(
    children: <Widget>[
      buildNameField(),buildDescriptionField(),buildunitPriceField(),buildSaveButton()
    ],
    ),
     ));
  }

  buildNameField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Ürün adı"),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Ürün açıklaması"),
      controller: txtDescription,
    );
    
  }

  buildunitPriceField() {
    return TextField(
    decoration: const InputDecoration(labelText: "Birim Fiyatı"),
      controller: txtunitPrice,
    );
  }

  buildSaveButton() {
    return TextButton(
      child: const Text("Ekle"),
      onPressed:() {
        addProduct();
      },

    );
  }

  void addProduct() async{
   await dbhelper.insert(Product(txtName.text,txtDescription.text,txtunitPrice.text as int ) );
   // ignore: use_build_context_synchronously
   Navigator.pop(context,true);
  }
}