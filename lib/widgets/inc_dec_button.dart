import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_sample/providers/cart_provider.dart';

class IncDecButton extends StatelessWidget {
  final int qty;
  final String productId;

  IncDecButton(this.qty, this.productId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Provider.of<CartProvider>(context, listen: false)
                  .decrementQuantity(productId);
            },
            child: Container(
              height: 35,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.green[900],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: const Icon(Icons.remove, color: Colors.white),
            ),
          ),
          Container(
            height: 35,
            width: 30,
            color: Colors.green[900],
            alignment: Alignment.center,
            child: Text(
              qty.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          GestureDetector(
            onTap: () {
              Provider.of<CartProvider>(context, listen: false)
                  .incrementQuantity(productId);
            },
            child: Container(
              height: 35,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green[900],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
