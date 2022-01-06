import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_sample/widgets/green_red_circle_container.dart';
import 'package:zartek_sample/widgets/inc_dec_button.dart';

class CartScreenItems extends StatelessWidget {
  final String productId;
  final String title;
  final double calories;
  final double price;
  final int index;
  final int quantity;

  CartScreenItems(this.productId, this.title, this.calories, this.price,
      this.index, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GreenCircleContainer(
              index % 2 == 0 ? Colors.green : Colors.red[300]!),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: IncDecButton(quantity, productId),
                      flex: 2,
                    ),
                    Expanded(
                      child: Text('INR $price'),
                      flex: 1,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('INR ${price * quantity}'),
                const SizedBox(
                  height: 10,
                ),
                Text('Calories $calories')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
