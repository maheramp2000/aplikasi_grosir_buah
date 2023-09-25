import 'package:flutter/material.dart';

import 'Pages/Home.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home' : (_) => GroceryStoreHome()
      },
    );
  }
}
