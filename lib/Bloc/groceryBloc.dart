import 'package:aplikasi_kelontong/Model/groceryProduct.dart';
import 'package:flutter/material.dart';


enum GroceryState{
  normal,
  details,
  cart
}

class GroceryStoreBloc with ChangeNotifier
{
  GroceryState groceryState = GroceryState.normal;

  List<groceryProduct> catalog = List.unmodifiable(groceryProducts);
  List<GroceryProductItem> cart = [];

  void changeToNormal()
  {
    groceryState = GroceryState.normal;
    notifyListeners();
  }

  void changeToCart()
  {
    groceryState = GroceryState.cart;
    notifyListeners();
  }

  void addProduct(groceryProduct product){

    for(GroceryProductItem item in cart){
      if(item.product.name == product.name){

        item.increment();
        notifyListeners();
        return;
      }
    }

    cart.add(GroceryProductItem(product: product));
    notifyListeners();
  }

  void deleteProduct(GroceryProductItem product){

    cart.remove(product);
    notifyListeners();
  }
  int totalCartElement() => cart.fold<int>(0, (previousValue, element) => previousValue + element.quantity);

  double totalPriceElement() => cart.fold<double>(0.0, (previousValue, element) => previousValue + element.quantity + element.product.price);
}

class GroceryProductItem
{
  int quantity;
  final groceryProduct product;

  GroceryProductItem({this.quantity = 1, required this.product});

  void increment(){
    quantity++;
  }

  void decrement(){}
}