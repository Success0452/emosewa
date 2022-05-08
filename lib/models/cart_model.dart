import 'package:emosewa/models/popular_product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  int? quantity;
  String? img;
  bool? isExit;
  String? time;
  ProductModel? product;


  CartModel(
      {
        this.id,
        this.name,
        this.price,
        this.img,
        this.quantity,
        this.isExit,
        this.time,
        this.product
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    time = json['time'];
    isExit = json['isExit'];
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic>  toJson(){
    return{
      "id" : this.id,
      "name" : this.name,
      "price" : this.price,
      "quantity" : this.quantity,
      "img" : this.img,
      "isExist" : this.isExit,
      "time" : this.time,
      "product" : this.product!.toJson()
    };
  }

}