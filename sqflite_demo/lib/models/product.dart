class Product {
  int? id;
  late String name;
  late String description;
  late int unitPrice;

  Product.withid(this.id,this.name,this.description,this.unitPrice);
  Product(this.name,this.description,this.unitPrice);


  Map<String,dynamic> toMap(){
    var map=<String,dynamic>{};
    map["name"]=name;
    map["description"]=description;
    map["unitPrice"]=unitPrice;
    if(id!=null){
    map["id"]=id;
    }
    return map;
 
  }
  Product.fromobject(dynamic o){
  
   id=o["id"];
   name=o["name"];
   description=o["description"];
   unitPrice=o["unitPrice"] as int;
  }

}

