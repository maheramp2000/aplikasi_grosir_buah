import 'package:flutter/material.dart';
import 'package:aplikasi_kelontong/Providers/groceryProvider.dart';


class GroceryStoreCart extends StatelessWidget 
{
  
  const GroceryStoreCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    final bloc = GroceryProvider.of(context)!.bloc;

    return Padding(
      padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Keranjang',
                    style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),

                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: bloc.cart.length,
                      itemBuilder: ( context, index){

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 7),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(bloc.cart[index].product.image),
                                ),
                                SizedBox(width: 15),
                                Text(bloc.cart[index].quantity.toString(), style: TextStyle(color: Colors.white)),
                                SizedBox(width: 10),
                                Text('x', style: TextStyle(color: Colors.white)),
                                SizedBox(width: 10),
                                Text(bloc.cart[index].product.name, style: TextStyle(color: Colors.white)),
                                Spacer(),
                                Text('\$ ${(bloc.cart[index].product.price * bloc.cart[index].quantity).toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
                                IconButton(icon: Icon(Icons.close, color: Colors.white), onPressed: (){
                                  bloc.deleteProduct(bloc.cart[index]);
                                })
                              ],
                            ),
                          );
                      }
                    ),
                  ),

                ],
              ),
            ),
          ),

          

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [

                Text('Total: ', style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600)),
                Spacer(),
                Text(
                  '\$${bloc.totalPriceElement()}',
                  style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                )

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF4C459)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  )
                )
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text('Lanjut', style: TextStyle(color: Colors.black, fontSize: 16)),
              ),
              onPressed: () => {},
            ),
          )

        ],
      ),
    );
  }
}