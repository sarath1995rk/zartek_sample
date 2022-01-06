import 'package:flutter/foundation.dart';
import 'package:zartek_sample/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    if (_items == null) {
      return 0;
    }
    return _items.length;
  }

  int get productsCount {
    var length = 0;
    if (_items == null) {
      return length;
    }
    _items.forEach((key, value) {
      length += value.quantity * 1;
    });
    return length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
      {String? title,
      String? unit,
      double? price,
      double? calories,
      String? productId}) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId!,
        (existingItem) => CartItem(
            title: existingItem.title,
            quantity: existingItem.quantity + 1,
            price: existingItem.price,
            calories: existingItem.calories,
            productId: existingItem.productId,
            unit: existingItem.unit),
      );
    } else {
      _items.putIfAbsent(
        productId!,
        () => CartItem(
            title: title!,
            quantity: 1,
            price: price!,
            unit: unit!,
            calories: calories!,
            productId: productId),
      );
    }
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void incrementQuantity(String productId) {
    _items.update(
      productId,
      (existingItem) => CartItem(
          title: existingItem.title,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
          calories: existingItem.calories,
          productId: existingItem.productId,
          unit: existingItem.unit),
    );
    notifyListeners();
  }

  void decrementQuantity(String productId) {
    CartItem item =
        _items.values.firstWhere((element) => element.productId == productId);

    if (item.quantity <= 1) {
      _items.removeWhere((key, value) {
        return value.productId == productId;
      });
    } else {
      _items.update(
        productId,
        (existingItem) {
          return CartItem(
              title: existingItem.title,
              quantity: existingItem.quantity - 1,
              price: existingItem.price,
              calories: existingItem.calories,
              productId: existingItem.productId,
              unit: existingItem.unit);
        },
      );
    }

    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
