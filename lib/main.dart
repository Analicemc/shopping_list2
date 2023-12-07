import 'package:flutter/material.dart';
import 'shopping_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lista de Compras",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShoppingListScreen(),
    );
  }
}
