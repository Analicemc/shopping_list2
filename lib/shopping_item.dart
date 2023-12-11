class ShoppingItem {
  String description;
  int quantity;
  bool isBought;
  double unitPrice;
  double totalPrice;

  ShoppingItem({
    required this.description,
    required this.quantity,
    this.isBought = false,
    this.unitPrice = 0.0,
    this.totalPrice = 0.0,
  });
}
