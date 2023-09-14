
import 'package:flutter/material.dart';
import 'package:sqflite_demo/controller/dbhelper.dart';
import 'package:sqflite_demo/models/product.dart';

// ignore: must_be_immutable
class ProductDetails extends StatefulWidget{
  Product product;
  ProductDetails(this.product, {super.key});

  @override
  State<StatefulWidget> createState() {
   // ignore: no_logic_in_create_state
   return ProductDetailsState(product);
  }

}
enum Options{delete,update}
class ProductDetailsState extends State{
  var dbhelper=dbHelper();
  TextEditingController txtName= TextEditingController();
  TextEditingController txtDescription=TextEditingController();
  TextEditingController txtunitPrice=TextEditingController();
  Product product;
  ProductDetailsState(this.product);
  @override
  void initState() {
    txtName.text=product.name;
    txtDescription.text=product.description;
    txtunitPrice.text=product.unitPrice as String ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ürün Detayı${product.name}"),
          actions: [
            PopupMenuButton<Options>(
              onSelected: selectProcess,
                itemBuilder: (BuildContext context)=><PopupMenuEntry<Options>>[
            const PopupMenuItem<Options>(
                value: Options.delete,
            child: Text("Sil"),
            ),
                  const PopupMenuItem<Options>(
                    value: Options.update,
                    child: Text("Güncelle"),
                  ),

                ],
        )
                  ],),
        body: buildProductDetail(),
        );

  }

  buildProductDetail() {
return  Padding(
       padding: const EdgeInsets.all(30.0),
    child: Column(
    children: <Widget>[
      buildNameField(),buildDescriptionField(),buildunitPriceField()
    ],
    ),
     );

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

  void selectProcess(Options option) async{
    switch(option){
      case Options.delete:
    await dbhelper.delete(product.id! );
   // ignore: use_build_context_synchronously
    Navigator.pop(context,true);
    break;
        case Options.update:
    await dbhelper.update(Product.withid(product.id,txtName.text,txtDescription.text, txtunitPrice.text as int ));
   // ignore: use_build_context_synchronously
    Navigator.pop(context,true);
    break;



   default:
    }
  }
  
}