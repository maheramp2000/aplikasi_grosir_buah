import 'package:flutter/material.dart';
import 'package:aplikasi_kelontong/Pages/groceryDetails.dart';
import 'package:aplikasi_kelontong/Pages/home.dart';

import 'package:aplikasi_kelontong/Providers/groceryProvider.dart';
import 'package:aplikasi_kelontong/Widgets/staggeredDualView.dart';

class GroceryList extends StatelessWidget 
{
  var backgroundColor = Color(0xFFF6F5F2);
  var carBarHeight = 100.0;

  @override
  Widget build(BuildContext context) 
  {
    final bloc = GroceryProvider.of(context)!.bloc;
    
    return Container(
        color: backgroundColor,
        padding: EdgeInsets.only(top: carBarHeight, left: 10, right: 10.0),
        child: StaggeredDualView(
          spacing: 5,
          alturaElement: 0.3,
          aspectRatio: 0.7,
          itemCount: bloc.catalog.length,
          itemBuilder: (context, index){
            
            final product = bloc.catalog[index];

            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                  PageRouteBuilder( 
                    transitionDuration: Duration(milliseconds: 700),
                    pageBuilder: (context, animation, _) {
                    
                    return FadeTransition(
                      opacity: animation,
                      child: GroceryDetails(
                        product: product, 
                        onProductAddres: (){
                          bloc.addProduct(product);
                        }
                      )
                    );
                }));
              },
              child: Card(
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: 
                        Hero(
                          tag: 'list_${product.name}',
                          child: Image.asset(product.image, fit: BoxFit.contain, height: 100)
                        )
                      ),
                      Text('\$${product.price}', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 15,),
                      Text(product.name, style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500 )),
                      Text(product.weight, style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500 )),
                    ],
                  ),
                ),
              ),
            );
          }, 
      ),
    );
  }
}