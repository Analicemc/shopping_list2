import 'shopping_list.dart';

class ShoppingItem {
  ShoppingList shopping_list;
  String description;
  int quantity;
  bool isBought;
  double price;

  ShoppingItem({
    required shopping_list,
    required this.description,
    required this.quantity,
    this.isBought = false,
    this.price = 0.0,
  });
}
