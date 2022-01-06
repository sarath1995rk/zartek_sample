class CartItem {
  final String title;
  final String unit;
  final double price;
  final double calories;
  final String productId;
  final int quantity;

  CartItem(
      {required this.title,
      required this.unit,
      required this.price,
      required this.calories,
      required this.productId,
      required this.quantity});
}
