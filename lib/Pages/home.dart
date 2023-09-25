import 'package:flutter/material.dart';
import 'package:aplikasi_kelontong/Bloc/groceryBloc.dart';
import 'package:aplikasi_kelontong/Pages/groceryCart.dart';
import 'package:aplikasi_kelontong/Providers/groceryProvider.dart';
import 'package:aplikasi_kelontong/Widgets/groceryList.dart';

const backgroundColor = Color(0xFFF6F5F2);
const carBarHeight = 100.0;
const _panelTransition = Duration(milliseconds: 500);

class GroceryStoreHome extends StatefulWidget 
{
  @override
  _GroceryStoreHomeState createState() => _GroceryStoreHomeState();
}

class _GroceryStoreHomeState extends State<GroceryStoreHome> 
{
  final bloc = GroceryStoreBloc();

  void _onVerticalGesture( DragUpdateDetails details )
  {
    if( details.primaryDelta! < -7 )
    {
      bloc.changeToCart();

    }else if( details.primaryDelta! > 12 )
    {
      bloc.changeToNormal();
    }

  }

  double _getTopForWhitePanel( GroceryState state, Size size )
  {
    if( state == GroceryState.normal )
    {
      return -carBarHeight + kToolbarHeight;
    }else if( state == GroceryState.cart ){

      return -(size.height - kToolbarHeight - carBarHeight / 2);
    }
    return 0.0;
  }

  double _getTopForBlackPanel( GroceryState state, Size size){

    if( state == GroceryState.normal ){

      return size.height - carBarHeight;

    }else if( state == GroceryState.cart ){

      return carBarHeight / 2;

    }
    return 0.0;
  }

  double _getTopForappBar(GroceryState state){

    if( state == GroceryState.normal ){

        return 0.0;
    }
    else if( state == GroceryState.cart ){

        return -carBarHeight;
    }

    return 0.0;
  }


  @override
  Widget build(BuildContext context) 
  {
    final size = MediaQuery.of(context).size;

    return GroceryProvider(
      bloc: bloc,
      child: AnimatedBuilder(
        animation: bloc,
        builder: (context, _) {
          
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          curve: Curves.decelerate,
                          duration: _panelTransition,
                          left: 0,
                          right: 0,
                          top: _getTopForWhitePanel(bloc.groceryState, size),
                          height: size.height - kToolbarHeight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                            child: Container(
                              child: GroceryList(),
                              color: Colors.white,
                            ),
                          )
                        ),
                        AnimatedPositioned(
                          curve: Curves.decelerate,
                          duration: _panelTransition,
                          left: 0,
                          right: 0,
                          top: _getTopForBlackPanel(bloc.groceryState, size),
                          height: size.height - kToolbarHeight,
                          child: GestureDetector(
                            onVerticalDragUpdate: _onVerticalGesture,
                            child: Container(
                              color: Colors.black,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: AnimatedSwitcher(
                                      duration: _panelTransition,
                                      child: bloc.groceryState == GroceryState.normal ? SizedBox(
                                        height: kToolbarHeight,
                                        child: Row(
                                          children: [
                                            Text('Keranjang', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Row(
                                                    children: List.generate(
                                                      bloc.cart.length, 
                                                      (index) => Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                        child: Stack(
                                                          children: [

                                                            Hero(
                                                                tag: 'list_${bloc.cart[index].product.name}details',
                                                                child: CircleAvatar(
                                                                  backgroundColor: Colors.white,
                                                                  backgroundImage: AssetImage(bloc.cart[index].product.image),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              right: 0,
                                                              child: CircleAvatar(
                                                                radius: 10,
                                                                backgroundColor: Colors.red,
                                                                child: Text(bloc.cart[index].quantity.toString(), style: TextStyle(color: Colors.white),),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      )
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Color(0xFFF4C459),
                                              child: Text(bloc.totalCartElement().toString(), style: TextStyle(color: Colors.black)),
                                            )
                                          ],
                                        ),
                                      ) : SizedBox.shrink(),
                                    ),
                                  ),
                                  Expanded(child: GroceryStoreCart())
                                ],
                              ),
                            ),
                          )
                        ),
                        AnimatedPositioned(
                          curve: Curves.decelerate,
                          duration: _panelTransition,
                          top: _getTopForappBar(bloc.groceryState),
                          left: 0,
                          right: 0,
                          child: _AppGrocery(),
                        )
                      ],  
                    ),
                  ),
          );
        },
        
      ),
    );
  }
}

class _AppGrocery extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: backgroundColor,
      child: Row(
        children: [
          BackButton(
            color: Colors.black,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text('Buah-buahan dan sayuran', style: TextStyle(color: Colors.black))
          ),
          IconButton(
            icon: Icon(Icons.settings_rounded),
            onPressed: () => null
          )
        ],
      ),
    );
  }
}