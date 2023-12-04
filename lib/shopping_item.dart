class ShoppingItem {
  String description;
  int quantity;
  bool isBought;
  double price;

  ShoppingItem({
    required this.description,
    required this.quantity,
    this.isBought = false,
    this.price = 0.0,
  });
}
